//
//  TutorialViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TutorialViewModelInputs {

    // 変化したIndex値をViewModelへ伝える
    var changeIndexTrigger: ReplaySubject<Int> { get }
}

protocol TutorialViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var tutorialItems: Observable<[TutorialEntity]> { get }

    // 最後のインデックス値に到達したかの判定結果を格納する
    var isLastIndex: Observable<Bool> { get }
}

protocol TutorialViewModelType {
    var inputs: TutorialViewModelInputs  { get }
    var outputs: TutorialViewModelOutputs { get }
}

final class TutorialViewModel: TutorialViewModelInputs, TutorialViewModelOutputs, TutorialViewModelType {

    var inputs: TutorialViewModelInputs { return self }
    var outputs: TutorialViewModelOutputs { return self }

    // MARK: - Properties (for TutorialViewModelInputs)

    // MEMO: ReplaySubjectはBufferSize分の過去のeventを受け取れるSubjectなので、「bufferSize: 1」を利用して1つ前まで取得できるようにする
    let changeIndexTrigger: ReplaySubject<Int> = ReplaySubject<Int>.create(bufferSize: 1)

    // MARK: - Properties (for TutorialViewModelOutputs)

    var tutorialItems: Observable<[TutorialEntity]> {
        return _tutorialItems.asObservable()
    }

    var isLastIndex: Observable<Bool> {
        return _isLastIndex.asObservable()
    }

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _tutorialItems: BehaviorRelay<[TutorialEntity]> = BehaviorRelay<[TutorialEntity]>(value: [])
    private let _isLastIndex: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    // MARK: - Initializer

    init() {
        let tutorialDataList = getTutorialDataFromJson()
        let lastIndex = tutorialDataList.count - 1

        // JSONファイルから取得したModelオブジェクトを中継地点となるBehaviorRelayに格納する
        _tutorialItems.accept(tutorialDataList)
        // インデックス変化時に受け取った値をBehaviorRelayに格納する
        Observable
            // MEMO: この部分で(1つ前の値, 現在の値)を見て変わったタイミングで以降の処理を流す
            // → スクロール位置変化が発生した都度実行されるのでこのようにしている点に注意する
            .zip(changeIndexTrigger, changeIndexTrigger.skip(1))
            .filter { $0.0 != $0.1 }
            .subscribe(
                onNext: { [weak self] (_, currentIndex) in
                    self?._isLastIndex.accept((currentIndex == lastIndex))
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func getTutorialDataFromJson() -> [TutorialEntity] {
        // JSONファイルから表示用のデータを取得してFeaturedModelの型に合致するようにする
        guard let path = Bundle.main.path(forResource: "tutorial_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let tutorialDataList = try? JSONDecoder().decode([TutorialEntity].self, from: data) else {
            fatalError()
        }
        return tutorialDataList
    }
}

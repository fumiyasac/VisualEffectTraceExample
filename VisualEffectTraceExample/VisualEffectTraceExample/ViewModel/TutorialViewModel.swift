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

    // チュートリアル完了をViewModelへ伝える
    var completeTutorialTrigger: PublishSubject<Void> { get }
}

protocol TutorialViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var tutorialItems: Observable<Array<TutorialEntity>> { get }

    // 最後のインデックス値に到達したかの判定結果を格納する
    var isLastIndex: Observable<Bool> { get }

    // チュートリアル完了時のViewController内の処理を実施するためのOutput
    var tutorialFinished: Observable<Bool> { get }
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
    let completeTutorialTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for TutorialViewModelOutputs)

    var tutorialItems: Observable<Array<TutorialEntity>> {
        return _tutorialItems.asObservable()
    }

    var isLastIndex: Observable<Bool> {
        return _isLastIndex.asObservable()
    }

    var tutorialFinished: Observable<Bool> {
        return _tutorialFinished.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    // → 初期値が必要な場合はBehaviorRelay / 初期値が不要な場合にはPublishRelay
    private let _tutorialItems: BehaviorRelay<Array<TutorialEntity>> = BehaviorRelay<Array<TutorialEntity>>(value: [])
    private let _isLastIndex: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private let _tutorialFinished: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "TutorialRepository")) private var tutorialRepository: TutorialRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "ApplicationUserRepository")) private var applicationUserRepository: ApplicationUserRepository

    // MARK: - Initializer

    init() {

        // チュートリアルで表示するためのデータをRepository層経由で取得する
        let tutorialDataList = self.tutorialRepository.getDataList()

        // JSONファイルから取得したModelオブジェクトを中継地点となるBehaviorRelayに格納する
        _tutorialItems.accept(tutorialDataList)

        // インデックス変化時に受け取った値をBehaviorRelayに格納する
        let lastIndex = tutorialDataList.count - 1
        Observable
            // MEMO: この部分で(1つ前の値, 現在の値)を見て変わったタイミングで以降の処理を流す
            // → スクロール位置変化が発生した都度実行されるのでこのようにしている点に注意する
            .zip(changeIndexTrigger, changeIndexTrigger.skip(1))
            .filter { $0.0 != $0.1 }
            .subscribe(
                onNext: { [weak self] (_, currentIndex) in
                    guard let self = self else { return }
                    self._isLastIndex.accept((currentIndex == lastIndex))
                }
            )
            .disposed(by: disposeBag)

        // チュートリアル処理完了時に実行が必要な処理を結びつける
        completeTutorialTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self._tutorialFinished.accept(true)
                    self.applicationUserRepository.updatePassTutorialStatus()
                }
            )
            .disposed(by: disposeBag)
    }
}

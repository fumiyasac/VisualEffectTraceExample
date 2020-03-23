//
//  TutorialDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/24.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol TutorialRepository {

    // チュートリアル画面への表示データ配列を取得する
    func getDataList() -> Array<TutorialEntity>
}

final class TutorialDataRepository: TutorialRepository {
    
    // MARK: - Initializer

    init() {}

    // MARK: - TutorialRepository

    func getDataList() -> Array<TutorialEntity> {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle.main.path(forResource: "tutorial_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let tutorialDataList = try? JSONDecoder().decode(Array<TutorialEntity>.self, from: data) else {
            fatalError()
        }
        return tutorialDataList
    }
}

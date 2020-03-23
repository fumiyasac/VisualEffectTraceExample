//
//  GetTutorialDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/24.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol TutorialUseCase {

    // チュートリアル画面への表示データ配列を取得する
    func execute() -> Array<TutorialEntity>
}

final class GetTutorialDataUseCase: TutorialUseCase {

    private let tutorialRepository: TutorialRepository

    // MARK: - Initializer

    init(tutorialRepository: TutorialRepository) {
        self.tutorialRepository = tutorialRepository
    }

    // MARK: - TutorialUseCase

    func execute() -> Array<TutorialEntity> {
        return tutorialRepository.getDataList()
    }
}

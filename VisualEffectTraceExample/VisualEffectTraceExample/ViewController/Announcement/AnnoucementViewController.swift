//
//  AnnoucementViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class AnnoucementViewController: UIViewController {

    // MARK: - AnnouncementFlow

    var coordinator: AnnouncementFlow?

    // MARK: - Properties

    // MEMO: お知らせ表示状態をハンドリングするViewModel
    private let viewModel = AnnouncementViewModel(
        // MEMO: お知らせデータ取得用のUseCase
        requestAnnouncementDataUseCase: RequestAnnouncementDataUseCase(
            annoucementRepository: RequestAnnoucementDataRepository(
                apiRequestManager: APIRequestManager.shared
            )
        )
    )

    // MARK: - @IBOutlet

    @IBOutlet private weak var announcementTableView: UITableView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Function
}

// MARK: - StoryboardInstantiatable

extension AnnoucementViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Annoucement"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}

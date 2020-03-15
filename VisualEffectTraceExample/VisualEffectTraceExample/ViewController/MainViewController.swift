//
//  MainViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift

// 各種画面への遷移を振り分けるためのViewController

final class MainViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Testing: APIリクエストの試験

        // 一覧表示用のリクエスト
        let api = APIRequestManager.shared
        let _ = api.getAnnoucements()
            .subscribe(
                onSuccess: { data in
                    print(data.result)
                },
                onError: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)

        // 詳細表示用のリクエスト
        let _ = api.getAnnoucementDetailBy(id: 1)
            .subscribe(
                onSuccess: { data in
                    print(data.result)
                },
                onError: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
    }
}

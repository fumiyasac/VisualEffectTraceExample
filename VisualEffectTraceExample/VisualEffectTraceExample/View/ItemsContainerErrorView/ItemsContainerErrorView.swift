//
//  ItemsContainerErrorView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/20.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: - Protocol

// MEMO: View同士の処理の接続はProtocolを経由する方針とする
protocol ItemsContainerErrorViewDelegate: NSObjectProtocol {

    // MEMO: APIリクエストの再実行の処理を画面へ伝える
    func retryRequestButtonTapped()
}

// MEMO: 利用しない場合やIBのエラーが出る場合は`@IBDesignable`をコメントする
//@IBDesignable
final class ItemsContainerErrorView: CustomViewBase {

    // MARK: - ItemsContainerErrorViewDelegate

    weak var delegate: ItemsContainerErrorViewDelegate?

    // MARK: -  Properties

    private let disposeBag = DisposeBag()

    // MARK: - @IBOutlet

    @IBOutlet private weak var retryRequestButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupItemsContainerErrorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupItemsContainerErrorView()
    }

    // MARK: - Private Function

    private func setupItemsContainerErrorView() {

        // ボタン押下時のアクション設定
        retryRequestButton.rx.controlEvent(.touchUpInside)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: APIリクエストの再実行を実施する場合には配置したViewControllerへItemsContainerErrorViewDelegate介して知らせる
                    self.delegate?.retryRequestButtonTapped()
                }
            )
            .disposed(by: disposeBag)
    }
}

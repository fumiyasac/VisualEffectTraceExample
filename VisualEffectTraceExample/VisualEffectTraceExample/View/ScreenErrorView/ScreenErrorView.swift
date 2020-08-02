//
//  ScreenErrorView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: - Protocol

// MEMO: View同士の処理の接続はProtocolを経由する方針とする
protocol ScreenErrorViewDelegate: NSObjectProtocol {

    // MEMO: APIリクエストの再実行の処理を画面へ伝える
    func retryRequestButtonTapped()
}

// MEMO: 利用しない場合やIBのエラーが出る場合は`@IBDesignable`をコメントする
//@IBDesignable
final class ScreenErrorView: CustomViewBase {

    // MARK: - ItemsContainerErrorViewDelegate

    weak var delegate: ScreenErrorViewDelegate?

    // MARK: -  Properties

    private let disposeBag = DisposeBag()

    // MARK: - @IBOutlet

    @IBOutlet private weak var retryRequestButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupScreenErrorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupScreenErrorView()
    }

    // MARK: - Private Function

    private func setupScreenErrorView() {

        // ボタン押下時のアクション設定
        retryRequestButton.rx.controlEvent(.touchUpInside)
            .observeOn(MainScheduler.instance)
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

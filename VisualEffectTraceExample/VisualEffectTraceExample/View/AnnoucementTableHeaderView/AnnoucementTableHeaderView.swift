//
//  AnnoucementTableHeaderView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: - Protocol

// MEMO: View同士の処理の接続はProtocolを経由する方針とする
protocol AnnoucementTableHeaderViewDelegate: NSObjectProtocol {

    // MEMO: 画面を閉じるためのボタンをタップした際の振る舞い
    func closeAnnouncementScreenButtonTapped()
}

final class AnnoucementTableHeaderView: CustomViewBase {

    // MARK: -  FormTextFieldInputViewDelegate

    weak var delegate: AnnoucementTableHeaderViewDelegate?

    // MARK: -  Properties

    static let viewHeight: CGFloat = 90.0

    private let disposeBag = DisposeBag()

    // MARK: - @IBOutlet

    @IBOutlet private weak var closeAnnouncementScreenButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupAnnoucementTableHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupAnnoucementTableHeaderView()
    }

    // MARK: - Private Function

    private func setupAnnoucementTableHeaderView() {

        closeAnnouncementScreenButton.layer.masksToBounds = true
        closeAnnouncementScreenButton.layer.cornerRadius = 18.0

        closeAnnouncementScreenButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.closeAnnouncementScreenButtonTapped()
                }
            )
            .disposed(by: disposeBag)
    }
}

//
//  ItemsEventIntroductionContainerViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BouncyLayout

// MARK: - Protocol

protocol ItemsEventIntroductionContainerDelegate: NSObjectProtocol {

    // MEMO: 表示バナーをタップした際の振る舞い
    func eventIntroductionCellTapped(targetEventIntroductionId: Int)
}

// MEMO: この画面に対応するViewControllerはItems.storyboardに配置している

final class ItemsEventIntroductionContainerViewController: UIViewController {

    // MARK: -  ItemsEventIntroductionContainerDelegate

    weak var delegate: ItemsEventIntroductionContainerDelegate?

    // MARK: - Properties

    // MEMO: 加算分は、UICollectionViewの高さ(256.0px) + 罫線分(2.0px)
    // エラー: 「Make a symbolic breakpoint at UICollectionViewFlowLayoutBreakForInvalidSizes to catch this in the debugger.」を暫定的に回避するため
    static let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 258.0)

    private let disposeBag = DisposeBag()

    // MEMO: イベント概要内容を取得するViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "EventIntroductionViewModelType")) private var viewModel: EventIntroductionViewModelType

    // MARK: - @IBOutlet

    @IBOutlet private weak var eventIntroductionCollectionView: UICollectionView!
    @IBOutlet private weak var eventIntroductionErrorView: ItemsContainerErrorView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupEventIntroductionCollectionView()
        setupEventIntroductionErrorView()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupEventIntroductionCollectionView() {
        
        // UICollectionViewに関する設定
        // MEMO: InterfaceBuilderでscrollDirectionを「Horizontal」に設定しておく
        eventIntroductionCollectionView.isPagingEnabled = false
        eventIntroductionCollectionView.isScrollEnabled = true
        eventIntroductionCollectionView.showsHorizontalScrollIndicator = false
        eventIntroductionCollectionView.showsVerticalScrollIndicator = false
        eventIntroductionCollectionView.registerCustomCell(EventIntroductionCollectionViewCell.self)

        // UICollectionViewに付与するアニメーションに関する設定
        // → ライブラリ「BouncyLayout」を利用してスクロール時にバウンドする表現を加える
        let layout = BouncyLayout(style: .prominent)
        layout.scrollDirection = .horizontal
        eventIntroductionCollectionView.collectionViewLayout = layout

        // 一番最初は非表示状態にしておく
        eventIntroductionCollectionView.isHidden = true
    }

    private func setupEventIntroductionErrorView() {

        // ItemsContainerErrorViewDelegateの宣言
        eventIntroductionErrorView.delegate = self

        // 一番最初は非表示状態にしておく
        eventIntroductionErrorView.isHidden = true
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())

        // RxSwiftを利用して一覧データをUICollectionViewに適用する
        viewModel.outputs.eventIntroductionItems.bind(to: eventIntroductionCollectionView.rx.items) { (collectionView, row, eventIntroductionEntity) in
                let cell = collectionView.dequeueReusableCustomCell(with: EventIntroductionCollectionViewCell.self, indexPath: IndexPath(row: row, section: 0))
                cell.setCell(eventIntroductionEntity)
                cell.setCellDecoration()
                return cell
            }
            .disposed(by: disposeBag)

        // データのセット時に画面の状態を変更する処理
        viewModel.outputs.eventIntroductionItems
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: データ表示用のUICollectionViewとエラー表示用のViewの表示・非表示を決定する
                    self.eventIntroductionCollectionView.isHidden = false
                    self.eventIntroductionErrorView.isHidden = true
                }
            )
            .disposed(by: disposeBag)

        // データのセット時にエラーが発生した場合における処理
        viewModel.outputs.requestStatus
            .observe(on: MainScheduler.instance)
            .filter { requestStatus in
                requestStatus == .error
            }
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: データ表示用のUICollectionViewとエラー表示用のViewの表示・非表示を決定する
                    self.eventIntroductionCollectionView.isHidden = true
                    self.eventIntroductionErrorView.isHidden = false
                }
            )
            .disposed(by: disposeBag)

        // タップ時にセルに紐づいているModelに応じた処理
        eventIntroductionCollectionView.rx.modelSelected(EventIntroductionEntity.self)
            .asSignal()
            .emit(
                onNext: { [weak self] eventIntroductionEntity in
                    guard let self = self else { return }
                    self.delegate?.eventIntroductionCellTapped(targetEventIntroductionId: eventIntroductionEntity.eventIntroductionId)
                }
            )
            .disposed(by: disposeBag)

        // RxSwiftを利用してUICollectionViewDelegateを適用する
        eventIntroductionCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        // スクロール実行時のイベント取得とViewModelでのAPIリクエスト状態の変化をキャッチしてそれぞれの最新状態のイベントを流す
        // → 適切な表現かは自信はありませんが、一応ページネーションを伴ってデータの取得から表示までができてはいるので許容範囲としても良さそうと判断しています...
        Observable.combineLatest(eventIntroductionCollectionView.rx.contentOffset.asObservable(), viewModel.outputs.requestStatus.distinctUntilChanged())
            // MEMO: この部分がないと「Reentrancy anomaly was detected.」の警告が発生してしまうので注意する。
            .observe(on: SerialDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (contentOffset, requestStatus) in
                    guard let self = self else { return }
                    // MEMO: リクエスト実行中の時は以降の処理を行わない
                    if requestStatus == .requesting {
                        return
                    }
                    // MEMO: UIScrollViewが一番右の状態に達した時にAPIリクエストを実行する
                    if contentOffset.x > 0 && (contentOffset.x + self.eventIntroductionCollectionView.frame.size.width > self.eventIntroductionCollectionView.contentSize.width) {
                        self.viewModel.inputs.paginationFetchTrigger.onNext(())
                    }
                }
            )
            .disposed(by: disposeBag)

        // ItemsViewControllerで送信されたNotificationイベントをトリガーとしたPullToRefreshを適用する
        NotificationCenter.default.rx.notification(Notification.Name("EventIntroductionPullToRefresh"), object: nil)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.inputs.pullToRefreshTrigger.onNext(())
                }
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ItemsEventIntroductionContainerViewController: UICollectionViewDelegateFlowLayout {

    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return EventIntroductionCollectionViewCell.cellSize
    }

    // セルの垂直方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    // セルの水平方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    // セル内のアイテム間の余白(margin)調整を行う
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
    }
}

// MWRK: - ItemsContainerErrorViewDelegate

extension ItemsEventIntroductionContainerViewController: ItemsContainerErrorViewDelegate {

    func retryRequestButtonTapped() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.undoAPIRequestStateTrigger.onNext(())
        viewModel.inputs.initialFetchTrigger.onNext(())
    }
}

// MARK: - StoryboardInstantiatable

extension ItemsEventIntroductionContainerViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Items"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return "ItemsEventIntroductionContainer"
    }
}

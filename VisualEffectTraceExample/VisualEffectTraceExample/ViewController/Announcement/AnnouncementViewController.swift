//
//  AnnouncementViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MEMO: Reduxを利用する必要が特段なさそう(ViewModel側のハンドリングだけで済んでしまう)な場合は無理にしなくても良さそうかと思います。
// → 必要に応じて画面の状態管理に関する処理を補うような位置付けでも良いかも個人的には感じる部分もある

final class AnnouncementViewController: UIViewController {

    // MARK: - AnnouncementFlow

    var coordinator: AnnouncementFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: お知らせ表示状態をハンドリングするViewModel
    private let viewModel = AnnouncementViewModel(
        // MEMO: お知らせデータ取得用のUseCase
        requestAnnouncementDataUseCase: RequestAnnouncementDataUseCase(
            annoucementRepository: RequestAnnoucementDataRepository(
                apiRequestManager: APIRequestManager.shared
            )
        )
    )

    // UITableViewに設置するRefreshControl
    private let announcementRefrashControl = UIRefreshControl()

    // MARK: - @IBOutlet

    @IBOutlet private weak var announcementTableView: UITableView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnnouncementTableVieww()
        bindToRxSwift()
    }

    // MARK: - Private Function

    private func setupAnnouncementTableVieww() {

        // UITableViewに関する設定
        // MEMO: Interface Builder上で下記の設定をしている
        // (1) BackgroundColor: Clear
        // (2) Separatot Inset: Left(15) / Right(15)
        announcementTableView.refreshControl = announcementRefrashControl
        announcementTableView.estimatedRowHeight = 385.0
        announcementTableView.rowHeight = UITableView.automaticDimension
        announcementTableView.delaysContentTouches = false
        announcementTableView.registerCustomCell(AnnouncementTableViewCell.self)
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.initialFetchTrigger.onNext(())

        // RxSwiftを利用して一覧データをUITableViewに適用する
        // MEMO: UITableViewのHeader/FooterはUITableViewDelegateで組み立てていく方針です。
        viewModel.announcementItems
            .bind(to: announcementTableView.rx.items) { (tableView, row, announcementEntity) in
                let cell = tableView.dequeueReusableCustomCell(with: AnnouncementTableViewCell.self)
                cell.setCell(announcementEntity)
                return cell
            }
            .disposed(by: disposeBag)
        viewModel.requestStatus
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] requestStatus in
                    guard let self = self else { return }

                    // MEMO: RefreshControlのハンドリングを実施する
                    if requestStatus == .requesting {
                        self.announcementRefrashControl.beginRefreshing()
                    } else {
                        self.announcementRefrashControl.endRefreshing()
                    }
                }
            )
            .disposed(by: disposeBag)

        // UITableViewDelegateを適用する
        announcementTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        // UITableViewの「Pull to Refresh」に関する処理
        announcementRefrashControl.rx.controlEvent(.valueChanged)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: UITableViewの「Pull to Refresh」を実行する
                    self.viewModel.pullToRefreshTrigger.onNext(())
                }
            )
            .disposed(by: disposeBag)

        // UITableViewのスクロール実施中に関する処理
        // ※ UIScrollViewDelegateのscrollViewDidScrollに相当する
        announcementTableView.rx
            .didScroll
            .asObservable()
            // MEMO: この部分がないと「Reentrancy anomaly was detected.」の警告が発生してしまうので注意する。
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: スクロールの変化量に応じてUITableViewHeaderのTOP方向のオフセット値を調整する
                    self.adjustAnnouncementTableViewTopOffset()
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Fucntion

    private func adjustAnnouncementTableViewTopOffset() {

        // MEMO: 現在画面に表示されているセルを抽出する
        if let visibleRows = announcementTableView.indexPathsForVisibleRows, let firstVisibleRows = visibleRows.first {

            // MEMO: 現在画面に表示されているセルからセクションHeaderを抽出する
            let visibleHeaderInSection = announcementTableView.rectForHeader(inSection: firstVisibleRows.section)
            let headerHeight = visibleHeaderInSection.size.height

            // MEMO: さらに現在表示されている高さを取得してUIEdgeInsetsのtop方向のオフセット値へ加算する
            let topOffset = max(min(0, -announcementTableView.contentOffset.y), -headerHeight)
            announcementTableView.contentInset = UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - UITableViewDelegate

extension AnnouncementViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // MEMO: ヘッダー部分の配置とその中のプロトコルを適用する
        let headerView = AnnoucementTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: AnnoucementTableHeaderView.viewHeight))
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AnnoucementTableHeaderView.viewHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

// MARK: - AnnoucementTableHeaderViewDelegate

extension AnnouncementViewController: AnnoucementTableHeaderViewDelegate {

    func closeAnnouncementScreenButtonTapped() {

        // MEMO: 画面の状態を元に戻して、サインイン画面へ戻る
        coordinator?.dismissSignin()
    }
}

// MARK: - StoryboardInstantiatable

extension AnnouncementViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Announcement"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}

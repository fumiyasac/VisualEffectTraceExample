//
//  ItemsViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MEMO: 基本方針としてはiOS13で登場したUICollectionViewCompositionalLayoutで構築し、NSDiffableDataSourceを利用して内容の更新を実施する方針を採っています。
// 今回の事例では、UICollectionViewCompositionalLayoutで全部まとめられそうだけど実はそうでもない？ような例
// - 時限式(タイマー処理)のCarouselを入れる場合
// - セル要素の変形処理やAnimation処理がセルをスワイプした際に付与する必要がある場合
// - 無限循環型のスクロールが必要な場合

// ※1) この画面状態における細かなコントロールについては、Reduxを利用して状態をコントロールを実行する形にしています。
// ※2) UICollectionViewCompositionalLayoutのおかげでSelf-Sizingは結構しやすいと思います。

// 補足: 従来通りの方法で1行単位のSelf-Sizingを実施する場合:
// https://appitventures.com/self-sizing-cells-tableview-and-collectionview-in-ios-using-swift/
// https://www.vadimbulavin.com/collection-view-cells-self-sizing/

// 補足: iOS12以前の場合に、WatefallLayout(MasonryLayout)を実現する場合は、UICollectionViewLayoutクラスを継承した方針を採ります（結構ハードモードです）。
// ※ Pinterestの様なWatefallLayout(MasonryLayout)についてもUICollectionViewCompositionalLayoutでも実際結構難しい。
// https://gist.github.com/vlainvaldez/dec5c6138e67ef49141172c9bd0a4d36

// 下記の様な形のライブラリを活用する方針でもエレガントな実装ができると思います。
// https://github.com/sgr-ksmt/WaterfallLayout

// その他の実装について: どのライブラリもUICollectionViewLayoutクラスを継承した方針で作成されている点は同じです。
// (1) https://github.com/Jinya/WaterflowLayout
// (2) https://github.com/ecerney/CollectionViewWaterfallLayout

final class ItemsViewController: UIViewController {

    // MARK: - ItemsFlow

    var coordinator: ItemsFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: UICollectionViewCellへContainerViewとして配置する画面
    private let itemsTopBannerContainerViewController = ItemsTopBannerContainerViewController.instantiate()
    private let itemsEventIntroductionContainerViewController = ItemsEventIntroductionContainerViewController.instantiate()
    
    // UICollectionViewに設置するRefreshControl
    private let itemRefrashControl = UIRefreshControl()

    // MEMO: 表示内容をハンドリングするViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "ItemsViewModelType")) private var viewModel: ItemsViewModelType

    // MARK: - Properties (for UICollectionViewCompositionalLayout)

    // MEMO: UICollectionViewを差分更新するためのNSDiffableDataSourceSnapshot
    private var snapshot: NSDiffableDataSourceSnapshot<ItemsScreenSectionType, AnyHashable>!

    // MEMO: UICollectionViewを組み立てるためのDataSource
    private var dataSource: UICollectionViewDiffableDataSource<ItemsScreenSectionType, AnyHashable>! = nil

    // MEMO: UICollectionViewCompositionalLayoutの設定（※Sectionごとに読み込ませて利用する）
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            switch sectionIndex {

            case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():
                return ItemsScreenSectionType.itemsTopBanner.getSectionLayout()

            case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():
                return ItemsScreenSectionType.itemsEventIntroduction.getSectionLayout()

            case ItemsScreenSectionType.itemsRecentAnnoucement.getSectionIndex():
                return ItemsScreenSectionType.itemsRecentAnnoucement.getSectionLayout()

            case ItemsScreenSectionType.itemsRegularList.getSectionIndex():
                return ItemsScreenSectionType.itemsRegularList.getSectionLayout()

            default:
                fatalError()
            }
        }
        return layout
    }()

    // MARK: - @IBOutlet

    @IBOutlet private weak var itemCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.items.getGlobalTabBarTitle())
        setupItemCollectionView()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupItemCollectionView() {

        // UICollectionViewに関する設定
        itemCollectionView.refreshControl = itemRefrashControl
        itemCollectionView.showsVerticalScrollIndicator = true
        itemCollectionView.registerCustomReusableHeaderView(ItemListCollectionHeaderView.self)
        itemCollectionView.registerCustomCell(ContainerCollectionViewCell.self)
        itemCollectionView.registerCustomCell(RecentAnnouncementCollectionViewCell.self)
        itemCollectionView.registerCustomCell(ItemCollectionViewCell.self)

        // MEMO: UICollectionViewCompositionalLayoutを利用してレイアウトを組み立てる
        itemCollectionView.collectionViewLayout = compositionalLayout

        // MEMO: DataSourceはUICollectionViewDiffableDataSourceを利用してUICollectionViewCellを継承したクラスを組み立てる
        dataSource = UICollectionViewDiffableDataSource<ItemsScreenSectionType, AnyHashable>(collectionView: itemCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, model: AnyHashable) -> UICollectionViewCell? in

            // MEMO:
            // 0: itemsTopBanner, 1: itemsEventIntroductionは別画面で定義した画面クラスを読み込むためのContainerViewとして利用する
            // 2: itemsRecentAnnoucement, 3: itemsRegularListは画面遷移をせずに表示だけを行う
            // ※3の補足事項:
            // 並べ方はInstagramの検索画面の様な形で、かつある程度の表示ができたタイミングで滑らかに次の要素が表示される形にする
            switch indexPath.section {

            case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():

                let cell = collectionView.dequeueReusableCustomCell(with: ContainerCollectionViewCell.self, indexPath: indexPath)
                self.itemsTopBannerContainerViewController.delegate = self
                let targetViewController = self.itemsTopBannerContainerViewController
                let viewControllerInfo = ContainerCollectionViewCell.DisplayViewControllerInContainerViewInformation(
                    targetViewController: targetViewController,
                    parentViewController: self
                )
                cell.setCell(viewControllerInfo)
                return cell

            case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():

                let cell = collectionView.dequeueReusableCustomCell(with: ContainerCollectionViewCell.self, indexPath: indexPath)
                self.itemsEventIntroductionContainerViewController.delegate = self
                let targetViewController = self.itemsEventIntroductionContainerViewController
                let viewControllerInfo = ContainerCollectionViewCell.DisplayViewControllerInContainerViewInformation(
                    targetViewController: targetViewController,
                    parentViewController: self
                )
                cell.setCell(viewControllerInfo)
                return cell

            case ItemsScreenSectionType.itemsRecentAnnoucement.getSectionIndex():

                let cell = collectionView.dequeueReusableCustomCell(with: RecentAnnouncementCollectionViewCell.self, indexPath: indexPath)
                switch model {
                case let model as AnnouncementEntity:
                    cell.setCell(model)
                    return cell
                default:
                    return UICollectionViewCell()
                }

            case ItemsScreenSectionType.itemsRegularList.getSectionIndex():

                let cell = collectionView.dequeueReusableCustomCell(with: ItemCollectionViewCell.self, indexPath: indexPath)
                switch model {
                case let model as ItemEntity:
                    cell.setCell(model)
                    return cell
                default:
                    return UICollectionViewCell()
                }

            default:
                return nil
            }
        }

        // MEMO: Header・Footerの表記についてもUICollectionViewDiffableDataSourceを利用して組み立てる
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in

            switch indexPath.section {

            case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableCustomHeaderView(with: ItemListCollectionHeaderView.self, indexPath: indexPath)
                    header.setHeader(
                        title: ItemsScreenSectionType.itemsTopBanner.getSectionTitle(),
                        description: ItemsScreenSectionType.itemsTopBanner.getSectionDescription()
                    )
                    return header
                }

            case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableCustomHeaderView(with: ItemListCollectionHeaderView.self, indexPath: indexPath)
                    header.setHeader(
                        title: ItemsScreenSectionType.itemsEventIntroduction.getSectionTitle(),
                        description: ItemsScreenSectionType.itemsEventIntroduction.getSectionDescription()
                    )
                    return header
                }

            case ItemsScreenSectionType.itemsRecentAnnoucement.getSectionIndex():
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableCustomHeaderView(with: ItemListCollectionHeaderView.self, indexPath: indexPath)
                    header.setHeader(
                        title: ItemsScreenSectionType.itemsRecentAnnoucement.getSectionTitle(),
                        description: ItemsScreenSectionType.itemsRecentAnnoucement.getSectionDescription()
                    )
                    return header
                }

            case ItemsScreenSectionType.itemsRegularList.getSectionIndex():
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableCustomHeaderView(with: ItemListCollectionHeaderView.self, indexPath: indexPath)
                    header.setHeader(
                        title: ItemsScreenSectionType.itemsRegularList.getSectionTitle(),
                        description: ItemsScreenSectionType.itemsRegularList.getSectionDescription()
                    )
                    return header
                }

            default:
                break
            }
            return nil
        }

        // 表示内容を格納するDataSourceの初期化
        initializeDiffableDataSource()
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())

        // 最新のお知らせ情報取得時のUICollectionViewへの反映処理
        viewModel.outputs.recentAnnouncement
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] newRecentAnnouncement in
                    guard let self = self else { return }

                    // MEMO: NSDiffableDataSourceを利用した最新のお知らせセクション表示データの差分更新処理
                    let oldRecentAnnouncement = self.snapshot.itemIdentifiers(inSection: .itemsRecentAnnoucement)
                    self.snapshot.deleteItems(oldRecentAnnouncement)
                    self.snapshot.appendItems([newRecentAnnouncement], toSection: .itemsRecentAnnoucement)
                    self.dataSource.apply(self.snapshot, animatingDifferences: false)
                }
            )
            .disposed(by: disposeBag)

        // アイテム取得時のUICollectionViewへの反映処理
        viewModel.outputs.items
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] newItems in
                    guard let self = self else { return }

                    // MEMO: NSDiffableDataSourceを利用したアイテムセクション表示データの差分更新処理
                    let oldItems = self.snapshot.itemIdentifiers(inSection: .itemsRegularList)
                    self.snapshot.deleteItems(oldItems)
                    self.snapshot.appendItems(newItems, toSection: .itemsRegularList)
                    self.dataSource.apply(self.snapshot, animatingDifferences: false)
                }
            )
            .disposed(by: disposeBag)

        // PullToRefreshを適用する
        itemRefrashControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .delay(.milliseconds(640), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] newItems in
                    guard let self = self else { return }
                    self.viewModel.inputs.pullToRefreshTrigger.onNext(())
                }
            )
            .disposed(by: disposeBag)
        viewModel.outputs.requestStatus
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] requestStatus in
                    guard let self = self else { return }

                    // MEMO: RefreshControlのハンドリングを実施する
                    if requestStatus == .requesting {
                        self.itemRefrashControl.beginRefreshing()
                    } else {
                        self.itemRefrashControl.endRefreshing()
                    }
                }
            )
            .disposed(by: disposeBag)
        
        // スクロール実行時のイベント取得とViewModelでのAPIリクエスト状態の変化をキャッチしてそれぞれの最新状態のイベントを流す
        // → 適切な表現かは自信はありませんが、一応ページネーションを伴ってデータの取得から表示までができてはいるので許容範囲としても良さそうと判断しています...
        Observable.combineLatest(itemCollectionView.rx.contentOffset.asObservable(), viewModel.outputs.requestStatus.distinctUntilChanged())
            // MEMO: この部分がないと「Reentrancy anomaly was detected.」の警告が発生してしまうので注意する。
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (contentOffset, requestStatus) in
                    guard let self = self else { return }

                    // MEMO: リクエスト実行中の時は以降の処理を行わない
                    if requestStatus == .requesting {
                        return
                    }

                    // MEMO: UIScrollViewが一番下の状態に達した時にAPIリクエストを実行する
                    // 補足: https://stackoverflow.com/questions/49782874/detecting-if-a-uiscrollview-has-the-height-to-scroll
                    if contentOffset.y > 0 && (contentOffset.y + self.itemCollectionView.frame.size.height > self.itemCollectionView.contentSize.height) {
                        self.viewModel.inputs.paginationFetchTrigger.onNext(())
                    }
                }
            )
            .disposed(by: disposeBag)
    }

    // MEMO: NSDiffableDataSourceSnapshotの初期化処理
    private func initializeDiffableDataSource() {

        snapshot = NSDiffableDataSourceSnapshot<ItemsScreenSectionType, AnyHashable>()
        snapshot.appendSections(ItemsScreenSectionType.allCases)
        for section in ItemsScreenSectionType.allCases {
            if [ItemsScreenSectionType.itemsTopBanner, ItemsScreenSectionType.itemsEventIntroduction].contains(section) {
                // MEMO: データを表示するセルではないので適当な値をAnyHashableにして入れる
                snapshot.appendItems([AnyHashable(section)], toSection: section)
            } else {
                snapshot.appendItems([], toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - ItemsTopBannerContainerDelegate

extension ItemsViewController: ItemsTopBannerContainerDelegate {

    func topBannerCellTapped(targetBannerContentsId: Int) {

        // TODO: 取得したトップバナーコンテンツIDを元に該当画面へ遷移する処理
        print("targetBannerContentsId:", targetBannerContentsId)
    }
}

// MARK: - ItemsEventIntroductionContainerDelegate

extension ItemsViewController: ItemsEventIntroductionContainerDelegate {

    func eventIntroductionCellTapped(targetEventIntroductionId: Int) {

        // TODO: 取得したイベント概要IDを元に該当画面へ遷移する処理
        print("targetEventIntroductionId:", targetEventIntroductionId)
    }
}

// MARK: - StoryboardInstantiatable

extension ItemsViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Items"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}

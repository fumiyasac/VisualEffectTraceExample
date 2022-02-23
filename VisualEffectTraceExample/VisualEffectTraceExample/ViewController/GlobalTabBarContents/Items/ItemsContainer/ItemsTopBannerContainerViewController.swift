//
//  ItemsTopBannerContainerViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AnimatedCollectionViewLayout

// MARK: - Protocol

protocol ItemsTopBannerContainerDelegate: NSObjectProtocol {

    // MEMO: 表示バナーをタップした際の振る舞い
    func topBannerCellTapped(targetBannerContentsId: Int)
}

// MEMO: この画面に対応するViewControllerはItems.storyboardに配置している

final class ItemsTopBannerContainerViewController: UIViewController {

    // MARK: -  ItemsTopBannerContainerDelegate

    weak var delegate: ItemsTopBannerContainerDelegate?

    // MARK: - Properties

    // MEMO: 加算分は、UIPageControl表示エリアの高さ(48.0px)
    static let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: ceil(UIScreen.main.bounds.width * 126.0 / 375.0) + 48.0)

    private let disposeBag = DisposeBag()

    // MEMO: トップバナー表示内容を取得するViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "TopBannerViewModelType")) private var viewModel: TopBannerViewModelType

    // MEMO: トップバナーを時限式で動かすために必要な値
    // トップバナー表示におけるCarousel表現用のタイマー用のトリガー
    private let carouselIntervalTrigger: Observable<Int> = Observable.interval(.milliseconds(5000), scheduler: MainScheduler.instance)
    // 現在のスクロール実行状態
    private let bannerScrolling: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    // 現在選択されているインデックス値
    private let currentIndex: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)

    // MARK: - @IBOutlet

    @IBOutlet private weak var topBannerCollectionView: UICollectionView!
    @IBOutlet private weak var topBannerPrevButton: UIButton!
    @IBOutlet private weak var topBannerNextButton: UIButton!
    @IBOutlet private weak var topBannerPageControl: UIPageControl!
    @IBOutlet private weak var topBannerErrorView: ItemsContainerErrorView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTopBannerCollectionView()
        setupTopBannerPageControl()
        setupPreviousAndNextButtons()
        setupTopBannerErrorView()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupTopBannerCollectionView() {

        // UICollectionViewに関する設定
        topBannerCollectionView.isPagingEnabled = true
        topBannerCollectionView.isScrollEnabled = false
        topBannerCollectionView.showsHorizontalScrollIndicator = false
        topBannerCollectionView.showsVerticalScrollIndicator = false
        topBannerCollectionView.registerCustomCell(TopBannerCollectionViewCell.self)

        // UICollectionViewに付与するアニメーションに関する設定
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ParallaxAttributesAnimator()
        layout.scrollDirection = .horizontal
        topBannerCollectionView.collectionViewLayout = layout

        // 一番最初は非表示状態にしておく
        topBannerCollectionView.isHidden = true
    }
    
    private func setupTopBannerPageControl() {

        // PageControlのデザイン調整
        topBannerPageControl.currentPageIndicatorTintColor = UIColor.systemYellow
        topBannerPageControl.pageIndicatorTintColor = UIColor.lightGray
    }
    
    private func setupPreviousAndNextButtons() {

        // 戻るボタンのデザイン調整
        topBannerPrevButton.layer.masksToBounds = true
        topBannerPrevButton.layer.cornerRadius = 20.0
        topBannerPrevButton.alpha = 0.7

        // 次へボタンのデザイン調整
        topBannerNextButton.layer.masksToBounds = true
        topBannerNextButton.layer.cornerRadius = 20.0
        topBannerNextButton.alpha = 0.7
    }

    private func setupTopBannerErrorView() {

        // ItemsContainerErrorViewDelegateの宣言
        topBannerErrorView.delegate = self

        // 一番最初は非表示状態にしておく
        topBannerErrorView.isHidden = true
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())

        // RxSwiftを利用して一覧データをUICollectionViewに適用する
        viewModel.outputs.topBannerItems.bind(to: topBannerCollectionView.rx.items) { (collectionView, row, topBannerEntity) in
                let cell = collectionView.dequeueReusableCustomCell(with: TopBannerCollectionViewCell.self, indexPath: IndexPath(row: row, section: 0))
                cell.setCell(topBannerEntity)
                return cell
            }
            .disposed(by: disposeBag)
 
        // データのセット時に左右に配置しているボタン及び画面の状態を変更する処理
        viewModel.outputs.topBannerItems
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] topBanners in
                    guard let self = self else { return }
 
                    // MEMO: データ表示用のUICollectionViewとエラー表示用のViewの表示・非表示を決定する
                    self.topBannerCollectionView.isHidden = false
                    self.topBannerErrorView.isHidden = true

                    // MEMO: PageControl部分の設定をする
                    let totalCount = topBanners.count
                    self.topBannerPageControl.numberOfPages = totalCount
                    self.changeArrowButtonsState(at: 0, totalCount: totalCount)
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
                onNext: { [weak self] topBanners in
                    guard let self = self else { return }

                    // MEMO: データ表示用のUICollectionViewとエラー表示用のViewの表示・非表示を決定する
                    self.topBannerCollectionView.isHidden = true
                    self.topBannerErrorView.isHidden = false
                }
            )
            .disposed(by: disposeBag)

        // タップ時にセルに紐づいているModelに応じた処理
        topBannerCollectionView.rx.modelSelected(TopBannerEntity.self)
            .asSignal()
            .emit(
                onNext: { [weak self] topBannerEntity in
                    guard let self = self else { return }
                    self.delegate?.topBannerCellTapped(targetBannerContentsId: topBannerEntity.bannerContentsId)
                }
            )
            .disposed(by: disposeBag)

        // RxSwiftを利用してUICollectionViewDelegateを適用する
        topBannerCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        // RxSwiftを利用してUIScrollViewDelegateに相当する処理を適用する
        // バナーデータのタイマーに伴ったカルーセル表示処理
        topBannerCollectionView.rx.didScroll
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    // MEMO: Scroll実行中はタイマーをリセットする → バナーのスクロール状態変数をtrue
                    let _ = self.carouselIntervalTrigger.startWith(0)
                    self.bannerScrolling.accept(true)
                }
            )
            .disposed(by: disposeBag)
        topBannerCollectionView.rx.didEndDecelerating
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    // MEMO: ユーザーのスライド動作終了時に発火する → バナーのスクロール状態変数をfalse
                    self.bannerScrolling.accept(false)
                }
            )
            .disposed(by: disposeBag)
        topBannerCollectionView.rx.didEndScrollingAnimation
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    // MEMO: タイマーと連動したスクロール動作終了時に発火する → バナーのスクロール状態変数をfalse
                    self.bannerScrolling.accept(false)
                }
            )
            .disposed(by: disposeBag)

        // RxSwiftを利用してバナーのスクロール状態に応じた表示コントロール処理を適用する
        bannerScrolling
            // MEMO: バナーのスクロール状態変数をObsevableへ変換する
            .asObservable()
            // MEMO: バナーのスクロール状態変数で最新のものがfalseの際に、自動カルーセル回転アニメーションの秒間設定のObservableへ変換する
            .flatMapLatest { [unowned self] result in result ? .empty() : self.carouselIntervalTrigger }
            // MEMO: バナーの切り替え処理を実行する
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.displayPreviousOrNextTopBannerCell(shouldNext: true)
                }
            )
            .disposed(by: disposeBag)

        // RxSwiftを利用して前へボタン＆次へボタン押下時の表示位置の変更をする
        topBannerNextButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.displayPreviousOrNextTopBannerCell(shouldNext: true)
                }
            )
            .disposed(by: disposeBag)
        topBannerPrevButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.displayPreviousOrNextTopBannerCell(shouldNext: false)
                }
            )
            .disposed(by: disposeBag)

        // UIPageControlとUICollectionViewの位置関係を調節する
        currentIndex
            .asObservable()
            .bind(to: topBannerPageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }

    // MEMO: バナーエリアの左右に配置しているボタンのハンドリングをする
    private func displayPreviousOrNextTopBannerCell(shouldNext: Bool = true) {
        let totalCount = topBannerPageControl.numberOfPages
        if totalCount <= 1 {
            return
        }
        let targetCount: Int
        if shouldNext {
            targetCount = (currentIndex.value + 1) % (totalCount)
        } else {
            targetCount = (currentIndex.value == 0) ? (totalCount - 1) % (totalCount) : (currentIndex.value - 1) % (totalCount)
        }
        topBannerCollectionView.scrollToItem(at: IndexPath(row: targetCount, section: 0), at: .left, animated: true)
        currentIndex.accept(targetCount)
        changeArrowButtonsState(at: targetCount, totalCount: totalCount)
    }

    // MEMO: バナーエリアの左右に配置しているボタンのハンドリングをする
    private func changeArrowButtonsState(at currentIndex: Int, totalCount: Int) {
        switch (currentIndex, totalCount) {
        // 取得データ総数が0の場合
        case (_, totalCount) where totalCount <= 1:
            topBannerPrevButton.isHidden = true
            topBannerNextButton.isHidden = true
        // 現在表示対象のセルにおけるインデックス値が0の場合
        case (0, _):
            topBannerPrevButton.isHidden = true
            topBannerNextButton.isHidden = false
        // 現在表示対象のセルにおけるインデックス値が(取得データ総数 - 1)の場合
        case (currentIndex, totalCount) where currentIndex == totalCount - 1:
            topBannerPrevButton.isHidden = false
            topBannerNextButton.isHidden = true
        // 上記のどの条件にも合致しない場合
        default:
            topBannerPrevButton.isHidden = false
            topBannerNextButton.isHidden = false
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ItemsTopBannerContainerViewController: UICollectionViewDelegateFlowLayout {

    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TopBannerCollectionViewCell.cellSize
    }

    // セルの垂直方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    // セルの水平方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    // セル内のアイテム間の余白(margin)調整を行う
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

// MWRK: - ItemsContainerErrorViewDelegate

extension ItemsTopBannerContainerViewController: ItemsContainerErrorViewDelegate {

    func retryRequestButtonTapped() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())
    }
}

// MARK: - StoryboardInstantiatable

extension ItemsTopBannerContainerViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Items"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return "ItemsTopBannerContainer"
    }
}

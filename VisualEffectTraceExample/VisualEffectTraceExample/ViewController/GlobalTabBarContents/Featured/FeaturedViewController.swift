//
//  FeaturedViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// UICollectionViewCompositionalLayoutでは実現が難しいかもしれない表現の例（2）
// MEMO: Safariのタブの様な動きをUICollectionViewを利用して実施する
// → UICollectionViewLayoutを継承したクラスをセルタップ時 or セル内のボタン押下時に切り替えて適用する形で実現する
// https://github.com/AfrozZaheer/AZSafariCollectionViewLayout
// https://github.com/gringoireDM/LNZCollectionLayouts

final class FeaturedViewController: UIViewController {

    // MARK: - Properties

    // MEMO: 配置したUICollectionViewにおける下方向オフセット値を調整するための定数
    private let adjustedContentInsetBottom: CGFloat = 82.0

    // MEMO: セルごとの間隔を調整するための定数
    private let adjustedTargetItemGap: CGFloat = 188.0
    
    // バインダー型のUICollectionViewCellを開いた状態にするレイアウト属性クラス
    private let expandedFileBinderLayout = ExpandedFileBinderCollectionViewLayout()

    // バインダー型のUICollectionViewCellを閉じた状態にするレイアウト属性クラス
    private let indexFileBinderLayout = IndexFileBinderCollectionViewLayout()

    // バインダー型のUICollectionViewCellの状態ハンドリング用の変数
    private var shouldExpandCell = false

    private let disposeBag = DisposeBag()

    private let featuredArticleItems: BehaviorRelay<Array<FeaturedArticleEntity>> = BehaviorRelay<Array<FeaturedArticleEntity>>(value: [])

    // MEMO: 表示内容を取得するViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "FeaturedArticleViewModelType")) private var viewModel: FeaturedArticleViewModelType

    // MARK: - @IBOutlet

    @IBOutlet private weak var featuredCollectionView: UICollectionView!
    @IBOutlet private weak var featuredErrorView: ScreenErrorView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.featured.getGlobalTabBarTitle())
        setupCollectionView()
        setupFeaturedErrorView()
        bindToRxSwift()
    }

    // MARK: - Private Function

    private func setupCollectionView() {

        // UICollectionViewに関する初期設定
        featuredCollectionView.bounces = false
        featuredCollectionView.registerCustomCell(FeaturedCollectionViewCell.self)
        featuredCollectionView.contentInset.bottom = adjustedContentInsetBottom

        // MEMO: UICollectionViewのDelegate/DataSourceの宣言
        // ※ RxSwiftを利用した宣言方法もあるが、この方法だと却って処理が書きにくい場合にはデータをセットするする部分だけをRxSwiftで書いて残りは従来通りの記載方法でも良いかもしれません。
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self

        // UICollectionViewに付与するUICollectionViewLayoutを継承したクラスを付与する
        featuredCollectionView.setCollectionViewLayout(indexFileBinderLayout, animated: true)
        if let targetCollectionView = self.featuredCollectionView {
            indexFileBinderLayout.height = targetCollectionView.frame.size.height
            indexFileBinderLayout.targetItemGap = adjustedTargetItemGap
        }
    }

    private func setupFeaturedErrorView() {

        // ScreenErrorViewDelegateの宣言
        featuredErrorView.delegate = self

        // 一番最初は非表示状態にしておく
        featuredErrorView.isHidden = true
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())

        // RxSwiftを利用して一覧データをUICollectionViewに適用する
        viewModel.outputs.featuredArticleItems
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] featuredArticleItems in
                    guard let self = self else { return }

                    // MEMO: データ表示用のUICollectionViewとエラー表示用のViewの表示・非表示を決定する
                    self.featuredCollectionView.isHidden = false
                    self.featuredErrorView.isHidden = true

                    // MEMO: 表示内容の反映処理を実行する
                    self.featuredArticleItems.accept(featuredArticleItems)
                    self.featuredCollectionView.reloadData()
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
                    self.featuredCollectionView.isHidden = true
                    self.featuredErrorView.isHidden = false
                }
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegate

extension FeaturedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // MEMO: 配置しているセルに対する処理を実施する場合に利用する
        let cell = collectionView.cellForItem(at: indexPath) as! FeaturedCollectionViewCell

        DispatchQueue.main.async {

            // MEMO: タップした対象のセルをデザインを切り替える
            cell.setDecoration(shouldDisplayBorder: self.shouldExpandCell)

            // MEMO: 変数shouldExpandCellの状態に応じてスクロール可否を適用し直す
            collectionView.isScrollEnabled = self.shouldExpandCell

            // MEMO: 変数shouldExpandCellの状態に応じてレイアウトを適用し直す
            let targetLayout: UICollectionViewLayout = self.shouldExpandCell ? self.indexFileBinderLayout : self.expandedFileBinderLayout
            collectionView.setCollectionViewLayout(targetLayout, animated: true)

            self.shouldExpandCell = !self.shouldExpandCell
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeaturedViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredArticleItems.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCustomCell(with: FeaturedCollectionViewCell.self, indexPath: indexPath)
        cell.setCell(featuredArticleItems.value[indexPath.row])
        cell.setDecoration()

        return cell
    }
}

// MWRK: - ScreenErrorViewDelegate

extension FeaturedViewController: ScreenErrorViewDelegate {

    func retryRequestButtonTapped() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())
    }
}

// MARK: - StoryboardInstantiatable

extension FeaturedViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Featured"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}

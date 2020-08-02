//
//  StoryViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// UICollectionViewCompositionalLayoutでは実現が難しいかもしれない表現の例（3）
// 水平方向と垂直方向が合わさった形のUICollectionViewの表現（タイムテーブルやフォトギャラリー等でも類似した形のものがある）
// 参考:
// https://xyk.hatenablog.com/entry/2017/02/09/184410
// https://www.indetail.co.jp/blog/5257/

final class StoryViewController: UIViewController {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    private let storyItems: BehaviorRelay<Array<StoryEntity>> = BehaviorRelay<Array<StoryEntity>>(value: [])

    // MEMO: 表示内容を取得するViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "StoryViewModelType")) private var viewModel: StoryViewModelType

    // MARK: - @IBOutlet

    @IBOutlet private weak var storyCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.story.getGlobalTabBarTitle())
        setupStoryCollectionView()
        bindToRxSwift()
    }

    // MARK: - Private Function

    private func setupStoryCollectionView() {

        // UICollectionViewに関する設定
        storyCollectionView.decelerationRate = .fast
        storyCollectionView.showsHorizontalScrollIndicator = true
        storyCollectionView.showsVerticalScrollIndicator = true
        storyCollectionView.bounces = false
        storyCollectionView.registerCustomCell(StoryListCollectionViewCell.self)

        // MEMO: UICollectionViewのDelegate/DataSourceの宣言
        // ※ RxSwiftを利用した宣言方法もあるが、この方法だと却って処理が書きにくい場合にはデータをセットするする部分だけをRxSwiftで書いて残りは従来通りの記載方法でも良いかもしれません。
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self

        // UICollectionViewに付与するアニメーションに関する設定
        // MEMO: あらかじめMultipleScrollDirectionLayoutクラスをStoryboardで適用する
        if let multipleScrollDirectionLayout = storyCollectionView.collectionViewLayout as? MultipleScrollDirectionLayout {
            multipleScrollDirectionLayout.delegate = self
        }
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.initialFetchTrigger.onNext(())

        // RxSwiftを利用して一覧データをUICollectionViewに適用する
        viewModel.outputs.storyItems
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] storyItems in
                    guard let self = self else { return }
                    self.storyItems.accept(storyItems)
                    self.storyCollectionView.reloadData()
                }
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDataSource

// MEMO: iOS13~利用可能なDiffableDataSourceを利用しても実装可能
// → このレイアウトに関しては、「横方向のセル数はnumberOfItemsInSectionで定義する ＆ 縦方向のセル数はnumberOfSectionsで定義する」という形をとっている点に注意すれば可能
// ※ この場合については特にセクション毎の表示データの更新を考える必要のない画面だから従来通りの方法で支障はない。

extension StoryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyItems.value.isEmpty ? 0 : 4
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return storyItems.value.isEmpty ? 0 : 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: StoryListCollectionViewCell.self, indexPath: indexPath)
        let fixedIndex = indexPath.section * 4 + indexPath.row
        cell.setCell(storyItems.value[fixedIndex])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StoryViewController: UICollectionViewDelegateFlowLayout {

    // 配置するセルのサイズを決定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return StoryListCollectionViewCell.cellSize
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

// MARK: - StoryboardInstantiatable

extension StoryViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Story"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}

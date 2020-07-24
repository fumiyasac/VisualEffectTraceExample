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

// UICollectionViewCompositionalLayoutでは実現できない表現の例（3）
// 水平方向と垂直方向が合わさった形のUICollectionViewの表現（タイムテーブルやフォトギャラリー等でも類似した形のものがある）
// 参考:
// https://xyk.hatenablog.com/entry/2017/02/09/184410
// https://www.indetail.co.jp/blog/5257/

final class StoryViewController: UIViewController {

    // MARK: - StoryFlow

    var coordinator: StoryFlow?

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
        storyCollectionView.decelerationRate = .normal
        storyCollectionView.showsHorizontalScrollIndicator = true
        storyCollectionView.showsVerticalScrollIndicator = true
        storyCollectionView.bounces = false
        storyCollectionView.registerCustomCell(StoryListCollectionViewCell.self)

        // MEMO: UICollectionViewのDelegate/DataSourceの宣言
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

// MARK: - UICollectionViewDelegate

extension StoryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let position = "\(indexPath.section) - \(indexPath.row)"
        print("didSelect:", position)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StoryViewController: UICollectionViewDelegateFlowLayout {

    // 配置するセルのサイズを決定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return StoryListCollectionViewCell.cellSize
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

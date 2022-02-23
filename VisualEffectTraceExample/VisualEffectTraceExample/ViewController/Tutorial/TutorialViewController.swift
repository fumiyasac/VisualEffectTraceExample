//
//  TutorialViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AnimatedCollectionViewLayout

final class TutorialViewController: UIViewController {

    // MARK: - TutorialFlow

    var coordinator: TutorialFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: チュートリアル表示内容を取得するViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "TutorialViewModelType")) private var viewModel: TutorialViewModelType

    // MARK: - @IBOutlet

    @IBOutlet private weak var nextContentsButton: UIButton!
    @IBOutlet private weak var tutorialCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTutorialCollectionView()
        bindToRxSwift()
    }

    // MARK: - Private Function

    private func setupTutorialCollectionView() {

        // UICollectionViewに関する設定
        tutorialCollectionView.isPagingEnabled = true
        tutorialCollectionView.isScrollEnabled = true
        tutorialCollectionView.showsHorizontalScrollIndicator = false
        tutorialCollectionView.showsVerticalScrollIndicator = false
        tutorialCollectionView.registerCustomCell(TutorialCollectionViewCell.self)

        // UICollectionViewに付与するアニメーションに関する設定
        let layout = AnimatedCollectionViewLayout()
        layout.animator = SnapInAttributesAnimator()
        layout.scrollDirection = .horizontal
        tutorialCollectionView.collectionViewLayout = layout
    }

    private func bindToRxSwift() {

        // ViewModelから表示内容を取得する
        viewModel.inputs.changeIndexTrigger.onNext(0)

        // RxSwiftを利用して一覧データをUICollectionViewに適用する
        // MEMO: UICollectionViewのHeader・Footerのレイアウト調整等が絡んで取り扱いにくい場合もあるので、状況に合わせて使い分けていくと良いかと思います。
        viewModel.outputs.tutorialItems.bind(to: tutorialCollectionView.rx.items) { (collectionView, row, tutorialEntity) in
                let cell = collectionView.dequeueReusableCustomCell(with: TutorialCollectionViewCell.self, indexPath: IndexPath(row: row, section: 0))
                cell.setCell(tutorialEntity)
                cell.setCellDecoration()
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.outputs.isLastIndex
            .subscribe(
                onNext: { [weak self] result in
                    guard let self = self else { return }
                    self.shouldDisplayNextButton(result)
                }
            )
            .disposed(by: disposeBag)

        // 参考: RxSwiftを利用して該当のセルをタップした場合にタップ時のindexPathを返す場合の記述例
        /*
        tutorialCollectionView.rx.itemSelected
            .asSignal()
            .emit(
                onNext: { [weak self] indexPath in
                    let cell = self?.tutorialCollectionView.cellForItem(at: indexPath) as! TutorialCollectionViewCell
                    print(indexPath.section)
                    print(indexPath.row)
                    print(cell)
                }
            )
            .disposed(by: disposeBag)
        */

        // 参考: タップ時にセルに紐づいているModelを返す場合の記述例
        /*
        tutorialCollectionView.rx.modelSelected(TutorialModel.self)
            .asSignal()
            .emit(
                onNext: { model in
                    print(model)
                }
            )
            .disposed(by: disposeBag)
        */

        // RxSwiftを利用してUICollectionViewDelegateを適用する
        // MEMO: RxSwiftを利用した方法で組み立てる場合でもUICollectionViewDelegate等を利用する場合は記載が必要です。
        tutorialCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        // RxSwiftを利用してUICollectionViewのオフセット値が変化した場合に見える範囲内のセルのindexPathを取得する
        // MEMO: UIScrollViewDelegateのScrollViewDidScrollを利用しても同様な表現が可能です。
        tutorialCollectionView.rx.contentOffset
            .subscribe(
                onNext: { [weak self] currentPoint in
                    guard let self = self else { return }
                    guard let collectionView = self.tutorialCollectionView else {
                        return
                    }
                    let visibleRect = CGRect(origin: currentPoint, size: collectionView.bounds.size)
                    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                    if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
                        self.viewModel.inputs.changeIndexTrigger.onNext(visibleIndexPath.row)
                    }
                }
            )
            .disposed(by: disposeBag)

        // 次の画面を表示するボタン表示に関するハンドリング
        nextContentsButton.rx.controlEvent(.touchDown)
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeNextButtonAnimationOfTouchDown()
                }
            )
            .disposed(by: disposeBag)
        nextContentsButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeNextButtonAnimationOfTouchUpInside()
                }
            )
            .disposed(by: disposeBag)
    }

    // コンテンツ表示ボタンの状態を決定する
    private func shouldDisplayNextButton(_ result: Bool) {
        nextContentsButton.isUserInteractionEnabled = result
        UIView.animate(withDuration: 0.18, animations: {
            self.nextContentsButton.alpha = result ? 1 : 0
        })
    }

    // コンテンツ表示ボタンの.touchDown時のAnimationを付与する
    private func executeNextButtonAnimationOfTouchDown() {
        UIView.animate(withDuration: 0.16, animations: {
            self.nextContentsButton.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: nil)
    }

    // コンテンツ表示ボタンの.touchUpInside時のAnimationを付与する
    private func executeNextButtonAnimationOfTouchUpInside() {
        UIView.animate(withDuration: 0.16, animations: {
            self.nextContentsButton.transform = CGAffineTransform.identity
        }, completion: { finished in

            // MEMO: チュートリアル完了フラグの更新を実行する
            self.viewModel.inputs.completeTutorialTrigger.onNext(())
            // MEMO: TutorialFlowプロトコルに定義したTutorialScreenCoodinatorの画面遷移を実行する
            self.coordinator?.coordinateToSignin()
        })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TutorialViewController: UICollectionViewDelegateFlowLayout {

    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120.0)
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

extension TutorialViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Tutorial"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}

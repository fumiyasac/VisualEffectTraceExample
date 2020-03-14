//
//  BlockSubScriber.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// BlockSubscriber Class
// 1つの画面用クラス内で複数のStateを購読するようにするための設定
// ※このメリット: お互いのState購読が影響を及ぼし合わないにする必要がある場合でも利用ができる

// MEMO: State及びStore購読処理に関する戦略
// → 各種ViewControllerでは下記のような感じで利用する（これによって画面表示とデータ送信処理に関するStateを一緒にしないで管理できる）

// Example: ViewController内での利用例
/*

// (1) MEMO: 各種Stateに対応するBlockSubscriberの定義

private lazy var exampleStateSubscriber: BlockSubscriber<ExampleState> = BlockSubscriber(block: { [weak self] exampleState in

    // TODO: ExampleStateの変化をキャッチしてView要素や画面に関する処理を実行する
    // ポイント1: 意図しない循環参照が怖い場合には弱参照にしておく
    // ポイント2: State管理が散らばりそうな場合や1画面で「できることが多い」場合にはこの形にしておく
})

// (2) MEMO: ライフサイクル処理でのStore購読に関する定義

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // Stateが更新された際に通知を検知できるようにするリスナーを登録する

    // MEMO: 定義したBlockSubscriberの購読と紐づくStateを購読対象にする
    appStore.subscribe(self.exampleStateSubscriber) { state in
        state.select { state in state.exampleState }
    }
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    // Stateが更新された際に通知を検知できるようにするリスナーを解除する

    // MEMO: 定義したBlockSubscriberの購読を解除する
    appStore.unsubscribe(self.exampleStateSubscriber)
}
*/

// 参考: How to subscribe to multiple states separately in one class
// https://github.com/ReSwift/ReSwift/issues/318

public class BlockSubscriber<S>: StoreSubscriber {

    // MARK: - Typealias

    // MEMO: 各種購読対象のStateを定義する形にする
    public typealias StoreSubscriberStateType = S

    private let block: (S) -> Void

    // MARK: - Initializer

    public init(block: @escaping (S) -> Void) {
        self.block = block
    }

    // MARK: - StoreSucriber

    public func newState(state: S) {
        self.block(state)
    }
}

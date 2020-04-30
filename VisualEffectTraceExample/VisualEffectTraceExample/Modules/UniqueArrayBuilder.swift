//
//  UniqueArrayBuilder.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/01.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct UniqueDataArrayBuilder {

    // MARK: - Static Function

    // モデル内に定義したハッシュ値の同一性を検証して一意な表示用データ配列を作成する
    static func fillDifferenceOfOldAndNewLists<T: Decodable & Hashable>(_ dataType: T.Type, oldDataArray: Array<T>, newDataArray: Array<T>) -> Array<T> {

        // 引数より受け取った新しいデータ配列
        var newDataArray = newDataArray
        // 返却用の配列
        var returnDataArray: Array<T> = []
        // 既存の表示データ配列をループさせて同一のものがある場合は新しいデータへ置き換える
        for oldData in oldDataArray {
            var shouldAppendOldData = true
            for (newIndex, newData) in newDataArray.enumerated() {
                // MEMO: 同一データの確認(写真表示用のモデルはHashableとしているのでidの一致で判定できるようにしている部分がポイント)
                if oldData == newData {
                    shouldAppendOldData = false
                    returnDataArray.append(newData)
                    newDataArray.remove(at: newIndex)
                    break
                }
            }
            if shouldAppendOldData {
                returnDataArray.append(oldData)
            }
        }
        // 置き換えたものを除外した新しいデータを後ろへ追加する
        for newData in newDataArray {
            returnDataArray.append(newData)
        }
        return returnDataArray
    }
}

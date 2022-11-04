//
//  Dependencies.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: Swift5.1から登場した「Property Wrappers」を利用したDependency Injectionの実装例
// https://stackoverflow.com/questions/61316547/nested-dependency-injection-through-property-wrapper-crashes
// 補足: Property Wrappersについて
// https://dev.classmethod.jp/articles/property-wrappers/

enum Dependencies {

    // MARK: - Struct (for Name of Dependencies)

    struct Name: Equatable {
        let rawValue: String
        static let `default` = Name(rawValue: "__default__")
        static func == (lhs: Name, rhs: Name) -> Bool { lhs.rawValue == rhs.rawValue }
    }

    // MARK: - Class (for Container)

    final class Container {

        private var dependencies: [(key: Dependencies.Name, value: Any)] = [] {
            didSet {
                // MEMO: UnitTest実行時にDIコンテナへの追加＆削除処理が正しく実行されているかを確認する
                if isTesting() {
                    print(dependencies)
                }
            }
        }

        static let `default` = Container()

        // MARK: - Function

        // MEMO: 依存関係があるものを登録する
        func register(_ dependency: Any, for key: Dependencies.Name = .default) {
            dependencies.append((key: key, value: dependency))
        }

        // MEMO: 引数に与えた名前を元にDIを実行する
        func resolve<T>(_ key: Dependencies.Name = .default) -> T {

            // Debug.
            //dump(dependencies)

            // MEMO: filterとfirstをするよりもfirst(where:)の方がパフォーマンスが良い
            // https://qiita.com/shtnkgm/items/928630d692cf1e5b0846
            let instanceObjectValue = dependencies
                // MEMO: 引数のkeyと一致する＆型がTに設定している条件に合致する場合はその値(.value)だけを利用する
                .first { (dependencyTuple) -> Bool in
                    dependencyTuple.key == key && dependencyTuple.value is T
                }
                .flatMap{ (_, value) in
                    value
                }

            // MEMO: 名前に対応する型でダウンキャストを実施し、名前と依存関係を正しく対応させないとクラッシュが発生する形にしている
            guard let instance = instanceObjectValue as? T else {
                fatalError("Could not cast value of type 'Any' to expected type.")
            }
            return instance
        }

        // MEMO: 依存関係があるものをKey値を元にして削除する
        func remove(for key: Dependencies.Name = .default) {
            dependencies.removeAll(where: { $0.key == key })
        }

        // MEMO: 依存関係があるものを全て削除する
        func reset() {
            dependencies.removeAll()
        }
    }

    // MARK: - @propatyWrapper (for Struct for Dependency Injection)

    @propertyWrapper
    struct Inject<T> {

        private let dependencyName: Name
        private let container: Container

        // 設定した名前を元に依存関係の解決を実施する
        var wrappedValue: T { container.resolve(dependencyName) }

        // MARK: - Initializer

        init(_ dependencyName: Name = .default, on container: Container = .default) {
            self.dependencyName = dependencyName
            self.container = container
        }
    }
}

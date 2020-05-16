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

        private var dependencies: [(key: Dependencies.Name, value: Any)] = []

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

            // MEMO: 名前と依存関係を正しく対応させないとクラッシュが発生する形にしている
            return (dependencies
                .filter { (dependencyTuple) -> Bool in
                    dependencyTuple.key == key
                        && dependencyTuple.value is T
                }
                .first)?.value as! T
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

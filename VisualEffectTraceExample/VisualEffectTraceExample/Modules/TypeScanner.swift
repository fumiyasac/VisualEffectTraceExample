//
//  TypeNameScanner.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

final class TypeScanner {

    // MARK: - Static Function

    static func getName<T>(_ type: T) -> String {
        return NSString(string: "\(type)").components(separatedBy: ".").last!
    }
}

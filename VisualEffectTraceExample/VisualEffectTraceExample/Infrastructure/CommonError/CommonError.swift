//
//  CommonError.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2022/07/16.
//  Copyright © 2022 酒井文也. All rights reserved.
//

import Foundation

enum CommonError: Error {
    case networkError(String?)
    case invalidResponse(String?)
    case notExistObject
    case notExistSelf
}

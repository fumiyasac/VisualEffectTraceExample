//
//  SigninViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/05.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SigninViewModelInputs {

    //
}

protocol SigninViewModelOutputs {

    //
}

protocol SigninViewModelType {
    var inputs: SigninViewModelInputs  { get }
    var outputs: SigninViewModelOutputs { get }
}

final class SigninViewModel: SigninViewModelInputs, SigninViewModelOutputs, SigninViewModelType {

    var inputs: SigninViewModelInputs { return self }
    var outputs: SigninViewModelOutputs { return self }
}

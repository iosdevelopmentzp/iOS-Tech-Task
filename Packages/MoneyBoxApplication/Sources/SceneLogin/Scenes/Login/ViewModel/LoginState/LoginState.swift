//
//  LoginState.swift
//  
//
//  Created by Dmytro Vorko on 15.08.2022.
//

import Foundation

typealias LoginStateUpdate = (current: LoginState, previous: LoginState?)

enum LoginState: Equatable {
    case idle
    case expectation(_ model: LoginViewModels?)
    case loading(_ model: LoginViewModels?)
    case error(_ errorMessage: String, _ model: LoginViewModels?)
}

struct LoginViewModels: Equatable {
    let loginButtonModel: LoginButtonModel
    let loginTextFieldModel: LoginTextFieldModel
    let passwordTextFieldModel: LoginTextFieldModel
}

extension LoginState {
    var model: LoginViewModels? {
        switch self {
        case .idle:
            return nil
            
        case .expectation(let model), .loading(let model), .error(_, let model):
            return model
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .error(let errorMessage, _): return errorMessage
        default: return nil
        }
    }
}

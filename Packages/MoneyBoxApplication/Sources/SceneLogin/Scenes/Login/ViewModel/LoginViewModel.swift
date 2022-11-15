//
//  LoginViewModel.swift
//  
//
//  Created by Dmytro Vorko on 08.08.2022.
//

import Foundation
import MVVM
import Extensions
import UseCases
import AppResources

@MainActor
public final class LoginViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {
        @MainThread
        var onStateUpdate: ArgClosure<LoginStateUpdate>
    }
    
    public struct Output {
        enum EventType {
            case loginTap
            case loginText(_ text: String)
            case passwordText(_ text: String)
        }
        
        var onEvent: ArgClosure<EventType>
    }
    
    // MARK: - Properties
    
    public var sceneDelegate: LoginSceneDelegate?
    
    private let useCase: AuthorizationUseCaseProtocol
    
    private var userName = "test+ios2@moneyboxapp.com"
    private var passwordText = "P455word12"
    
    private var onStateUpdate: ArgClosure<(current: LoginState, previous: LoginState?)>?
    
    private var state: LoginState = .idle {
        didSet {
            guard state != oldValue else { return }
            onStateUpdate?((state, oldValue))
        }
    }
    
    // MARK: - Constructor
    
    public init(useCase: AuthorizationUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // MARK: - Transform
    
    public func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        onStateUpdate = {
            input.onStateUpdate($0)
        }
        
        let output = Output(
            onEvent: { [weak self] in
                self?.handler(event: $0)
            }
        )
        
        outputHandler(output)
        state = .expectation(makeViewModels())
    }
}

// MARK: - Private Functions

private extension LoginViewModel {
    private func handler(event: Output.EventType) {
        switch event {
        case .loginTap:
            login()

        case .loginText(let text):
            userName = text
            state = .expectation(makeViewModels())

        case .passwordText(let text):
            passwordText = text
            state = .expectation(makeViewModels())
        }
    }

    private func login() {
        state = .loading(state.model)

        Task {
            do {
                try await useCase.login(username: userName, password: passwordText)
                sceneDelegate?.didLogin()
            } catch {
                state = .error(error.localizedDescription, state.model)
            }
        }
    }
    
    private func makeViewModels() -> LoginViewModels {
        let loginModel = LoginTextFieldModel(text: userName, placeholder: Strings.Login.loginPlaceholder)
        let passwordModel = LoginTextFieldModel(text: passwordText, placeholder: Strings.Login.passwordPlaceholder)
        let buttonModel = LoginButtonModel(
            title: Strings.Login.loginButtonTitle,
            isEnabled: !userName.isEmpty && !passwordText.isEmpty
        )
        
        return .init(
            loginButtonModel: buttonModel,
            loginTextFieldModel: loginModel,
            passwordTextFieldModel: passwordModel
        )
    }
}

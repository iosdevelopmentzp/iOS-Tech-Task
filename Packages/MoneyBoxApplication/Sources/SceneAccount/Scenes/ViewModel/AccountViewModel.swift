//
//  AccountViewModel.swift
//  
//
//  Created by Dmytro Vorko on 16.08.2022.
//

import Foundation
import MVVM
import UseCases
import Extensions

public final class AccountViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {
        @MainThread
        private(set) var onDidUpdateState: ArgClosure<AccountState>
    }
    
    public struct Output {
        enum Event {
            case tapAccountId(_ productId: Int)
            case retryButtonTap
        }
        
        var onEvent: (Event) -> Void
    }
    
    private struct PrivateEventsHandler {
        let onStateUpdate: ArgClosure<AccountState>
    }
    
    // MARK: - Properties
    
    public weak var sceneDelegate: AccountSceneDelegate?
    
    private let accountUseCase: AccountUseCaseProtocol
    
    private var eventsHandler: PrivateEventsHandler?
    
    private var state = AccountState.idle {
        didSet {
            guard state != oldValue else { return }
            eventsHandler?.onStateUpdate(state)
        }
    }
    
    // MARK: - Constructor
    
    public init(_ accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }
    
    // MARK: - Transform
    
    public func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        eventsHandler = .init(
            onStateUpdate: {
                input.onDidUpdateState($0)
            }
        )
        
        let ouput = Output { [weak self] in
            switch $0 {
            case .tapAccountId(let id):
                // TODO: - Route to product
                debugPrint("Did tap account: \(id)")
                
            case .retryButtonTap:
                self?.setupProducts()
            }
        }
        
        outputHandler(ouput)
        setupProducts()
    }
}

// MARK: - Private functions

private extension AccountViewModel {
    private func setupProducts() {
        state = .loading
        
        Task {
            do {
                let account = try await accountUseCase.userAccount()
                let items = AccountItem.Factory.make(account: account, userName: "Test")
                state = .loaded(items: items)
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }
}

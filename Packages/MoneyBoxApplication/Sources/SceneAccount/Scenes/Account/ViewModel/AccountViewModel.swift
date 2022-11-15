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
import Core

public final class AccountViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {
        @MainThread
        private(set) var onDidUpdateState: ArgClosure<AccountState>
    }
    
    public struct Output {
        enum Event {
            case didTapIndividAccount(_ id: String)
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
    
    private var task: Task<Void, Never>?
    
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
        eventsHandler = .init(onStateUpdate: { input.onDidUpdateState($0) })
        
        let ouput = Output { [weak self] in
            switch $0 {
            case .didTapIndividAccount(let id):
                self?.sceneDelegate?.didTapIndividualAccount(with: id)
                
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
        self.task?.cancel()
        state = .loading
        
        self.task = Task {
            let result: Result<UserAccount, Error>
            do {
                let account = try await accountUseCase.userAccount()
                result = .success(account)
            } catch {
                result = .failure(error)
            }
            
            // Check whether current task has been canceled
            guard !Task.isCancelled else { return }
            
            switch result {
            case .success(let account):
                let items = AccountItem.Factory.make(account: account, userName: "Test")
                state = .loaded(items: items)
                
            case .failure(let error):
                state = .failed(error.localizedDescription)
            }
        }
    }
}

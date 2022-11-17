//
//  IndividAccountViewModel.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation
import MVVM
import UseCases
import Extensions
import Core
import AppResources

public final class IndividAccountViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {
        @MainThread
        var onDidUpdateState: ArgClosure<IndividAccountState>
    }
    
    public struct Output {
        enum Event {
            case didTapAddButton
        }

        var onEvent: ArgClosure<Event>
    }
    
    private struct Constants {
        static let addValue = 10.0
    }
    
    private struct EventsHandler {
        let onStateUpdate: ArgClosure<IndividAccountState>
    }
    
    // MARK: - Properties
    
    public weak var sceneDelegate: IndividAccountSceneDelegate?
    
    private let accountUseCase: AccountUseCaseProtocol
    
    private let transactionsUseCase: TransactionsUseCaseProtocol
    
    private var eventsHandler: EventsHandler?
    
    private let accountId: String
    
    private var task: Task<Void, Never>?
    
    private var state: IndividAccountState = .idle {
        didSet {
            guard oldValue != state else { return }
            eventsHandler?.onStateUpdate(state)
        }
    }
    
    // MARK: - Constructor
    
    public init(
        accountId: String,
        _ accountUseCase: AccountUseCaseProtocol,
        _ transactionsUseCase: TransactionsUseCaseProtocol
    ) {
        self.accountId = accountId
        self.accountUseCase = accountUseCase
        self.transactionsUseCase = transactionsUseCase
    }
    
    // MARK: - Transform
    
    public func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        eventsHandler = .init { input.onDidUpdateState($0) }
        
        let output = Output { [weak self] in self?.handle(event: $0) }
        outputHandler(output)
        setupProducts()
    }
}

// MARK: - Private Functions

private extension IndividAccountViewModel {
    private func handle(event: Output.Event) {
        switch event {
        case .didTapAddButton:
            invokeTransaction()
        }
    }
    
    private func setupProducts() {
        self.task?.cancel()
        state = .loading
        
        self.task = Task {
            let result: Result<Account, Error>
            do {
                let account = try await accountUseCase.individualAccount(by: self.accountId)
                result = .success(account)
            } catch {
                result = .failure(error)
            }
            
            // Check whether current task has been canceled
            guard !Task.isCancelled else { return }
            
            switch result {
            case .success(let account):
                let cellModel = IndividAccountCellModel.Factory.make(account: account, individAccountId: self.accountId)
                let addValue = Constants.addValue.format(.roundUp(count: 0))
                let buttonTitle = Strings.IndividualAccount.add("£", addValue)
                let buttonModel = IndividAccountButtonModel.init(state: .active(buttonTitle))
                self.state = .loaded(.init(buttonModel: buttonModel, cellModel: cellModel))
                
            case .failure(let error):
                self.state = .failedLoading(error.localizedDescription)
            }
        }
    }
    
    private func invokeTransaction() {
        
    }
}

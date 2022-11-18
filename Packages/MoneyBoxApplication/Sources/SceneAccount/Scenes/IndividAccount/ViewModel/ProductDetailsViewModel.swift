//
//  ProductDetailsViewModel.swift
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

public final class ProductDetailsViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {
        @MainThread
        var onDidUpdateState: ArgClosure<ProductDetailsState>
    }
    
    public struct Output {
        enum Event {
            case didTapAddButton
            case didTapRetryButton
        }

        var onEvent: ArgClosure<Event>
    }
    
    private struct Constants {
        static let addValue = 10.0
        static let addCurrency = "£"
    }
    
    private struct EventsHandler {
        let onStateUpdate: ArgClosure<ProductDetailsState>
    }
    
    // MARK: - Properties
    
    public weak var sceneDelegate: ProductDetailsSceneDelegate?
    
    private let accountUseCase: AccountUseCaseProtocol
    
    private let transactionsUseCase: TransactionsUseCaseProtocol
    
    private var eventsHandler: EventsHandler?
    
    private let accountId: Int
    
    private var task: Task<Void, Never>?
    
    private var state: ProductDetailsState = .idle {
        didSet {
            guard oldValue != state else { return }
            eventsHandler?.onStateUpdate(state)
        }
    }
    
    // MARK: - Constructor
    
    public init(
        accountId: Int,
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
        setupAccount()
    }
}

// MARK: - Private Functions

private extension ProductDetailsViewModel {
    private func handle(event: Output.Event) {
        switch event {
        case .didTapAddButton:
            invokeAdding()
            
        case .didTapRetryButton:
            setupAccount()
        }
    }
    
    private func setupAccount() {
        self.task?.cancel()
        state = .loading
        
        self.task = Task {
            let result: Result<Product, Error>
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
                let model = ProductDetailsModel.Factory.make(
                    account,
                    addValue: Constants.addValue,
                    addCurrency: Constants.addCurrency
                )
                self.state = .loaded(model)
                
            case .failure(let error):
                self.state = .failedLoading(error.localizedDescription)
            }
        }
    }
    
    private func invokeAdding() {
        guard let model = self.state.model else { return }
        self.state = .transactionLoading(model)
        
        
        Task {
            do {
                try await transactionsUseCase.oneOffPayment(
                    amount: Int(Constants.addValue),
                    investorProductID: accountId
                )
                setupAccount()
            } catch {
                self.state = .failedTransaction(error.localizedDescription, model)
            }
            
        }
    }
}

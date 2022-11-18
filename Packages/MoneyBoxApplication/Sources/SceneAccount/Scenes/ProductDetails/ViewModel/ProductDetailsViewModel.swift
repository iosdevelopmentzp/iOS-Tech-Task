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
            case didTapAlertConfirmation
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
    
    private let productId: Int
    
    private var task: Task<Void, Never>?
    
    private var state: ProductDetailsState = .idle {
        didSet {
            guard oldValue != state else { return }
            eventsHandler?.onStateUpdate(state)
        }
    }
    
    // MARK: - Constructor
    
    public init(
        productId: Int,
        _ accountUseCase: AccountUseCaseProtocol,
        _ transactionsUseCase: TransactionsUseCaseProtocol
    ) {
        self.productId = productId
        self.accountUseCase = accountUseCase
        self.transactionsUseCase = transactionsUseCase
    }
    
    // MARK: - Transform
    
    public func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        eventsHandler = .init { input.onDidUpdateState($0) }
        
        let output = Output { [weak self] in self?.handle(event: $0) }
        outputHandler(output)
        setupProduct()
    }
}

// MARK: - Private Functions

private extension ProductDetailsViewModel {
    private func handle(event: Output.Event) {
        switch event {
        case .didTapAddButton:
            invokeAdding()
            
        case .didTapRetryButton:
            setupProduct()
            
        case .didTapAlertConfirmation:
            setupProduct()
        }
    }
    
    private func setupProduct() {
        self.task?.cancel()
        state = .loading
        
        self.task = Task {
            let result: Result<Product, Error>
            do {
                let product = try await accountUseCase.productDetails(by: self.productId)
                result = .success(product)
            } catch {
                result = .failure(error)
            }
            
            // Check whether current task has been canceled
            guard !Task.isCancelled else { return }
            
            switch result {
            case .success(let product):
                let model = ProductDetailsModel.Factory.make(
                    product,
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
            let value = Int(Constants.addValue)
            do {
                try await transactionsUseCase.oneOffPayment(
                    amount: value,
                    investorProductID: productId
                )
                self.state = .successTransaction("Did transfer => \(Constants.addCurrency)\(value)", model)
            } catch {
                self.state = .failedTransaction(error.localizedDescription, model)
            }
            
        }
    }
}

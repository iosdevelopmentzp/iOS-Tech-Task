//
//  AccountViewModel.swift
//  
//
//  Created by Dmytro Vorko on 16.08.2022.
//

import Foundation
import MVVM
import UseCases

public final class AccountViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {
        var onDidUpdateState: (AccountState) -> Void
    }
    
    public struct Output {
        enum Event {
            case tapProductId(_ productId: Int)
            case retryButtonTap
        }
        
        var onEvent: (Event) -> Void
    }
    
    private struct PrivateEventsHandler {
        let onStateUpdate: (AccountState) -> Void
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
        setupProducts()
//        eventsHandler = .init(
//            onStateUpdate: {
//                input.onDidUpdateState($0)
//            }
//        )
//        
//        let ouput = Output {
//            switch $0 {
//            case .tapProductId(let id):
//                // TODO: - Route to product
//                break
//                
//            case .retryButtonTap:
//                <#code#>
//            }
//        }
//        
//        outputHandler()
    }
}

// MARK: - Private functions

private extension AccountViewModel {
    private func setupProducts() {
        state = .loading
        
        Task {
            do {
                let products = try await accountUseCase.products()
                debugPrint(products)
            } catch {
                debugPrint(error)
            }
        }
    }
}

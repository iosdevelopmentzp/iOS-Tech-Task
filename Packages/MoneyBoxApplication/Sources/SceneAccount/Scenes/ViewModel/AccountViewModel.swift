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
        
    }
    
    public struct Output {
        
    }
    
    // MARK: - Properties
    
    public weak var sceneDelegate: AccountSceneDelegate?
    
    private let accountUseCase: AccountUseCaseProtocol
    
    // MARK: - Constructor
    
    public init(_ accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }
    
    // MARK: - Transform
    
    public func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        
    }
}

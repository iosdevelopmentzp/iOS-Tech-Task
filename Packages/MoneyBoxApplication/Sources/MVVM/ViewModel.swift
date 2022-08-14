//
//  ViewModel.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import Foundation

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    @MainActor
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void)
}

//
//  ErrorResponseDTO+Error.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Core
import Foundation

extension ErrorResponseDTO: LocalizedError {
    public var errorDescription: String? {
        let validationDescription = (validationErrors ?? [])
            .map { [$0.name, $0.message].compactMap { $0 }.joined(separator: ". ") }
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
        
        return [name, message, validationDescription].joined(separator: "\n")
    }
}

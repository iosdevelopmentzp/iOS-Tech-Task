//
//  MultipleDecodableModel.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

/// Wrapper for multiple decode expectation.
/// For instance can be used when some response can return either expected decodable model or server decodable error
enum MultipleDecodableModel<MainExpectation: Decodable, SecondaryExpectation: Decodable>: Decodable {
    case secondary(_ data: SecondaryExpectation)
    case main(_ main: MainExpectation)
    
    init(from decoder: Decoder) throws {
        do {
            // 1. Try decode main expectation
            let main = try decoder.singleValueContainer().decode(MainExpectation.self)
            self = .main(main)
        } catch {
            // 2. If main decoding was failed - try decode secondary expectation
            if let secondary = try? decoder.singleValueContainer().decode(SecondaryExpectation.self) {
                self = .secondary(secondary)
                return
            }
            // 3. If secondary decoding was also failed - throw main decoding error
            throw error
        }
    }
}

extension MultipleDecodableModel {
    /// If current case is main - returns main object.
    /// If current object is optional - throw optional error.
    func mainExpectationOrError() throws -> MainExpectation where SecondaryExpectation: Error {
        switch self {
        case .main(let main):
            return main
        case .secondary(let secondary):
            throw secondary
        }
    }
}

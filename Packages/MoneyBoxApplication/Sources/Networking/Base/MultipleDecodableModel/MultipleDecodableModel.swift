//
//  MultipleDecodableModel.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

/// Wrapper for multiple decode expectation.
/// Can be used, when some response can return either expected decodable model or server decodable error
enum MultipleDecodableModel<OptionalExpectation: Decodable, MainExpectation: Decodable>: Decodable {
    case optional(_ data: OptionalExpectation)
    case main(_ main: MainExpectation)
    
    init(from decoder: Decoder) throws {
        do {
            // 1. Try decode main expectation
            let main = try decoder.singleValueContainer().decode(MainExpectation.self)
            self = .main(main)
        } catch {
            // 2. If main decoding was failed - try decode optional expectation
            if let optional = try? decoder.singleValueContainer().decode(OptionalExpectation.self) {
                self = .optional(optional)
                return
            }
            // 3. If optional decoding was also failed - throw main decoding error
            throw error
        }
    }
}

extension MultipleDecodableModel {
    /// If current case is main - returns main object.
    /// If current object is optional - throw optional error.
    func mainExpectation() throws -> MainExpectation where OptionalExpectation: Error {
        switch self {
        case .main(let main):
            return main
        case .optional(let optional):
            throw optional
        }
    }
}

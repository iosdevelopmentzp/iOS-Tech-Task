//
//  Resolver+ForceUnwrap.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Swinject

extension Resolver {
    func resolveOrFail<T>(_ type: T.Type = T.self) -> T {
        guard let resolved = self.resolve(type) else {
            fatalError("Failed \(String(describing: type)) resolving attempt")
        }
        return resolved
    }
}

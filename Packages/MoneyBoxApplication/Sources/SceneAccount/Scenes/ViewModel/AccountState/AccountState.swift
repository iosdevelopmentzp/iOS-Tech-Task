//
//  AccountState.swift
//  
//
//  Created by Dmytro Vorko on 24.08.2022.
//

import Foundation

enum AccountState: Equatable {
    case idle
    case loading
    case failed(_ errorMessage: String)
    case loaded(items: [AccountItem])
}

// MARK: - AccountState Extension

extension AccountState {
    var loadedItems: [AccountItem] {
        guard case .loaded(items: let items) = self else {
            return []
        }
        return items
    }
}

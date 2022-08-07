//
//  UserDefaults+Theme.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

extension UserDefaults {
    static var regular: UserDefaults? {
        UserDefaults(suiteName: regularName)
    }
    
    static var safe: UserDefaults? {
        UserDefaults(suiteName: safeName)
    }
}

// MARK: - Private

extension UserDefaults {
    private static var regularName: String {
        [Bundle.main.bundleIdentifier ?? "", "RegularUserDefaults" ].joined(separator: "_")
    }
    
    private static var safeName: String {
        [Bundle.main.bundleIdentifier ?? "", "SafeUseDefaults" ].joined(separator: "_")
    }
}

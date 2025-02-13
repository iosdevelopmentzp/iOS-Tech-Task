//
//  GlobalFunctions.swift
//  
//
//  Created by Dmytro Vorko on 16.08.2022.
//

import Foundation

/// helper to change behaviour of app during testing
public var isTesting: Bool {
    #if DEBUG
    return NSClassFromString("XCTestCase") != nil
    #else
    return false
    #endif
}

//
//  AppNotifierFactory.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol AppNotifierFactoryProtocol {
    var authorizationNotifier: AuthorizationNotifierProtocol { get }
}

public class AppNotifierFactory {
    public init() {}
}

// MARK: - AppNotifierFactoryProtocol

extension AppNotifierFactory: AppNotifierFactoryProtocol {
    public var authorizationNotifier: AuthorizationNotifierProtocol {
        AuthorizationNotifier()
    }
}

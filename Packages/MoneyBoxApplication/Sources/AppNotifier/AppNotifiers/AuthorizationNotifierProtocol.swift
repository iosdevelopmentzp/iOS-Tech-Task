//
//  AuthorizationNotifierProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public enum AuthorizationNotifierEvent: String {
    case didLogin
    case didLogout
}

public protocol AuthorizationNotifierDelegate: AnyObject {
    func notifier(_ notifier: AuthorizationNotifierProtocol, didNotifyEvent: AuthorizationNotifierEvent)
}

public protocol AuthorizationNotifierProtocol {
    func addListener(_ delegate: AuthorizationNotifierDelegate) -> Cancellable
    func notify(event: AuthorizationNotifierEvent)
}

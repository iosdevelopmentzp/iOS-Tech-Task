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
    func notifier(_ notifier: AuthorizationNotifierProtocol, didNotifyEvent event: AuthorizationNotifierEvent)
}

public protocol AuthorizationNotifierProtocol {
    func addListener(_ listener: AuthorizationNotifierDelegate)
    func removeListener(_ listener: AuthorizationNotifierDelegate)
    func notify(event: AuthorizationNotifierEvent)
}

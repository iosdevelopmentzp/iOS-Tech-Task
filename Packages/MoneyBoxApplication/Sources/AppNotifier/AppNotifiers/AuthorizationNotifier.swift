//
//  AuthorizationNotifier.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

final class AuthorizationNotifier {
    // MARK: - Properties
    
    private let notificationCenter = NotificationCenter.default
    private var token: NSObjectProtocol?
   
    // Closures for subscribers weak reference storage
    private var subscribers = [() -> AuthorizationNotifierDelegate?]()
    
    private let notificationName: Notification.Name = {
        let name = [
            Bundle.main.bundleIdentifier,
            String(describing: AuthorizationNotifier.self)
        ].compactMap { $0 }.joined(separator: "_")
        return Notification.Name(name)
    }()
    
    // MARK: - Constructor
    
    init() {
        setupObserving()
    }
    
    // MARK: - Private functions
    
    private func setupObserving() {
        token = notificationCenter.addObserver(forName: notificationName, object: nil, queue: nil) { [weak self] notification in
                guard let self = self, let event = notification.object as? AuthorizationNotifierEvent else {
                    return
                }
                self.subscribers.forEach {
                    $0()?.notifier(self, didNotifyEvent: event)
                }
            }
    }
}

// MARK: - AuthorizationNotifierProtocol

extension AuthorizationNotifier: AuthorizationNotifierProtocol {
    func addListener(_ listener: AuthorizationNotifierDelegate) {
        subscribers.append( { [weak listener] in listener } )
    }
    
    func removeListener(_ listener: AuthorizationNotifierDelegate) {
        subscribers = subscribers.filter { $0() !== listener }
    }
    
    func notify(event: AuthorizationNotifierEvent) {
        notificationCenter.post(name: notificationName, object: event)
    }
}

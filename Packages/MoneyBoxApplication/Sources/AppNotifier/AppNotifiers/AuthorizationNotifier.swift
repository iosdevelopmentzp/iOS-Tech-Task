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
        notificationCenter.addObserver(forName: notificationName, object: nil, queue: nil) { [weak self] notification in
                guard let self = self, let event = notification.object as? AuthorizationNotifierEvent else {
                    return
                }
                self.subscribers.forEach {
                    $0()?.notifier(self, didNotifyEvent: event)
                }
            }
    }
}

extension AuthorizationNotifier: AuthorizationNotifierProtocol {
    func addListener(_ delegate: AuthorizationNotifierDelegate) -> Cancellable {
        subscribers.append(
            { [weak delegate] in return delegate }
        )
        
        return Cancellable.init { [weak self, weak delegate] in
            self?.subscribers = (self?.subscribers ?? []).filter { $0() !== delegate }
        }
    }
    
    func notify(event: AuthorizationNotifierEvent) {
        notificationCenter.post(name: notificationName, object: event)
    }
}

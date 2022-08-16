//
//  AppCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import DependencyResolver
import UIKit
import UseCases
import AppNotifier

public final class AppCoordinator: NavigationCoordinator {
    // MARK: - Properties
    
    private let window: UIWindow
    
    private let resolver: DependencyResolverProtocol
    
    private let authorizationUseCase: AuthorizationUseCaseProtocol
    private let notifier: AuthorizationNotifierProtocol
    
    // MARK: - Constructor
    
    public init(window: UIWindow, resolver: DependencyResolverProtocol) {
        self.resolver = resolver
        authorizationUseCase = resolver.resolve()
        notifier = resolver.resolve()
        self.window = window
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        super.init(navigation: navigationController)
        setupAuthObserving()
        setupWindow()
    }
    
    // MARK: - Constructor
    
    public override func start() {
        if authorizationUseCase.isAuthorized {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.blue
            navigation.setViewControllers([viewController], animated: true)
        } else {
            let loginCoordinator = LoginCoordinator(resolver, navigation: navigation)
            addChild(loginCoordinator)
            loginCoordinator.start()
        }
    }
}

// MARK: - Private Functions

private extension AppCoordinator {
    private func setupAuthObserving() {
        notifier.addListener(self)
    }
    
    private func setupWindow() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

// MARK: - AuthorizationNotifierDelegate

extension AppCoordinator: AuthorizationNotifierDelegate {
    public func notifier(_ notifier: AuthorizationNotifierProtocol, didNotifyEvent event: AuthorizationNotifierEvent) {
        switch event {
        case .didLogin, .didLogout:
            DispatchQueue.main.async { [weak self] in self?.start() }
        }
    }
}

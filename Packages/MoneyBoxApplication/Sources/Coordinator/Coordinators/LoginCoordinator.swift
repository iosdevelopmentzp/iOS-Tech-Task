//
//  LoginCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import UIKit
import SceneLogin
import DependencyResolver
import AppNotifier

final class LoginCoordinator: NavigationCoordinator {
    
    private let resolver: DependencyResolverProtocol
    
    private let notifier: AuthorizationNotifierProtocol
    
    init(_ resolver: DependencyResolverProtocol, navigation: UINavigationController) {
        self.resolver = resolver
        self.notifier = resolver.resolve()
        super.init(navigation: navigation)
    }
    
    override func start() {
        let viewModel = LoginViewModel(useCase: resolver.resolve())
        let viewController = LoginViewController(viewModel)
        viewModel.sceneDelegate = self
        navigation.setViewControllers([viewController], animated: true)
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - LoginSceneDelegate

extension LoginCoordinator: LoginSceneDelegate {
    func didLogin() {
        childDidFinish(self)
        notifier.notify(event: .didLogin)
    }
}

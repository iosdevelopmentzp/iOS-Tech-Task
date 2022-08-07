//
//  LoginCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import UIKit

final class LoginCoordinator: NavigationCoordinator {
    override func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.red
        navigation.pushViewController(viewController, animated: true)
    }
}

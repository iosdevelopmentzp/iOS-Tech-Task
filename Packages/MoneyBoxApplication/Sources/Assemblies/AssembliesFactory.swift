//
//  AssembliesFactory.swift
//  
//
//  Created by Dmytro Vorko on 02.08.2022.
//

import Foundation
import Swinject
import Networking

public protocol AssembliesFactoryProtocol {
    var networking: Assembly { get }
    var useCases: Assembly { get }
    var notifier: Assembly { get }
    var settingsStorage: Assembly { get }
    
    func apiConfiguration(_ provider: @autoclosure @escaping () -> (NetworkConfigurationsType)) -> Assembly
}

public class AssembliesFactory {
    public init() {}
}

// MARK: - AssembliesFactoryProtocol

extension AssembliesFactory: AssembliesFactoryProtocol {
    public var networking: Assembly {
        NetworkingAssembly()
    }
    
    public var useCases: Assembly {
        UseCasesAssembly()
    }
    
    public var notifier: Assembly {
        AppNotifierAssembly()
    }
    
    public var settingsStorage: Assembly {
        SettingsStorageAssembly()
    }
    
    public func apiConfiguration(
        _ provider: @autoclosure @escaping () -> (NetworkConfigurationsType)
    ) -> Assembly {
        APIConfigurationAssembly(provider)
    }
}

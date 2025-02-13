//
//  NetworkConfigurationsType.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

/// Entity that should be passed outside to adjust the Target model
public protocol NetworkConfigurationsType {
    var host: String { get }
    var appId: String { get }
    var appVersion: String { get }
    var apiVersion: String { get }
}

extension NetworkConfigurationsType {
    var configurationHeaders: [String: String] {
        [
            "AppId": appId,
            "appVersion": appVersion,
            "apiVersion": apiVersion
        ]
    }
}

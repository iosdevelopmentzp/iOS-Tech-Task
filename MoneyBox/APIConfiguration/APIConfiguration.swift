//
//  APIConfiguration.swift
//  HiringMPS
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import Foundation
import Networking

struct APIConfiguration: PlistDecodableType, NetworkConfigurationsType {
    let host: String
    let appId: String
    let appVersion: String
    let apiVersion: String
}

//
//  UserSettingsStorageProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol UserSettingsStorageProtocol {
    var userName: (firstName: String?, lastName: String?)? { get }
    
    func saveUserName(firstName: String?, lastName: String?)
    func clearUserName()
}

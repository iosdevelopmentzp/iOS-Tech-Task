//
//  CachingKey.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol CachingKey {
    var cachingKey: String { get }
}

public extension CachingKey where Self: RawRepresentable, Self.RawValue == String {
    var cachingKey: String {
        rawValue
    }
}

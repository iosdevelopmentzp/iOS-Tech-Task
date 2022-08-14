//
//  Reusable.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import UIKit

public protocol Reusable {
    static var identifier: String { get }
}

public extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

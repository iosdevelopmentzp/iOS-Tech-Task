//
//  CoordinatorProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    var children: [CoordinatorProtocol] { get set }
    var parent: CoordinatorProtocol? { get set }
    
    func start()
    func addChild(_ child: CoordinatorProtocol)
    func childDidFinish(_ child: CoordinatorProtocol)
}

// MARK: - Default implementation

public extension CoordinatorProtocol {
    func addChild(_ child: CoordinatorProtocol) {
        children.append(child)
        child.parent = self
    }
    
    func childDidFinish(_ child: CoordinatorProtocol) {
        children = children.filter { $0 !== child }
        parent?.childDidFinish(child)
    }
}

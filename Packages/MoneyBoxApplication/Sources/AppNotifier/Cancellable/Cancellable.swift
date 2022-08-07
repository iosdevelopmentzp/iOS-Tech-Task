//
//  Cancellable.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public struct Cancellable {
    let cancelAction: () -> ()
    
    public func cancel() {
        cancelAction()
    }
}

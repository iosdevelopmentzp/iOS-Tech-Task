//
//  MainThread.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation

/// Ensures that the closure is called on the main thread
@propertyWrapper
public struct MainThread<Data> {
    private var closure: ((Data) -> Void)?
 
    public var wrappedValue: (Data) -> Void {
        get {
            return { data in
                guard !Thread.isMainThread else {
                    self.closure?(data)
                    return
                }
                DispatchQueue.main.async {
                    self.closure?(data)
                }
            }
        }
        
        set {
            self.closure = newValue
        }
    }

    public init(_ closure: ((Data) -> Void)?) {
        self.closure = closure
    }
}

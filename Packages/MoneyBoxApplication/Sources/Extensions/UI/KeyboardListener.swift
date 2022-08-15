//
//  KeyboardListener.swift
//  
//
//  Created by Dmytro Vorko on 15.08.2022.
//

import Foundation
import UIKit

public protocol KeyboardListenerDelegate: AnyObject {
    func keyboardFrameWillChange(listener: KeyboardListener, newFrame: CGRect)
}


final public class KeyboardListener: KeyboardNotifiable {
    public weak var delegate: KeyboardListenerDelegate?
    public var keyboardFrame: CGRect?
    public var allowNotify = true
    
    private var token: NSObjectProtocol?
    
    // MARK: - Constructor
    
    public init() {}
    
    // MARK: - Start-Stop listen
    
    public func startListen() {
        token = registerKeyboardNotification(.willChangeFrame) { notification in
            notification.keyboardFrame.map { [weak self] in
                guard let self = self else { return }
                self.keyboardFrame = $0
                guard self.allowNotify else { return }
                self.delegate?.keyboardFrameWillChange(listener: self, newFrame: $0)
            }
        }
    }
    
    public func stopListen() {
        token.map {
            deregisterKeyboardNotification($0, type: .willChangeFrame)
        }
        token = nil
    }
    
    // MARK: - Public Functions
    
    public func isKeyboardShowed(visibleViewController: UIViewController) -> Bool {
        keyboardFrame.map { $0.minY < visibleViewController.view.frame.maxY } ?? false
    }
}

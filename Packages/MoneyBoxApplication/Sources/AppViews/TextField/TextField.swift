//
//  TextField.swift
//  
//
//  Created by Dmytro Vorko on 14.08.2022.
//

import UIKit

open class TextField: UITextField {
    
    // MARK: - Public
    
    public var textInset: UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
    
    // MARK: - Override
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInset)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInset)
    }
}

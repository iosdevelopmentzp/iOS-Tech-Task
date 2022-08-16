//
//  LoginTextField.swift
//  
//
//  Created by Dmytro Vorko on 15.08.2022.
//

import Foundation
import AppViews
import AppResources
import UIKit
import Extensions

protocol LoginTextFieldEventsDelegate: AnyObject {
    func didChangeText(textField: LoginTextField, text: String?)
}

final class LoginTextField: TextField, ViewSettableType {
    // MARK: - Nested
    
    enum Mode {
        case email
        case password
    }
    
    // MARK: - Properties
    
    weak var eventsDelegate: LoginTextFieldEventsDelegate?
    
    let mode: Mode
    
    // MARK: - Constructor
    
    init(mode: Mode) {
        self.mode = mode
        super.init(frame: .zero)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViews() {
        switch mode {
        case .email:
            keyboardType = .emailAddress
            
        case .password:
            keyboardType = .default
            isSecureTextEntry = true
        }
        
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.borderColor = Colors.Border.black.color.cgColor
        font = Fonts.Lato.bold.font(size: 14)
        layer.borderWidth = 1
        layer.cornerRadius = 6
    }
    
    func layoutViews() {
        snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    func setupViewLinks() {
        addTarget(self, action: #selector(self.onTextDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - User Interaction
    
    @objc
    private func onTextDidChange(_ sender: LoginTextField) {
        self.eventsDelegate?.didChangeText(textField: self, text: sender.text)
    }
}

// MARK: - Configure

extension LoginTextField {
    func configure(using model: LoginTextFieldModel) {
        if text != model.text {
            text = model.text
        }
        
        if placeholder != model.placeholder {
            attributedPlaceholder = .init(
                string: model.placeholder,
                attributes: [
                    .font: Fonts.Lato.bold.font(size: 14)
                ]
            )
        }
    }

}

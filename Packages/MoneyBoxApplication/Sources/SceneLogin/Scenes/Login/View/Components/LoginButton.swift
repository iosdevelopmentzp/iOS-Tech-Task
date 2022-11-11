//
//  LoginButton.swift
//  
//
//  Created by Dmytro Vorko on 15.08.2022.
//

import Foundation
import UIKit
import Extensions
import AppResources
import SnapKit

protocol LoginButtonDelegate: AnyObject {
    func didTap(button: LoginButton)
}

final class LoginButton: UIButton, ViewSettableType {
    // MARK: - Nested
    
    fileprivate struct Design {
        static let enabledColor = Colors.Buttons.blue.color
        static let disabledColor = Colors.Buttons.gray.color
        static let animationDuration: TimeInterval = 0.2
    }
    
    // MARK: - Properties
    
    var delegate: LoginButtonDelegate?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        addSubview(indicator)
        indicator.snp.makeConstraints { $0.center.equalToSuperview() }
        indicator.color = .white
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViews() {
        titleLabel?.font = Fonts.Lato.bold.font(size: 20)
        backgroundColor = Colors.Buttons.blue.color
        layer.cornerRadius = 8
    }
    
    func layoutViews() {
        snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    func setupViewLinks() {
        addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
    }
    
    // MARK: - User Interaction
    
    @objc
    private func onTap(_ sender: LoginButton) {
        delegate?.didTap(button: self)
    }
}

// MARK: - Configure

extension LoginButton {
    func configure(using model: LoginButtonModel) {
        self.isEnabled = model.isEnabled
        setTitle(model.title, for: .normal)
        
        if model.backgroundColor != backgroundColor {
            UIView.animate(withDuration: Design.animationDuration) {
                self.backgroundColor = model.backgroundColor
            }
        }
    }
    
    func setActivityIndicator(isAnimating: Bool) {
        guard activityIndicator.isHidden == isAnimating else { return }
        
        isUserInteractionEnabled = !isAnimating
        
        UIView.animate(withDuration: Design.animationDuration) {
            self.titleLabel?.layer.opacity = isAnimating ? 0 : 1
        }
        
        UIView.transition(with: activityIndicator, duration: Design.animationDuration, options: .transitionCrossDissolve) {
            self.activityIndicator.isHidden = !isAnimating
        }
    }
}

// MARK: - LoginButtonModel Extension

private extension LoginButtonModel {
    var backgroundColor: UIColor {
        self.isEnabled ? LoginButton.Design.enabledColor : LoginButton.Design.disabledColor
    }
}

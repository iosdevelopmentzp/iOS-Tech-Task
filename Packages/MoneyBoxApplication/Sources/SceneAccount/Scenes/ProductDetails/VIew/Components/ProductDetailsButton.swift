//
//  ProductDetailsButton.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import UIKit
import SnapKit
import Extensions
import SwiftUI
import AppResources

protocol ProductDetailsButtonDelegate: AnyObject {
    func didTapButton(_ buttonView: ProductDetailsButton, _ sender: UIButton)
}

final class ProductDetailsButton: UIView, ViewSettableType {
    // MARK: - Properties
    
    private let button = UIButton()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    weak var delegate: ProductDetailsButtonDelegate? {
        didSet {
            guard delegate != nil, !button.allTargets.contains(self) else { return }
            button.addTarget(self, action: #selector(self.tapHandler(_:)), for: .touchUpInside)
        }
    }
    
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
        button.isUserInteractionEnabled = false
        button.layer.opacity = 0
        button.layer.cornerRadius = 8
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
    
    func addViews() {
        addSubview(button)
        button.addSubview(activityIndicator)
    }
    
    func layoutViews() {
        let buttonHeight: CGFloat = 44
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(buttonHeight)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(buttonHeight + 40)
        }
    }
    
    // MARK: - User Interaction
    
    @objc
    private func tapHandler(_ sender: UIButton) {
        delegate?.didTapButton(self, sender)
    }
}

// MARK: - Configuration

extension ProductDetailsButton {
    func configure(using model: ProductDetailsButtonModel, animated: Bool) {
        self.button.isUserInteractionEnabled = model.isEnabled
        let action = {
            self.button.setTitle(model.title, for: .normal)
            self.button.backgroundColor = model.backgroundColor
            self.button.titleLabel?.textColor = model.textColor
            self.button.layer.opacity = model.opacity
            self.activityIndicator.isHidden = model.activityIndicatorIsHidden
        }
        guard animated else {
            action()
            return
        }
        
        UIView.animate(withDuration: 0.15) {
            action()
        }
    }
}

// MARK: - ProductDetailsButtonModel Ext

extension ProductDetailsButtonModel {
    var title: String? {
        switch self.state {
        case .active(let text), .inactive(let text):
            return text
            
        case .loading, .hidden:
            return nil
        }
    }
    
    var backgroundColor: UIColor {
        switch self.state {
        case .active, .loading:
            return Colors.appAccent.color
            
        case .hidden, .inactive:
            return .gray
        }
    }
    
    var textColor: UIColor {
        switch self.state {
        case .loading, .hidden, .active, .inactive:
            return .white
        }
    }
    
    var isEnabled: Bool {
        switch self.state {
        case .active:
            return true
            
        case .loading, .hidden, .inactive:
            return false
        }
    }
    
    var opacity: Float {
        switch self.state {
        case .active, .loading, .inactive:
            return 1
            
        case .hidden:
            return 0
        }
    }
    
    var activityIndicatorIsHidden: Bool {
        switch self.state {
        case .loading:
            return false
            
        case .active, .hidden, .inactive:
            return true
        }
    }
}

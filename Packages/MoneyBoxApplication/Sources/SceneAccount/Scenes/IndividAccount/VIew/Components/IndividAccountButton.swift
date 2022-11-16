//
//  IndividAccountButton.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import UIKit
import SnapKit
import Extensions

protocol IndividAccountButtonDelegate: AnyObject {
    func didTapButton(_ buttonView: IndividAccountButton, _ sender: UIButton)
}

final class IndividAccountButton: UIView, ViewSettableType {
    // MARK: - Properties
    
    private let button = UIButton()
    
    weak var delegate: IndividAccountButtonDelegate? {
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
        addSubview(button)
    }
    
    func layoutViews() {
        let buttonHeight: CGFloat = 44
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(buttonHeight)
            $0.width.equalToSuperview().multipliedBy(0.8)
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

extension IndividAccountButton {
    func configure(using model: IndividAccountButtonModel) {
        button.setTitle(model.title, for: .normal)
        button.backgroundColor = model.backgroundColor
        button.titleLabel?.textColor = model.textColor
        
    }
}

// MARK: - IndividAccountButtonModel Ext

extension IndividAccountButtonModel {
    var title: String? {
        switch self.state {
        case .active(let text):
            return text
            
        case .loading, .hidden:
            return nil
        }
    }
    
    var backgroundColor: UIColor {
        switch self.state {
        case .active:
            return .blue
            
        case .loading, .hidden:
            return .brown
        }
    }
    
    var textColor: UIColor {
        switch self.state {
        case .active:
            return .white
            
        case .loading, .hidden:
            return .white
        }
    }
    
    var isEnabled: Bool {
        switch self.state {
        case .active:
            return true
            
        case .loading, .hidden:
            return false
        }
    }
}

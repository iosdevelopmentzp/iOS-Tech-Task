//
//  ErrorCell.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import UIKit
import Extensions

public protocol ErrorCellEventsDelegate: AnyObject {
    func cell(_ cell: ErrorCell, didPressRetryButton sender: UIButton)
}

public final class ErrorCell: DynamicCollectionCell, ViewSettableType, Reusable {
    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let errorImageView = UIImageView()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let retryButton = UIButton()
    
    public weak var delegate: ErrorCellEventsDelegate?
    
    // MARK: - Constructor
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        errorImageView.contentMode = .scaleAspectFill
        errorImageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            errorImageView.image = UIImage(systemName: "exclamationmark.triangle")
            errorImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        } else {
            // TODO: - Configuration for iOS 12 and earlier
        }
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        contentStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        
        titleLabel.textColor = UIColor(named: "PrimaryText")
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.text = "Error"
        
        descriptionLabel.textColor = UIColor(named: "PrimaryText")
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "An error has occurred"
        
        retryButton.addTarget(self, action: #selector(onRetryButtonTap(_:)), for: .primaryActionTriggered)
        retryButton.setTitle("Try Again", for: .normal)
        retryButton.backgroundColor = .systemGreen
        retryButton.layer.cornerRadius = 8
    }
    
    public func addViews() {
        container.addSubview(stackView)
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(retryButton)
        
        retryButton.snp.makeConstraints {
            $0.width.equalTo(90)
        }
    }
    
    public func layoutViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - User Interaction
    
    @objc
    private func onRetryButtonTap(_ sender: UIButton) {
        delegate?.cell(self, didPressRetryButton: sender)
    }
}

// MARK: - Configure

public extension ErrorCell {
    func configure(using message: String) {
        descriptionLabel.text = message
    }
}

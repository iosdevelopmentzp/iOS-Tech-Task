//
//  LoadingCell.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import UIKit
import Extensions
import SnapKit

public final class LoadingCell: DynamicCollectionCell, ViewSettableType, Reusable {
    // MARK: - Properties
    
    private let activityIndicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .medium)
        } else {
            return UIActivityIndicatorView(style: .gray)
        }
    }()
    
    // MARK: - Constructor
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
    }
    
    public func addViews() {
        container.addSubview(activityIndicator)
    }
    
    public func layoutViews() {
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        container.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
}

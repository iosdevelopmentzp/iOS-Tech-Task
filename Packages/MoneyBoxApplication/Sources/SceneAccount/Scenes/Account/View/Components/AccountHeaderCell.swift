//
//  AccountHeaderCell.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import UIKit
import Extensions
import AppResources
import SnapKit
import AppViews

final class AccountHeaderCell: DynamicCollectionCell, ViewSettableType, Reusable {
    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let subtitle = UILabel()
    private let totalPlanLabel = UILabel()
    
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
        isUserInteractionEnabled = false
        
        [subtitle, totalPlanLabel].forEach {
            $0.font = Fonts.Lato.bold.font(size: 19)
            $0.textColor = Colors.Font.black.color
            $0.numberOfLines = 0
            $0.textAlignment = .left
        }
        
        stackView.axis = .vertical
        stackView.spacing = 4
    }
    
    func addViews() {
        container.addSubview(stackView)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(totalPlanLabel)
    }
    
    func layoutViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Configure

extension AccountHeaderCell {
    func configure(using model: AccountHeaderCellModel) {
        self.subtitle.text = model.name
        self.totalPlanLabel.text = model.planValueText
    }
}

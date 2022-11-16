//
//  IndividAccountCell.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation
import UIKit
import Extensions
import AppResources
import AppViews
import SnapKit

final class IndividAccountCell: DynamicCollectionCell, ViewSettableType, Reusable {
    // MARK: - Properties
    
    private let contentContainerView = UIView()
    private let nameLabel = UILabel()
    private let planValueLabel = UILabel()
    private let moneyboxLabel = UILabel()
    private let stackView = UIStackView()
    
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
        stackView.axis = .vertical
        stackView.spacing = 4
        
        [nameLabel, planValueLabel, moneyboxLabel].forEach {
            $0.font = Fonts.Lato.regular.font(size: 16)
            $0.textColor = Colors.Font.black.color
            $0.numberOfLines = 1
        }
    }
    
    func addViews() {
        container.addSubview(contentContainerView)
        contentContainerView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(planValueLabel)
        stackView.addArrangedSubview(moneyboxLabel)
    }
    
    func layoutViews() {
        contentContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(4)
        }
    }
}

// MARK: - Configure

extension IndividAccountCell {
    func configure(using model: IndividAccountCellModel) {
        nameLabel.text = model.name
        planValueLabel.text = model.planValueText
        moneyboxLabel.text = model.moneyBoxValueText
    }
}

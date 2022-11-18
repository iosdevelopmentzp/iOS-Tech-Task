//
//  ProductCell.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import UIKit
import Extensions
import AppResources
import AppViews
import SnapKit

final class ProductCell: DynamicCollectionCell, ViewSettableType, Reusable {
    // MARK: - Properties
    
    private let contentContainerView = UIView()
    private let nameLabel = UILabel()
    private let planValueLabel = UILabel()
    private let moneyboxLabel = UILabel()
    private let stackView = UIStackView()
    private let accessoryImageView = UIImageView()
    
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
        
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryImageView.image = Images.Account.accessorRightArrow.image
        
        [nameLabel, planValueLabel, moneyboxLabel].forEach {
            $0.font = Fonts.Lato.regular.font(size: 16)
            $0.textColor = Colors.Font.black.color
            $0.numberOfLines = 1
        }
        
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.borderWidth = 1
        contentContainerView.layer.borderColor = Colors.Border.black.color.cgColor
    }
    
    func addViews() {
        container.addSubview(contentContainerView)
        contentContainerView.addSubview(accessoryImageView)
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
        
        accessoryImageView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.left.equalTo(self.stackView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Configure

extension ProductCell {
    func configure(using model: ProductCellModel) {
        nameLabel.text = model.name
        planValueLabel.text = model.planValueText
        moneyboxLabel.text = model.moneyBoxValueText
    }
}

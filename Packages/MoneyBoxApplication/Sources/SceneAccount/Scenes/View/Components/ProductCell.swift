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

final class ProductCell: UICollectionViewCell, ViewSettableType {
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
            $0.font = Fonts.Lato.regular.font(size: 19)
            $0.textColor = Colors.Font.black.color
            $0.numberOfLines = 1
        }
    }
    
    func addViews() {
        contentView.addSubview(contentContainerView)
        contentContainerView.addSubview(accessoryImageView)
        contentContainerView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(planValueLabel)
        stackView.addArrangedSubview(moneyboxLabel)
    }
    
    func layoutViews() {
        contentContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        
        accessoryImageView.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.left.equalTo(self.stackView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
        }
    }
}

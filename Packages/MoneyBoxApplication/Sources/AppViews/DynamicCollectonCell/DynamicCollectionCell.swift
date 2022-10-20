//
//  DynamicCollectionCell.swift
//  
//
//  Created by Dmytro Vorko on 03.08.2022.
//

import UIKit
import SnapKit

/// Cell that can be used as base class for custom cells that are using for height dynamic collection view
/// During layout of cell subviews, content view  should be pinned to the bottom of content
///
open class DynamicCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    
    /// Use this view for container for your subviews
    public let container = UIView()
    
    private lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    // MARK: - Constructor
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(container.snp.bottom)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    open override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority
    ) -> CGSize {
        width.constant = bounds.size.width
        let size = contentView.systemLayoutSizeFitting(
            .init(width: targetSize.width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return size
    }
}

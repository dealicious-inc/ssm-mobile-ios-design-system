//
//  DealiEmptyCollectionViewCell.swift
//  
//
//  Created by Hoji on 5/23/24.
//

import UIKit

public class DealiEmptyCollectionViewCell: UICollectionViewCell {
    
    public static let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: 460.0)
    
    private let emptyView = DealiEmptyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        
        self.contentView.addSubview(self.emptyView)
        self.emptyView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setEmpty(imageType: DealiEmptyImageType = .notice, title: String? = nil, message: String, actionButtonTitle: String? = nil, actionHandler: (() -> Void)? = nil) {
        
        self.emptyView.set(imageType: imageType,
                           title: title,
                           message: message,
                           actionButtonTitle: actionButtonTitle,
                           actionHandler: actionHandler)
    }
}

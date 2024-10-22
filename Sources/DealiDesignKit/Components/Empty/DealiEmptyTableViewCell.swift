//
//  DealiEmptyTableViewCell.swift
//  
//
//  Created by Hoji on 5/23/24.
//

import UIKit

public class DealiEmptyTableViewCell: UITableViewCell {
    
    public static let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: 460.0)
    
    private let emptyView = DealiEmptyView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.do {
            $0.clipsToBounds = true
            $0.contentView.clipsToBounds = true
            $0.contentView.backgroundColor = .primary04
        }
        
        self.contentView.addSubview(self.emptyView)
        self.emptyView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setEmpty(imageType: DealiEmptyImageType = .notice, title: String? = nil, message: String, actionButtonTitle: String? = nil, actionHandler: (() -> Void)? = nil) {
        
        self.emptyView.set(imageType: imageType,
                           title: title,
                           message: message,
                           actionButtonTitle: actionButtonTitle,
                           actionHandler: actionHandler)
    }

}

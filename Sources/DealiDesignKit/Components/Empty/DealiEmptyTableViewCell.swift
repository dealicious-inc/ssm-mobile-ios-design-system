//
//  DealiEmptyTableViewCell.swift
//  
//
//  Created by Hoji on 5/23/24.
//

import UIKit

public class DealiEmptyTableViewCell: UITableViewCell {
    
    /// 셀 높이. 폭은 목록 폭을 그대로 쓴다.
    public static let cellHeight: CGFloat = 460.0

    /// 목록 폭에 맞춘 셀 크기. 화면 폭 대신 컬렉션뷰·테이블뷰 폭을 넘긴다.
    public static func cellSize(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: cellHeight)
    }

    @available(*, deprecated, message: "화면 폭 고정값이라 iPhone Duo처럼 창 폭이 바뀌는 기기에서 맞지 않는다. cellSize(width:)를 사용한다.")
    public static let cellSize = CGSize(width: dealiWindowSize().width, height: cellHeight)
    
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

//
//  DealiBadge.swift
//  DealiDesignKit
//
//  Created by Nam Jun Lee on 3/28/25.
//

import UIKit

public enum DealiBadgeType: CaseIterable {
    case small
    case medium
    case singleDigit
    case doubleDigit
    case smallN
    case mdeiumN
    case largeN
    
    var image: UIImage? {
        switch self {
        case .smallN:
            .dealiIcon(named: "ic_new_s")
        case .medium:
            .dealiIcon(named: "ic_new_m")
        case .largeN:
            .dealiIcon(named: "ic_new_l")
        default:
            nil
        }
    }
}

final public class DealiBadge: UIView {
    
    var badgeType: DealiBadgeType
    var badgeCount: Int? {
        didSet {
            guard let badgeCount else { return }
            
            if self.countLabel.superview == nil {
                self.badgeCount = badgeCount
                self.addCountLabel(count: badgeCount)
            } else {
                self.countLabel.text = "\(badgeCount)"
            }
        }
    }
    
    var size: CGSize {
        switch self.badgeType {
        case .small:
            return CGSize(width: 4.0, height: 4.0)
        case .medium:
            return CGSize(width: 5.0, height: 5.0)
        case .singleDigit:
            return CGSize(width: 16.0, height: 16.0)
        case .doubleDigit:
            return self.systemLayoutSizeFitting(CGSize(width: UIView.layoutFittingCompressedSize.width, height: 14.0))
        case .smallN:
            return CGSize(width: 14.0, height: 14.0)
        case .mdeiumN:
            return CGSize(width: 16.0, height: 16.0)
        case .largeN:
            return CGSize(width: 18.0, height: 18.0)
        }
    }
    
    private let countLabel = UILabel()
    private let imageView = UIImageView()
    
    init(badgeType: DealiBadgeType, badgeCount: Int? = nil) {
        self.badgeType = badgeType
        super.init(frame: .zero)
        
        self.backgroundColor = .primary01
        
        if let badgeCount {
            self.badgeCount = badgeCount
            self.addCountLabel(count: badgeCount)
        } else if let image = self.badgeType.image {
            self.addImageView(image: image)
        }
        
        self.setCornerRadius(self.size.height / 2.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        self.frame.size = self.size
    }

    
    private func addCountLabel(count: Int) {
        self.addSubview(self.countLabel)
        self.countLabel.then {
            $0.font = .c1sb10
            $0.textColor = .primary04
            $0.text = "\(count)"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(self.badgeType == .doubleDigit ? 4.0 : 0.0)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    private func addImageView(image: UIImage) {
        self.addSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
            $0.image = image
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

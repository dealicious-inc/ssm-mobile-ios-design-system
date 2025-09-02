//
//  BadgeViewController.swift
//  DealiDesignKit
//
//  Created by Nam Jun Lee on 4/4/25.
//

import UIKit
import DealiDesignKit

final class BadgeViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        let stackView = UIStackView()
        
        for badgeType in DealiBadgeType.allCases {
            var badge: DealiBadge
            switch badgeType {
            case .singleDigit:
                badge = DealiBadge(badgeType: .singleDigit, badgeCount: 9)
            case .doubleDigit:
                badge = DealiBadge(badgeType: .doubleDigit, badgeCount: 99)
            default:
                badge = DealiBadge(badgeType: badgeType)

            }
            
            stackView.addArrangedSubview(badge)
            badge.snp.makeConstraints {
                $0.size.equalTo(badge.size)
            }
        }
        
        self.view.addSubview(stackView)
        stackView.then {
            $0.axis = .horizontal
            $0.spacing = 4.0
            $0.alignment = .center
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}

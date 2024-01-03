//
//  HapticEffectViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/01/03.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class HapticEffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Haptic Effect"
        self.view.backgroundColor = .white
    }

    override func loadView() {
        super.loadView()
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        let hapticEffectSoftButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectSoftButton)
        hapticEffectSoftButton.then {
            $0.title = "Soft"
            $0.addTarget(self, action: #selector(hapticEffectSoftButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectRigidButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectRigidButton)
        hapticEffectRigidButton.then {
            $0.title = "Rigid"
            $0.addTarget(self, action: #selector(hapticEffectRigidButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectMediumButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectMediumButton)
        hapticEffectMediumButton.then {
            $0.title = "Medium"
            $0.addTarget(self, action: #selector(hapticEffectMediumButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectLightButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectLightButton)
        hapticEffectLightButton.then {
            $0.title = "Light"
            $0.addTarget(self, action: #selector(hapticEffectLightButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectHeavyButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectHeavyButton)
        hapticEffectHeavyButton.then {
            $0.title = "Heavy"
            $0.addTarget(self, action: #selector(hapticEffectHeavyButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let hapticEffectSelectionButton = DealiControl.btnOutlineLargePrimary01()
        contentStackView.addArrangedSubview(hapticEffectSelectionButton)
        hapticEffectSelectionButton.then {
            $0.title = "Selection"
            $0.addTarget(self, action: #selector(hapticEffectSelectionButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}

extension HapticEffectViewController {
    @objc func hapticEffectSoftButtonPressed() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    
    @objc func hapticEffectRigidButtonPressed() {
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
    }
    
    @objc func hapticEffectMediumButtonPressed() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    @objc func hapticEffectLightButtonPressed() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    @objc func hapticEffectHeavyButtonPressed() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    @objc func hapticEffectSelectionButtonPressed() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
}

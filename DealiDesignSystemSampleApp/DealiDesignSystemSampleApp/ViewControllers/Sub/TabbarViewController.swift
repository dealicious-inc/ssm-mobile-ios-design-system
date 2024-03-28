//
//  TabbarViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/03/28.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class TabbarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Tabbar"
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
            $0.spacing = 20.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let segmentTabbarItems: [DealiTabBarItem] = [DealiTabBarItem.make(title: "Text01"), DealiTabBarItem.make(title: "Text02"), DealiTabBarItem.make(title: "Text03")]
        let sliderTabbarItems: [DealiTabBarItem] = [DealiTabBarItem.make(title: "Text01"), DealiTabBarItem.make(title: "Text02"), DealiTabBarItem.make(title: "Text03"), DealiTabBarItem.make(title: "Text04"), DealiTabBarItem.make(title: "Text05"), DealiTabBarItem.make(title: "Text06"), DealiTabBarItem.make(title: "Text07"), DealiTabBarItem.make(title: "Text08")]
        
        let segmentTabbar = DealiTabber.testTabberSegment()
        contentStackView.addArrangedSubview(segmentTabbar)
        segmentTabbar.then {
            $0.setTabbarItems(tabbarItemArray: segmentTabbarItems)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sliderTabbar = DealiTabber.testTabberSlider()
        contentStackView.addArrangedSubview(sliderTabbar)
        sliderTabbar.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let chipSliderTabbar = DealiTabber.testTabberChip()
        contentStackView.addArrangedSubview(chipSliderTabbar)
        chipSliderTabbar.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let depthTabbar = DealiTabber.testTabber3Depth()
        contentStackView.addArrangedSubview(depthTabbar)
        depthTabbar.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
    }

}

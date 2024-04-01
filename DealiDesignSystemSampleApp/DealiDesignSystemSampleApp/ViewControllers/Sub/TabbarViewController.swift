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
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(statusBarHeight + navigationBarHeight)
            $0.bottom.left.right.equalToSuperview()
        }
        
        var sliderTabbarItems = [DealiTabBarItem]()
        for i in 0..<8 {
            let contentViewController = TabbarChildViewController()
            switch i {
            case 0:
                contentViewController.viewControllerLog = "첫번째"
                contentViewController.view.backgroundColor = .yellow
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TextText_\(i)"))
            case 1:
                contentViewController.viewControllerLog = "두번째"
                contentViewController.view.backgroundColor = .green
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "Text_\(i)"))
            case 2:
                contentViewController.viewControllerLog = "세번째"
                contentViewController.view.backgroundColor = .gray
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TextTextText_\(i)"))
            case 3:
                contentViewController.viewControllerLog = "네번째"
                contentViewController.view.backgroundColor = .purple
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TextText_\(i)"))
            case 4:
                contentViewController.viewControllerLog = "다섯번째"
                contentViewController.view.backgroundColor = .red
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "Text_\(i)"))
            case 5:
                contentViewController.viewControllerLog = "여섯번째"
                contentViewController.view.backgroundColor = .blue
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TextTextTextTextText_\(i)"))
            case 6:
                contentViewController.viewControllerLog = "일곱번째"
                contentViewController.view.backgroundColor = .brown
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TextText_\(i)"))
            case 7:
                contentViewController.viewControllerLog = "여덟번째"
                contentViewController.view.backgroundColor = .orange
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "Text_\(i)"))
            default:
                contentViewController.view.backgroundColor = .black
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TexTextTextTextTextt_\(i)"))
                contentViewController.viewControllerLog = "아홉번째"
            }
            
        }
        
        let segmentViewController = DealiScrollSegmentTabBarViewController(tabbarView: DealiTabber.testTabberSlider())
        segmentViewController.tabbarItemArray = sliderTabbarItems
        
        segmentViewController.willMove(toParent: self)
        
        self.addChild(segmentViewController)
        segmentViewController.view.frame = contentView.bounds
        contentView.addSubview(segmentViewController.view)
        
        segmentViewController.didMove(toParent: self)
        
        
        
        
//        let contentScrollView = UIScrollView()
//        self.view.addSubview(contentScrollView)
//        contentScrollView.then {
//            $0.bounces = false
//        }.snp.makeConstraints {
//            $0.top.bottom.left.right.equalToSuperview()
//        }
//        
//        let contentView = UIView()
//        contentScrollView.addSubview(contentView)
//        contentView.then {
//            $0.backgroundColor = .clear
//        }.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
//        }
//        
//        let contentStackView = UIStackView()
//        contentView.addSubview(contentStackView)
//        contentStackView.then {
//            $0.axis = .vertical
//            $0.spacing = 20.0
//            $0.alignment = .center
//            $0.distribution = .equalSpacing
//        }.snp.makeConstraints {
//            $0.top.bottom.left.right.equalToSuperview()
//        }
//        
//        let segmentTabbarItems: [DealiTabBarItem] = [DealiTabBarItem.make(title: "Text01"), DealiTabBarItem.make(title: "Text02"), DealiTabBarItem.make(title: "Text03")]
//        let sliderTabbarItems: [DealiTabBarItem] = [DealiTabBarItem.make(title: "Text01"), DealiTabBarItem.make(title: "Text02"), DealiTabBarItem.make(title: "Text03"), DealiTabBarItem.make(title: "Text04"), DealiTabBarItem.make(title: "Text05"), DealiTabBarItem.make(title: "Text06"), DealiTabBarItem.make(title: "Text07"), DealiTabBarItem.make(title: "Text08")]
//        
//        let segmentTabbar = DealiTabber.testTabberSegment()
//        contentStackView.addArrangedSubview(segmentTabbar)
//        segmentTabbar.then {
//            $0.setTabbarItems(tabbarItemArray: segmentTabbarItems)
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        
//        let sliderTabbar = DealiTabber.testTabberSlider()
//        contentStackView.addArrangedSubview(sliderTabbar)
//        sliderTabbar.then {
//            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        
//        let chipSliderTabbar = DealiTabber.testTabberChip()
//        contentStackView.addArrangedSubview(chipSliderTabbar)
//        chipSliderTabbar.then {
//            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        
//        let depthTabbar = DealiTabber.testTabber3Depth()
//        contentStackView.addArrangedSubview(depthTabbar)
//        depthTabbar.then {
//            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
        
    }

}


public var statusBarHeight: CGFloat {
    let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    let statusBarManager = window?.windowScene?.statusBarManager
    let topPadding = window?.safeAreaInsets.top
    return topPadding ?? (statusBarManager?.statusBarFrame.height ?? 0.0)
}
public let navigationBarHeight = UINavigationController().navigationBar.intrinsicContentSize.height

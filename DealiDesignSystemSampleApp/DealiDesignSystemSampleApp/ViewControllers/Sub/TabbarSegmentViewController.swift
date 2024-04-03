//
//  TabbarSegmentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 4/3/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class TabbarSegmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabbarSegment"
        self.view.backgroundColor = .white
    }

    override func loadView() {
        super.loadView()
        
        var sliderTabbarItems = [DealiTabBarItem]()
        for i in 0..<3 {
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
            default:
                contentViewController.view.backgroundColor = .black
                sliderTabbarItems.append(DealiTabBarItem.make(contentViewController, title: "TexTextTextTextTextt_\(i)"))
                contentViewController.viewControllerLog = "아홉번째"
            }
            
        }
        
        let topTabbarView = DealiTabber.testTabberSegment()
        self.view.addSubview(topTabbarView)
        topTabbarView.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(statusBarHeight + navigationBarHeight)
            $0.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.top.equalTo(topTabbarView.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        
        let segmentViewController = DealiScrollSegmentTabBarViewController(tabbarView: DealiTabber.testTabberSegment())
        segmentViewController.tabbarItemArray = sliderTabbarItems
        
        segmentViewController.willMove(toParent: self)
        
        self.addChild(segmentViewController)
        segmentViewController.view.frame = contentView.bounds
        contentView.addSubview(segmentViewController.view)
        
        segmentViewController.didMove(toParent: self)
        
    }

}

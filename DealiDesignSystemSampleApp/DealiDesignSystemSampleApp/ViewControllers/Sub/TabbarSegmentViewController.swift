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

    let topTabbarView = DealiTabber.testTabberSegment()
    let segmentViewController = DealiScrollSegmentTabBarViewController(tabbarView: DealiTabber.testTabberSegment())
    
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
        
        self.view.addSubview(self.topTabbarView)
        self.topTabbarView.then {
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
        
        
        self.segmentViewController.tabbarItemArray = sliderTabbarItems
        
        self.segmentViewController.willMove(toParent: self)
        
        self.addChild(self.segmentViewController)
        self.segmentViewController.view.frame = contentView.bounds
        contentView.addSubview(self.segmentViewController.view)
        
        self.segmentViewController.didMove(toParent: self)
        
        
        let button01 = DealiControl.btnOutlineLarge01()
        contentView.addSubview(button01)
        button01.then {
            $0.title = "2버튼 팝업"
            $0.addTarget(self, action: #selector(button01Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100.0)
        }
        
        let button02 = DealiControl.btnOutlineLarge01()
        contentView.addSubview(button02)
        button02.then {
            $0.title = "1버튼 팝업"
            $0.addTarget(self, action: #selector(button02Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-150.0)
        }
    }

}

extension TabbarSegmentViewController {
    @objc func button01Pressed() {
        print("button01Pressed")

        self.topTabbarView.changeTabBarButtonTitle(index: 1, title: "title변경 테스트")
        self.segmentViewController.changeTabBarButtonTitle(index: 1, title: "title변경 테스트")
    }
    
    @objc func button02Pressed() {
        print("button01Pressed")

        self.topTabbarView.changeTabBarButtonTitle(index: 1, title: "title")
        self.segmentViewController.changeTabBarButtonTitle(index: 1, title: "title")
    }
}

//
//  TabBarViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 11/5/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

class TabBarViewController: UIViewController {
    
    private var segmentTabBarItemArray = [DealiTabBarItem.make(title: "전체"),
                                  DealiTabBarItem.make(title: "여성의류"),
                                          DealiTabBarItem.make(title: "여성잡화")]
    
    private var sliderTabBarItemArray = [DealiTabBarItem.make(title: "1번 Tab"),
                                  DealiTabBarItem.make(title: "2번 Tab"),
                                  DealiTabBarItem.make(title: "3번 Tab"),
//                                 DealiTabBarItem.make(title: "4번 Tab"),
                                         DealiTabBarItem.make(title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0))),
                                 DealiTabBarItem.make(title: "5번 Tab"),
                                 DealiTabBarItem.make(title: "6번 Tab"),
                                 DealiTabBarItem.make(title: "7번 Tab"),
                                 DealiTabBarItem.make(title: "8번 Tab"),
                                 DealiTabBarItem.make(title: "9번 Tab")]
    
    private var tabBarSegment01ViewController: DealiTabBarViewController?
    private var tabBarSlider01ViewController: DealiTabBarViewController?
    private var tabBarSlider02ViewController: DealiTabBarViewController?
    
    private let tabBarSegment01 = DealiTabBar_v2.tabBarSegment01()
    private let tabBarSlider01 = DealiTabBar_v2.tabBarSlider01()
    private let tabBarSlider02 = DealiTabBar_v2.tabBarSlider02()
    private let tabBarChip01 = DealiTabBar_v2.tabBarChip01()
    
    private let tabBarSegment01ContentView = UIView()
    private let tabBarSlider01ContentView = UIView()
    private let tabBarSlider02ContentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar_V2"
        self.view.backgroundColor = .white
        
        self.setTabBar()
        
//        self.tabBarView02.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 1, isStandAloneView: true)
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
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing =  10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
        
        let tabBarSegment01TitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarSegment01TitleLabel)
        tabBarSegment01TitleLabel.do {
            $0.text = "tabBarSegment01"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarSegment01)
        self.tabBarSegment01.then {
            $0.setTabBarItems(tabBarItemArray: segmentTabBarItemArray)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let tabBarSlider01TitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarSlider01TitleLabel)
        tabBarSlider01TitleLabel.do {
            $0.text = "tabBarSlider01"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarSlider01)
        self.tabBarSlider01.then {
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 6, isStandAloneView: true)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let tabBarSlider02TitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarSlider02TitleLabel)
        tabBarSlider02TitleLabel.do {
            $0.text = "tabBarSlider02"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarSlider02)
        self.tabBarSlider02.then {
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 4, isStandAloneView: true)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let tabBarChip01TitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarChip01TitleLabel)
        tabBarChip01TitleLabel.do {
            $0.text = "tabBarChip01"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarChip01)
        self.tabBarChip01.then {
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 1, isStandAloneView: true)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let tabBarSegment01ViewControllerTitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarSegment01ViewControllerTitleLabel)
        tabBarSegment01ViewControllerTitleLabel.do {
            $0.text = "tabBarSegment01_ViewController"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarSegment01ContentView)
        self.tabBarSegment01ContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300.0)
        }
        
        let tabBarSlider01ViewControllerTitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarSlider01ViewControllerTitleLabel)
        tabBarSlider01ViewControllerTitleLabel.do {
            $0.text = "tabBarSlider01_ViewController"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarSlider01ContentView)
        self.tabBarSlider01ContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300.0)
        }
        
        let tabBarSlider02ViewControllerTitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarSlider02ViewControllerTitleLabel)
        tabBarSlider02ViewControllerTitleLabel.do {
            $0.text = "tabBarSlider02_ViewController"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarSlider02ContentView)
        self.tabBarSlider02ContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300.0)
        }
    }

    private func setTabBar() {
        var segmentTabBarItems: [DealiTabBarItem] = []
        for i in 0..<3 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            self.segmentTabBarItemArray[i].viewController = viewController
            if i == 1 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                segmentTabBarItems.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                segmentTabBarItems.append(tabBarItem)
            }
        }
        
        
        var tabBarSlider01Items: [DealiTabBarItem] = []
        for i in 0..<10 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            if i == 3 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                tabBarSlider01Items.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                tabBarSlider01Items.append(tabBarItem)
            }
        }
        
        var tabBarSlider02Items: [DealiTabBarItem] = []
        for i in 0..<10 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            if i == 3 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                tabBarSlider02Items.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                tabBarSlider02Items.append(tabBarItem)
            }
        }

        let tabBarSegment01View = DealiTabBar_v2.tabBarSegment01()
        self.tabBarSegment01ViewController = DealiTabBarViewController(tabBarView: tabBarSegment01View, tabBarItemArray: segmentTabBarItems)
        self.tabBarSegment01ViewController?.startPageIndex = 7
        if let tabBarSegment01ViewController = self.tabBarSegment01ViewController {
            self.insertChildController(tabBarSegment01ViewController, intoParentView: self.tabBarSegment01ContentView)
        }
        
        let tabBarSlider01View = DealiTabBar_v2.tabBarSlider01()
        self.tabBarSlider01ViewController = DealiTabBarViewController(tabBarView: tabBarSlider01View, tabBarItemArray: tabBarSlider01Items)
        self.tabBarSlider01ViewController?.startPageIndex = 1
        if let tabBarSlider01ViewController = self.tabBarSlider01ViewController {
            self.insertChildController(tabBarSlider01ViewController, intoParentView: self.tabBarSlider01ContentView)
        }
        
        let tabBarSlider02View = DealiTabBar_v2.tabBarSlider02()
        self.tabBarSlider02ViewController = DealiTabBarViewController(tabBarView: tabBarSlider02View, tabBarItemArray: tabBarSlider02Items)
        self.tabBarSlider02ViewController?.startPageIndex = 5
        if let tabBarSlider02ViewController = self.tabBarSlider02ViewController {
            self.insertChildController(tabBarSlider02ViewController, intoParentView: self.tabBarSlider02ContentView)
        }
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

extension TabBarViewController: DealiTabBarViewDelegate_v2 {
    func didSelectTabBar(_ tabbarView: DealiTabBarView_v2, selectedIndex index: Int, showScrollAnimation animation: Bool) {
        print("didSelectTabBar index = \(index)")
    }
}

extension UIViewController {
    
    func insertChildController(_ childController: UIViewController, intoParentView parentView: UIView) {
        childController.willMove(toParent: self)
        
        self.addChild(childController)
        childController.view.frame = parentView.bounds
        parentView.addSubview(childController.view)
        
        childController.didMove(toParent: self)
    }
    
}

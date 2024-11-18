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
    
    private var segmentTabBarItems: [DealiTabBarItem] = []
    private var tabBarSlider01Items: [DealiTabBarItem] = []
    private var tabBarSlider02Items: [DealiTabBarItem] = []
    
    private var tabBarSegment01ViewController: DealiTabBarViewController?
    private var tabBarSlider01ViewController: DealiTabBarViewController?
    private var tabBarSlider02ViewController: DealiTabBarViewController?
    
    private let tabBarSegment01 = DealiTabBar.tabBarSegment01()
    private let tabBarSlider01 = DealiTabBar.tabBarSlider01()
    private let tabBarSlider02 = DealiTabBar.tabBarSlider02()
    private let tabBarChip01 = DealiTabBar.tabBarChip01()
    
    private let tabBarSegment01ContentView = UIView()
    private let tabBarSlider01ContentView = UIView()
    private let tabBarSlider02ContentView = UIView()
    
    private let badgeOnOffButton = DealiControl.btnOutlineLarge01()
    private let moveTabBatItemButton = DealiControl.btnOutlineLarge01()
    private let hiddenTabBatItemButton = DealiControl.btnOutlineLarge01()
    private let changeTitleTabBatItemButton = DealiControl.btnOutlineLarge01()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar_V2"
        self.view.backgroundColor = .white
        
        self.setTabBar()
    }
    
    override func loadView() {
        super.loadView()
        
        let buttonContainerView = UIView()
        self.view.addSubview(buttonContainerView)
        buttonContainerView.then {
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
        
        let buttonContainerStackView = UIStackView()
        buttonContainerView.addSubview(buttonContainerStackView)
        buttonContainerStackView.then {
            $0.axis = .vertical
            $0.spacing =  10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.left.right.equalToSuperview()
        }
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonContainerView.snp.top)
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
        
        buttonContainerStackView.addArrangedSubview(self.badgeOnOffButton)
        self.badgeOnOffButton.then {
            $0.title = "뱃지 Off"
            $0.isSelected = false
            $0.addTarget(self, action: #selector(badgeOnOffButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        buttonContainerStackView.addArrangedSubview(self.moveTabBatItemButton)
        self.moveTabBatItemButton.then {
            $0.title = "특정 탭으로 이동"
            $0.addTarget(self, action: #selector(moveTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        buttonContainerStackView.addArrangedSubview(self.hiddenTabBatItemButton)
        self.hiddenTabBatItemButton.then {
            $0.title = "특정 탭 숨김"
            $0.isSelected = false
            $0.addTarget(self, action: #selector(hiddenTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        buttonContainerStackView.addArrangedSubview(self.changeTitleTabBatItemButton)
        self.changeTitleTabBatItemButton.then {
            $0.title = "특정 탭 Title 변경"
            $0.addTarget(self, action: #selector(changeTitleTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }

    private func setTabBar() {
        for i in 0..<3 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            self.segmentTabBarItemArray[i].viewController = viewController
            if i == 1 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                self.segmentTabBarItems.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                self.segmentTabBarItems.append(tabBarItem)
            }
        }
        
        for i in 0..<10 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            if i == 3 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                self.tabBarSlider01Items.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                self.tabBarSlider01Items.append(tabBarItem)
            }
        }
        
        for i in 0..<10 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            if i == 3 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                self.tabBarSlider02Items.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                self.tabBarSlider02Items.append(tabBarItem)
            }
        }

        let tabBarSegment01View = DealiTabBar.tabBarSegment01()
        self.tabBarSegment01ViewController = DealiTabBarViewController(tabBarView: tabBarSegment01View, tabBarItemArray: self.segmentTabBarItems)
        self.tabBarSegment01ViewController?.startPageIndex = 7
        if let tabBarSegment01ViewController = self.tabBarSegment01ViewController {
            self.insertChildController(tabBarSegment01ViewController, intoParentView: self.tabBarSegment01ContentView)
        }
        
        let tabBarSlider01View = DealiTabBar.tabBarSlider01()
        self.tabBarSlider01ViewController = DealiTabBarViewController(tabBarView: tabBarSlider01View, tabBarItemArray: self.tabBarSlider01Items)
        self.tabBarSlider01ViewController?.startPageIndex = 1
        if let tabBarSlider01ViewController = self.tabBarSlider01ViewController {
            self.insertChildController(tabBarSlider01ViewController, intoParentView: self.tabBarSlider01ContentView)
        }
        
        let tabBarSlider02View = DealiTabBar.tabBarSlider02()
        self.tabBarSlider02ViewController = DealiTabBarViewController(tabBarView: tabBarSlider02View, tabBarItemArray: self.tabBarSlider02Items)
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

extension TabBarViewController {
    @objc func badgeOnOffButtonPressed() {
        print("badgeOnOffButtonPressed")
        self.badgeOnOffButton.isSelected.toggle()
        
        self.badgeOnOffButton.title = (self.badgeOnOffButton.isSelected == true ? "뱃지 On" : "뱃지 off")
        
        self.tabBarSegment01ViewController?.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarSlider01ViewController?.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarSlider02ViewController?.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        
        self.tabBarSegment01.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarSlider01.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarSlider02.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        
        
    }
    
    @objc func moveTabBatItemButtonPressed() {
        self.moveTabBatItemButton.isSelected.toggle()
        
        self.moveTabBatItemButton.title = (self.moveTabBatItemButton.isSelected == true ? "Tab으로 이동" : "0번 Tab으로 이동")
        
        self.tabBarSegment01ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 1 : 0), animation: true)//setSelectedIndex(index: 1)
        self.tabBarSlider01ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 6 : 0), animation: false)
        self.tabBarSlider02ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0), animation: true)
        
        self.tabBarSegment01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 2 : 0))
        self.tabBarSlider01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0))
        self.tabBarSlider02.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 3 : 0))
        self.tabBarChip01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 5 : 0))
    }
    
    @objc func hiddenTabBatItemButtonPressed() {
        self.hiddenTabBatItemButton.isSelected.toggle()
        
        self.hiddenTabBatItemButton.title = (self.hiddenTabBatItemButton.isSelected == true ? "Tab 노출" : "Tab 숨김")
        
        self.segmentTabBarItemArray[1].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.sliderTabBarItemArray[4].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        
        self.segmentTabBarItems[1].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarSlider01Items[4].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarSlider02Items[0].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        
        self.tabBarSegment01.setTabBarItems(tabBarItemArray: self.segmentTabBarItemArray, isStandAloneView: true)
        self.tabBarSlider01.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray, isStandAloneView: true)
        self.tabBarSlider02.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray, isStandAloneView: true)
        self.tabBarChip01.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray, isStandAloneView: true)

        self.tabBarSegment01ViewController?.hiddenViewPage(tabBarItemArray: self.segmentTabBarItems)
        self.tabBarSlider01ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarSlider01Items)
        self.tabBarSlider02ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarSlider02Items)
    }
    
    @objc func changeTitleTabBatItemButtonPressed() {
        self.changeTitleTabBatItemButton.isSelected.toggle()
        
//        self.tabBarView01.changeTabBarButtonTitle(index: 0, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
//        self.tabBarView02.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
//        self.tabBarView03.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
//        self.tabBarView04.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
//        self.tabBarView05.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
    }
}

/*
 private var tabBarSegment01ViewController: DealiTabBarViewController?
 private var tabBarSlider01ViewController: DealiTabBarViewController?
 private var tabBarSlider02ViewController: DealiTabBarViewController?
 
 private let tabBarSegment01 = DealiTabBar_v2.tabBarSegment01()
 private let tabBarSlider01 = DealiTabBar_v2.tabBarSlider01()
 private let tabBarSlider02 = DealiTabBar_v2.tabBarSlider02()
 private let tabBarChip01 = DealiTabBar_v2.tabBarChip01()
 */

extension TabBarViewController: DealiTabBarViewDelegate {
    func didSelectTabBar(_ tabbarView: DealiTabBarView, selectedIndex index: Int, showScrollAnimation animation: Bool) {
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

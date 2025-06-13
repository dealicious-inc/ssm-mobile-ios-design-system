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
    
    var isSwiftUI: Bool = false
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var segmentTabBarItemArray = [DealiTabBarItem.make(title: "전체"),
                                  DealiTabBarItem.make(title: "여성의류")]
    
    private var sliderTabBarItemArray = [DealiTabBarItem.make(title: "1번 Tab"),
                                  DealiTabBarItem.make(title: "2번 Tab"),
                                  DealiTabBarItem.make(title: "3번 Tab"),
                                         DealiTabBarItem.make(title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0))),
                                 DealiTabBarItem.make(title: "5번 Tab"),
                                 DealiTabBarItem.make(title: "6번 Tab"),
                                 DealiTabBarItem.make(title: "7번 Tab"),
                                 DealiTabBarItem.make(title: "8번 Tab"),
                                 DealiTabBarItem.make(title: "9번 Tab")]
    
    private var sliderTabBarItemImageChipArray = [DealiTabBarItem.make(title: "끈원피스",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34731660/157845955684711900_2039113906.jpg&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "데님스커트",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34732842/157846177265350900_1178323558.jpg&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "크롭셔츠",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34736763/157846804199136400_1319981992.png&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "스웨이드자켓",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34736748/157846801645270200_1206718909.png&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "어깨패드",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34741496/157847665220578500_296545705.jpg&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "가디건",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34733634/157846308337719900_69033734.png&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "오버롤",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/35127962/157926910019452700_735798694.jpg&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100))),
                                                  DealiTabBarItem.make(title: "힙색",
                                                                       icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/images/34889263/157883634290091900_680130812.jpg&rs=raw&w=100&h=100"), size: CGSize(width: 24.0, height: 24.0)), imageChipSlotView: ImageChipCustomView(growth: Int.random(in: 0...100)))]
    
    private var segmentTabBarItems: [DealiTabBarItem] = []
    private var tabBarSlider01Items: [DealiTabBarItem] = []
    private var tabBarSlider02Items: [DealiTabBarItem] = []
    private var tabBarChip01Items: [DealiTabBarItem] = []
    private var tabBarChip02Items: [DealiTabBarItem] = []
    private var tabBarImgChip01Items: [DealiTabBarItem] = []
    
    private var tabBarSegment01ViewController: DealiTabBarViewController?
    private var tabBarSlider01ViewController: DealiTabBarViewController?
    private var tabBarSlider02ViewController: DealiTabBarViewController?
    private var tabBarChip01ViewController: DealiTabBarViewController?
    private var tabBarChip02ViewController: DealiTabBarViewController?
    private var tabBarImgChip01ViewController: DealiTabBarViewController?
    
    private let tabBarSegment01 = DealiTabBar.tabBarSegment01()
    private let tabBarSlider01 = DealiTabBar.tabBarSlider01(isSelectedItemCentered: false)
    private let tabBarSlider02 = DealiTabBar.tabBarSlider02()
    private let tabBarChip01 = DealiTabBar.tabBarChip01(isSelectedItemCentered: true)
    private let tabBarChip02 = DealiTabBar.tabBarChip02()
    private let tabBarImgChip01 = DealiTabBar.tabBarImgChip01(showImageChipSlotWhenSelected: true)
    
    private let tabBarSegment01ContentView = UIView()
    private let tabBarSlider01ContentView = UIView()
    private let tabBarSlider02ContentView = UIView()
    private let tabBarChip01ContentView = UIView()
    private let tabBarChip02ContentView = UIView()
    private let tabBarImgChip01ContentView = UIView()
    
    private let badgeOnOffButton = DealiControl.btnOutlineLarge01()
    private let moveTabBatItemButton = DealiControl.btnOutlineLarge01()
    private let hiddenTabBatItemButton = DealiControl.btnOutlineLarge01()
    private let changeTitleTabBatItemButton = DealiControl.btnOutlineLarge01()
    
    let contentStackView = UIStackView()
    let buttonContainerStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar_V2"
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.isSwiftUI {
            self.tabBarChip02.setSelectedIndex(index: 0)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        let buttonContainerView = UIView()
        self.view.addSubview(buttonContainerView)
        buttonContainerView.then {
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20.0)
        }
        
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonContainerView.snp.top)
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
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
        
        
        if self.isSwiftUI {
            self.setTabBarSwiftUI()
        } else {
            self.setTabBar()
            self.setTabBarViewController()
        }
        
        self.setButtonContainer()
    }
    
    private func setButtonContainer() {
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
            $0.addTarget(self, action: #selector(moveTabBarItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        buttonContainerStackView.addArrangedSubview(self.hiddenTabBatItemButton)
        self.hiddenTabBatItemButton.then {
            $0.title = "특정 탭 숨김"
            $0.isSelected = false
            $0.addTarget(self, action: #selector(hiddenTabBarItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        buttonContainerStackView.addArrangedSubview(self.changeTitleTabBatItemButton)
        self.changeTitleTabBatItemButton.then {
            $0.title = "특정 탭 Title 변경"
            $0.isSelected = false
            $0.addTarget(self, action: #selector(changeTitleTabBarItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }

    private func setTabBar() {
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
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 6)
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
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 4)
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
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 5)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let tabBarChip02TitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarChip02TitleLabel)
        tabBarChip02TitleLabel.do {
            $0.text = "tabBarChip02"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarChip02)
        self.tabBarChip02.then {
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: -2)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let tabBarImgChip01TitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarImgChip01TitleLabel)
        tabBarImgChip01TitleLabel.do {
            $0.text = "tabBarImgChip01"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarImgChip01)
        self.tabBarImgChip01.then {
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemImageChipArray, startIndex: 0)
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
        
        let tabBarChip01ViewControllerTitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarChip01ViewControllerTitleLabel)
        tabBarChip01ViewControllerTitleLabel.do {
            $0.text = "tabBarChip01_ViewController"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarChip01ContentView)
        self.tabBarChip01ContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300.0)
        }
        
        let tabBarChip02ViewControllerTitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarChip02ViewControllerTitleLabel)
        tabBarChip02ViewControllerTitleLabel.do {
            $0.text = "tabBarChip02_ViewController"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarChip02ContentView)
        self.tabBarChip02ContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300.0)
        }
        
        let tabBarImgChip01ViewControllerTitleLabel = UILabel()
        contentStackView.addArrangedSubview(tabBarImgChip01ViewControllerTitleLabel)
        tabBarImgChip01ViewControllerTitleLabel.do {
            $0.text = "tabBarImgChip01_ViewController"
            $0.font = .b1sb15
        }
        
        contentStackView.addArrangedSubview(self.tabBarImgChip01ContentView)
        self.tabBarImgChip01ContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(300.0)
        }
    }
    
    func setTabBarViewController() {
        for i in 0..<2 {
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
        
        for i in 0..<10 {
            let chip01ViewController = DealiTabBarChildViewController()
            chip01ViewController.view.backgroundColor = self.randomColor()
            let tabBarItemChip01 = DealiTabBarItem.make(chip01ViewController, title: "\(i)번 Tab")
            self.tabBarChip01Items.append(tabBarItemChip01)
            
            let chip02ViewController = DealiTabBarChildViewController()
            chip02ViewController.view.backgroundColor = self.randomColor()
            let tabBarItemChip02 = DealiTabBarItem.make(chip02ViewController, title: "\(i)번 Tab")
            self.tabBarChip02Items.append(tabBarItemChip02)
            
            
        }
        
        for tabBarImageChipItem in self.sliderTabBarItemImageChipArray {
            
            let imgChip01ViewController = DealiTabBarChildViewController()
            imgChip01ViewController.view.backgroundColor = self.randomColor()
            
            var tabBarItemImgChip01 = tabBarImageChipItem
            tabBarItemImgChip01.imageChipSlotView = ImageChipCustomView(growth: Int.random(in: 0...100))
            tabBarItemImgChip01.viewController = imgChip01ViewController
            
            self.tabBarImgChip01Items.append(tabBarItemImgChip01)
        }

        
        let tabBarSegment01View = DealiTabBar.tabBarSegment01()
        self.tabBarSegment01ViewController = DealiTabBarViewController(tabBarView: tabBarSegment01View, tabBarItemArray: self.segmentTabBarItems)
        self.tabBarSegment01ViewController?.startPageIndex = 1
        if let tabBarSegment01ViewController = self.tabBarSegment01ViewController {
            self.insertChildController(tabBarSegment01ViewController, intoParentView: self.tabBarSegment01ContentView)
        }
        
        let tabBarSlider01View = DealiTabBar.tabBarSlider01()
        self.tabBarSlider01ViewController = DealiTabBarViewController(tabBarView: tabBarSlider01View, tabBarItemArray: self.tabBarSlider01Items, isSelectedItemCentered: false)
        self.tabBarSlider01ViewController?.startPageIndex = 1
        if let tabBarSlider01ViewController = self.tabBarSlider01ViewController {
            self.insertChildController(tabBarSlider01ViewController, intoParentView: self.tabBarSlider01ContentView)
        }
        
        let tabBarSlider02View = DealiTabBar.tabBarSlider02()
        self.tabBarSlider02ViewController = DealiTabBarViewController(tabBarView: tabBarSlider02View, tabBarItemArray: self.tabBarSlider02Items, isSelectedItemCentered: true)
        self.tabBarSlider02ViewController?.startPageIndex = 5
        if let tabBarSlider02ViewController = self.tabBarSlider02ViewController {
            self.insertChildController(tabBarSlider02ViewController, intoParentView: self.tabBarSlider02ContentView)
        }
        
        let tabBarChip01View = DealiTabBar.tabBarChip01()
        self.tabBarChip01ViewController = DealiTabBarViewController(tabBarView: tabBarChip01View, tabBarItemArray: self.tabBarChip01Items, isSelectedItemCentered: false)
        self.tabBarChip01ViewController?.startPageIndex = 5
        if let tabBarChip01ViewController = self.tabBarChip01ViewController {
            self.insertChildController(tabBarChip01ViewController, intoParentView: self.tabBarChip01ContentView)
        }
        
        let tabBarChip02View = DealiTabBar.tabBarChip02()
        self.tabBarChip02ViewController = DealiTabBarViewController(tabBarView: tabBarChip02View, tabBarItemArray: self.tabBarChip02Items)
        self.tabBarChip02ViewController?.startPageIndex = 5
        if let tabBarChip02ViewController = self.tabBarChip02ViewController {
            self.insertChildController(tabBarChip02ViewController, intoParentView: self.tabBarChip02ContentView)
        }
        
        let tabBarImgChip01View = DealiTabBar.tabBarImgChip01()
        self.tabBarImgChip01ViewController = DealiTabBarViewController(tabBarView: tabBarImgChip01View, tabBarItemArray: self.tabBarImgChip01Items, isSelectedItemCentered: false)
        self.tabBarImgChip01ViewController?.startPageIndex = 5
        if let tabBarImgChip01ViewController = self.tabBarImgChip01ViewController {
            self.insertChildController(tabBarImgChip01ViewController, intoParentView: self.tabBarImgChip01ContentView)
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
    
    @objc func moveTabBarItemButtonPressed() {
        self.moveTabBatItemButton.isSelected.toggle()
        
        self.moveTabBatItemButton.title = (self.moveTabBatItemButton.isSelected == true ? "Tab으로 이동" : "0번 Tab으로 이동")
        
        self.tabBarSegment01ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 1 : 0), animation: true)//setSelectedIndex(index: 1)
        self.tabBarSlider01ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 6 : 0), animation: false)
        self.tabBarSlider02ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0), animation: true)
        self.tabBarChip01ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0), animation: true)
        self.tabBarChip02ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0), animation: true)
        self.tabBarImgChip01ViewController?.moveViewerPageIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0), animation: true)
        
        self.tabBarSegment01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 2 : 0))
        self.tabBarSlider01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 4 : 0))
        self.tabBarSlider02.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 3 : 0))
        self.tabBarChip01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 5 : 0))
        self.tabBarChip02.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 5 : 0))
        self.tabBarImgChip01.setSelectedIndex(index: (self.moveTabBatItemButton.isSelected == true ? 5 : 0))
    }
    
    @objc func hiddenTabBarItemButtonPressed() {
        self.hiddenTabBatItemButton.isSelected.toggle()
        
        self.hiddenTabBatItemButton.title = (self.hiddenTabBatItemButton.isSelected == true ? "Tab 노출" : "Tab 숨김")
        
        self.segmentTabBarItemArray[1].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.sliderTabBarItemArray[4].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        
        self.segmentTabBarItems[1].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarSlider01Items[4].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarSlider02Items[0].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarChip01Items[0].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarChip02Items[0].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.tabBarImgChip01Items[0].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        
        self.tabBarSegment01.setTabBarItems(tabBarItemArray: self.segmentTabBarItemArray)
        self.tabBarSlider01.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray)
        self.tabBarSlider02.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray)
        self.tabBarChip01.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray)
        self.tabBarChip02.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray)
        self.tabBarImgChip01.setTabBarItems(tabBarItemArray: self.sliderTabBarItemArray)

        self.tabBarSegment01ViewController?.hiddenViewPage(tabBarItemArray: self.segmentTabBarItems)
        self.tabBarSlider01ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarSlider01Items)
        self.tabBarSlider02ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarSlider02Items)
        self.tabBarChip01ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarChip01Items)
        self.tabBarChip02ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarChip02Items)
        self.tabBarImgChip01ViewController?.hiddenViewPage(tabBarItemArray: self.tabBarImgChip01Items)
    }
    
    @objc func changeTitleTabBarItemButtonPressed() {
        self.changeTitleTabBatItemButton.isSelected.toggle()
        
        self.changeTitleTabBatItemButton.title = (self.changeTitleTabBatItemButton.isSelected == true ? "특정 탭 Title 변경" : "특정 탭 Title 원복")
        
        self.tabBarSegment01ViewController?.changeTabBarButtonTitle(index: 2, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarSlider01ViewController?.changeTabBarButtonTitle(index: 2, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarSlider02ViewController?.changeTabBarButtonTitle(index: 2, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarChip01ViewController?.changeTabBarButtonTitle(index: 2, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarChip02ViewController?.changeTabBarButtonTitle(index: 2, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarImgChip01ViewController?.changeTabBarButtonTitle(index: 2, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        
        self.tabBarSegment01.changeTabBarButtonTitle(index: 1, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarSlider01.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarSlider02.changeTabBarButtonTitle(index: 4, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarChip01.changeTabBarButtonTitle(index: 5, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarChip02.changeTabBarButtonTitle(index: 5, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarImgChip01.changeTabBarButtonTitle(index: 5, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
    }
}

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

final class ImageChipCustomView: DealiCustomView {
    
    override func calculateInstrinsicSize() -> CGSize {
        var size = self.growthLabel.intrinsicContentSize
        let width = size.width + 2 + 16
        size.width = width
        return size
    }
    
    private let growthArrowImageView = UIImageView()
    private let growthLabel = UILabel()
    
    init(growth: Int) {
        super.init(frame: .zero)
        
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_arrow_close_1_filled")?.withTintColor(UIColor.primary01)
        }.snp.makeConstraints {
            $0.size.equalTo(16.0)
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(self.growthLabel)
        self.growthLabel.then {
            $0.font = .b2sb14
            $0.textColor = UIColor.primary01
            $0.attributedText = NSMutableAttributedString(string: "\(growth)").font($0.font).color(UIColor.primary01).alignment(.left).setLineHeight()
        }.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(2)
            $0.top.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SwiftUI
extension TabBarViewController {
    func setTabBarSwiftUI() {
        let icon = DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 16.0, height: 16.0))
        let tabBarItems = [TabBarItemViewModel(title: "1번 Tab", showBadge: true),
                           TabBarItemViewModel(title: "2번 Tab"),
                           TabBarItemViewModel(title: "3번 Tab", icon: icon)]
        
        let tabBarLongItems = [TabBarItemViewModel(title: "1번 Tab", showBadge: true),
                               TabBarItemViewModel(title: "2번 Tab", showBadge: true),
                               TabBarItemViewModel(title: "3번 Tab", icon: icon),
                               TabBarItemViewModel(title: "4번 Tab"),
                               TabBarItemViewModel(title: "5번 Tab"),
                               TabBarItemViewModel(title: "6번 Tab"),
                               TabBarItemViewModel(title: "7번 Tab"),
                               TabBarItemViewModel(title: "8번 Tab"),
                               TabBarItemViewModel(title: "9번 Tab")]
        
        segment01(tabBarItems)
        slider01(tabBarLongItems)
        slider02(tabBarLongItems)
    }
    
    func setTitleLabel(_ title: String) {
        let label = UILabel()
        contentStackView.addArrangedSubview(label)
        label.do {
            $0.text = title
            $0.font = .b1sb15
        }
    }
    
    func segment01(_ items: [TabBarItemViewModel]) {
        setTitleLabel("tabBarSegment01")
        let tabbar = TabBarView(type: .tabBarSegment01,
                                items: items).UIKit()
        contentStackView.addArrangedSubview(tabbar)
        tabbar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    func slider01(_ items: [TabBarItemViewModel]) {
        setTitleLabel("tabBarSlider01")
        let tabbar = TabBarView(type: .tabBarSlider01,
                                items: items).UIKit()
        contentStackView.addArrangedSubview(tabbar)
        tabbar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    func slider02(_ items: [TabBarItemViewModel]) {
        setTitleLabel("tabBarSlider02")
        let tabbar = TabBarView(type: .tabBarSlider02,
                                items: items,
                                selectedIndex: 8).UIKit()
        contentStackView.addArrangedSubview(tabbar)
        tabbar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
}

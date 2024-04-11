//
//  TabBarComponentrViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 4/9/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

final class TabBarComponentrViewController: UIViewController {

    private var segmentTabBarItemArray = [DealiTabBarItem.make(title: "1번 Tab"),
                                  DealiTabBarItem.make(title: "2번 Tab"),
                                  DealiTabBarItem.make(title: "3번 Tab")]
    
    private var sliderTabBarItemArray = [DealiTabBarItem.make(title: "1번 Tab"),
                                  DealiTabBarItem.make(title: "2번 Tab"),
                                  DealiTabBarItem.make(title: "3번 Tab"),
                                 DealiTabBarItem.make(title: "4번 Tab"),
                                 DealiTabBarItem.make(title: "5번 Tab"),
                                 DealiTabBarItem.make(title: "6번 Tab"),
                                 DealiTabBarItem.make(title: "7번 Tab"),
                                 DealiTabBarItem.make(title: "8번 Tab"),
                                 DealiTabBarItem.make(title: "9번 Tab")]
    
    private let tabBarView01 = DealiTabBar.tabBar01()
    private let tabBarView02 = DealiTabBar.tabBar02()
    private let tabBarView03 = DealiTabBar.tabBar03()
    private let tabBarView04 = DealiTabBar.tabBar04()
    private let tabBarView05 = DealiTabBar.tabBar05()
    
    private let badgeOnOffButton = DealiControl.btnOutlineLarge01()
    private let hiddenTabBatItemButton = DealiControl.btnOutlineLarge01()
    private let changeTitleTabBatItemButton = DealiControl.btnOutlineLarge01()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar"
        self.view.backgroundColor = .lightGray
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
            $0.backgroundColor = .lightGray
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
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        
        contentStackView.addArrangedSubview(self.tabBarView01)
        self.tabBarView01.then {
            $0.setTabbarItems(tabbarItemArray: segmentTabBarItemArray)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.tabBarView02)
        self.tabBarView02.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabBarItemArray)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.tabBarView03)
        self.tabBarView03.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabBarItemArray)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.tabBarView04)
        self.tabBarView04.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabBarItemArray)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.tabBarView05)
        self.tabBarView05.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabBarItemArray)
            $0.delegate = self
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.badgeOnOffButton)
        self.badgeOnOffButton.then {
            $0.title = "뱃지 On/Off"
            $0.addTarget(self, action: #selector(badgeOnOffButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        let moveTabBatItemButton = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(moveTabBatItemButton)
        moveTabBatItemButton.then {
            $0.title = "특정 탭으로 이동"
            $0.addTarget(self, action: #selector(moveTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.hiddenTabBatItemButton)
        self.hiddenTabBatItemButton.then {
            $0.title = "특정 탭 노출 ON/Off"
            $0.addTarget(self, action: #selector(hiddenTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.hiddenTabBatItemButton)
        self.hiddenTabBatItemButton.then {
            $0.title = "특정 탭 노출 ON/Off"
            $0.addTarget(self, action: #selector(hiddenTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.changeTitleTabBatItemButton)
        self.changeTitleTabBatItemButton.then {
            $0.title = "특정 탭 Title 변경"
            $0.addTarget(self, action: #selector(changeTitleTabBatItemButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }

}

extension TabBarComponentrViewController {
    @objc func badgeOnOffButtonPressed() {
        self.badgeOnOffButton.isSelected.toggle()
        
        self.tabBarView01.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarView02.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarView03.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarView04.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        self.tabBarView05.showTabBarItemBadge(index: 2, shouldShowBadge: (self.badgeOnOffButton.isSelected == true ? true : false))
        
        
    }
    
    @objc func moveTabBatItemButtonPressed() {
        self.tabBarView01.setSelectedIndex(index: 2)
        self.tabBarView02.setSelectedIndex(index: 3)
        self.tabBarView03.setSelectedIndex(index: 3)
        self.tabBarView04.setSelectedIndex(index: 3)
        self.tabBarView05.setSelectedIndex(index: 3)
    }
    
    @objc func hiddenTabBatItemButtonPressed() {
        self.hiddenTabBatItemButton.isSelected.toggle()
        
        self.segmentTabBarItemArray[1].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        self.sliderTabBarItemArray[4].isHidden = (self.hiddenTabBatItemButton.isSelected == true ? true : false)
        
        self.tabBarView01.setTabbarItems(tabbarItemArray: self.segmentTabBarItemArray)
        self.tabBarView02.setTabbarItems(tabbarItemArray: self.sliderTabBarItemArray)
        self.tabBarView03.setTabbarItems(tabbarItemArray: self.sliderTabBarItemArray)
        self.tabBarView04.setTabbarItems(tabbarItemArray: self.sliderTabBarItemArray)
        self.tabBarView05.setTabbarItems(tabbarItemArray: self.sliderTabBarItemArray)
    }
    
    @objc func changeTitleTabBatItemButtonPressed() {
        self.changeTitleTabBatItemButton.isSelected.toggle()
        
        self.tabBarView01.changeTabBarButtonTitle(index: 0, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarView02.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarView03.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarView04.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
        self.tabBarView05.changeTabBarButtonTitle(index: 3, title: (self.changeTitleTabBatItemButton.isSelected == true ? "Title 변경" : "원복"))
    }
}

extension TabBarComponentrViewController: DealiTabBarViewDelegate {
    func didSelectTabBar(_ tabbarView: DealiTabBarView, selectedIndex index: Int, showScrollAnimation animation: Bool) {
        print("didSelectTabBar index = \(index)")
    }
}

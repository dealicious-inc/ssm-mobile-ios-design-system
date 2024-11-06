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
    
    private let contentView = UIView()
    private var tabBarViewController: DealiTabBarViewController?
    
    private let tabBarView02 = DealiTabBar_v2.tabBarSlider01()
    private let tabBarView03 = DealiTabBar_v2.tabBarSlider01()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar_V2"
        self.view.backgroundColor = .white
        self.setTabBar()
        
//        self.tabBarView02.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 1, isStandAloneView: true)
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.tabBarView02)
        self.tabBarView02.then {
            $0.backgroundColor = .white
//            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 6, isStandAloneView: true)
        }.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        self.view.addSubview(self.tabBarView03)
        self.tabBarView03.then {
            $0.backgroundColor = .white
            $0.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 4, isStandAloneView: true)
        }.snp.makeConstraints {
            $0.top.equalTo(self.tabBarView02.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints {
            $0.top.equalTo(self.tabBarView03.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        
        self.tabBarView02.setTabBarItems(tabBarItemArray: sliderTabBarItemArray, startIndex: 5, isStandAloneView: true)
    }

    private func setTabBar() {
        var tabBarItems: [DealiTabBarItem] = []
        for i in 0..<10 {
            let viewController = DealiTabBarChildViewController()
            viewController.view.backgroundColor = self.randomColor()
            if i == 3 {
                
                let tabBarItem = DealiTabBarItem.make(viewController, title: "DETAILS", isHidden: false, showsBadge: false, icon: DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 48.0, height: 48.0)))
                tabBarItems.append(tabBarItem)
            } else {
                let tabBarItem = DealiTabBarItem.make(viewController, title: "\(i)번 Tab")
                tabBarItems.append(tabBarItem)
            }
        }

        let tabBarView = DealiTabBar_v2.tabBarSlider01()
        self.tabBarViewController = DealiTabBarViewController(tabBarView: tabBarView, tabBarItemArray: tabBarItems)
        self.tabBarViewController?.startPageIndex = 7
        if let tabBarViewController {
            self.insertChildController(tabBarViewController, intoParentView: self.contentView)
        }
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
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

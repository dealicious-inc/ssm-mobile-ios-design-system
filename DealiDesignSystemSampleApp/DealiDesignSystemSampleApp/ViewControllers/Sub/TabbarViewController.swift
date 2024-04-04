//
//  TabbarViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/03/28.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

final class TabbarViewController: UIViewController {

    private let topTabbarView = DealiTabber.testTabberSlider()
    private let segmentViewController = DealiScrollSegmentTabBarViewController(tabbarView: DealiTabber.testTabberSlider())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Tabbar"
        self.view.backgroundColor = .white
//        self.topTabbarView.setSelectedIndex(index: 4)
//        self.segmentViewController.setViewerPageIndex(index: 5)
    }

    override func loadView() {
        super.loadView()
        
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
        
        self.view.addSubview(self.topTabbarView)
        self.topTabbarView.then {
            $0.setTabbarItems(tabbarItemArray: sliderTabbarItems)
            $0.delegate = self
            $0.setSelectedIndex(index: 4)
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
        self.segmentViewController.startPageIndex = 5
        self.segmentViewController.willMove(toParent: self)
        
        self.addChild(self.segmentViewController)
        self.segmentViewController.view.frame = contentView.bounds
        contentView.addSubview(segmentViewController.view)
        
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

extension TabbarViewController {
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

extension TabbarViewController: DealiTabBarViewDelegate {
    func didSelectTabBar(_ tabbarView: DealiTabBarView, selectedIndex index: Int, showScrollAnimation animation: Bool) {
        print("didSelectTabBar index = \(index)")
    }
}



public var statusBarHeight: CGFloat {
    let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    let statusBarManager = window?.windowScene?.statusBarManager
    let topPadding = window?.safeAreaInsets.top
    return topPadding ?? (statusBarManager?.statusBarFrame.height ?? 0.0)
}
public let navigationBarHeight = UINavigationController().navigationBar.intrinsicContentSize.height

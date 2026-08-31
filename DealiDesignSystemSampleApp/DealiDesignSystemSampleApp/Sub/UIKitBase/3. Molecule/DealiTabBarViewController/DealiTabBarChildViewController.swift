//
//  DealiTabBarChildViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 11/5/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import DealiDesignKit

class DealiTabBarChildViewController: UIViewController {

    var isAttachedAsChild: Bool = true

    var isVisible: Bool = false { // 현재 페이지가 보여지고 있다면 true
        didSet {
            if isVisible == true {
                
            }
        }
    }
    
    var isInitView: Bool = false // 최초 뷰 로딩이 되었는지 여부
    /// isVisible가 true이고 isInitView가 true일때 데이터 로드를 위한 rx
//    var visibleView: PublishRelay<EDealiDataLoadType> = PublishRelay()
    
    var screenName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class DealiTabInTabBarChildViewController: DealiTabBarChildViewController {
    var tabBarViewModel: TabBarViewModel?
    var tabBarView: TabBarView?
    
    var contentScrollView = UIScrollView()
    private var contentStackView = UIStackView()
    
    private var isScrollEnabled: Bool = true
    private var childVC: [UIViewController] = []
    var selectedIndex: Int = -1
    
    let items = [TabBarItemViewModel(title: "1번 Tab", showBadge: true),
                           TabBarItemViewModel(title: "2번 Tab", showBadge: true),
                           TabBarItemViewModel(title: "3번 Tab"),
                           TabBarItemViewModel(title: "4번 Tab"),
                           TabBarItemViewModel(title: "5번 Tab"),
                           TabBarItemViewModel(title: "6번 Tab"),
                           TabBarItemViewModel(title: "7번 Tab"),
                           TabBarItemViewModel(title: "8번 Tab"),
                           TabBarItemViewModel(title: "9번 Tab")]
    
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutSubviews()
        self.contentScrollView.layoutSubviews()
    }
    
    override func loadView() {
        super.loadView()
        
        let tabbar = TabBarView(type: .tabBarChipNotification,
                                items: self.items)//.UIKit()
        
        let viewModel = TabBarViewModel(type: .tabBarChip01, items: self.items)
        let childVCArr: [DealiTabBarChildViewController] = self.items.map { item in
            let vc = DealiTabBarChildViewController()
            vc.view.backgroundColor = UIColor(
                red: CGFloat.random(in: 0.5...1),
                green: CGFloat.random(in: 0.5...1),
                blue: CGFloat.random(in: 0.5...1),
                alpha: 1.0
            )
            
            let buttonViewModel = ButtonViewModel(type: .btnFilledLarge01, title: "button")
            let button = ButtonView(viewModel: buttonViewModel) {
                DealiAlert.show(message: item.title,
                                cancelButtonTitle: nil,
                                confirmButtonTitle: "확인",
                                alertPresentingViewController: self,
                                cancelAction: nil, confirmAction: nil)
            }.UIKit()
            
            vc.view.addSubview(button)
            button.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
            return vc
            
        }
        self.tabBarViewModel = viewModel
        
        self.isScrollEnabled = true
        self.childVC = childVCArr
        self.selectedIndex = 0
    
        
        self.tabBarView = tabbar
//        self.tabBarViewModel.action = {
//            self.didSelectTabBar(selectedIndex: self.tabBarView?.selectedIndex ?? 0, showScrollAnimation: true)
//        }
//        self.tabBarView = TabBarView(viewModel: self.tabBarViewModel)
        
        let tabBarUIKit = self.tabBarView.UIKit()
        self.view.addSubview(tabBarUIKit)
        tabBarUIKit.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
        }
        
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.then { [unowned self] in
            $0.bounces = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.delegate = self
            $0.isScrollEnabled = self.isScrollEnabled
        }.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(tabBarUIKit.snp.bottom).offset(0)
            
        }
        
        self.contentScrollView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fill
        }.snp.makeConstraints { [unowned self] in
            $0.left.right.top.bottom.equalToSuperview()
            $0.height.equalTo(contentScrollView)
        }
        
        self.set()
    }
    
    func set() {
        self.clear()
        
        for (index, vc) in self.childVC.enumerated() {
            self.addChild(vc)
            guard let view = vc.view else {
                continue
            }
            self.contentStackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.size.equalTo(contentScrollView)
            }
        }
        
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            self.didSelectTabBar(selectedIndex: self.selectedIndex, showScrollAnimation: false)
//        }
    }
    
    private func clear() {
        self.contentStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        if self.children.count > 0 {
            self.children.forEach({
                $0.willMove(toParent: nil)
                $0.view.removeFromSuperview()
                $0.removeFromParent()
            })
        }
    }
}

extension DealiTabInTabBarChildViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.selectedIndex != scrollView.currentPage {
            self.selectedIndex = scrollView.currentPage
            self.tabBarView?.selectedIndex = self.selectedIndex
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
}

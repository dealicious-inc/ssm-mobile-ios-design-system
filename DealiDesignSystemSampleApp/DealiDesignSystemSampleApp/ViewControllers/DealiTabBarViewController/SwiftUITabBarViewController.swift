//
//  SwiftUITabBarViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 6/16/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import DealiDesignKit

final class SwiftUITabBarViewController: UIViewController {
    
    var tabBarViewModel: TabBarViewModel
    
    var tabBarView: TabBarView?
    var contentScrollView = UIScrollView()
    private var contentStackView = UIStackView()
    
    private var isScrollEnabled: Bool = true
    private var childVC: [UIViewController] = []
    var selectedIndex: Int = -1
    
    init(viewModel: TabBarViewModel,
         childVC: [UIViewController],
         isScrollEnabled: Bool = true) {
        self.tabBarViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.isScrollEnabled = isScrollEnabled
        self.childVC = childVC
        self.selectedIndex = viewModel.selectedIndex
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
        
        self.tabBarViewModel.action = {
            self.didSelectTabBar(selectedIndex: self.tabBarView?.selectedIndex ?? 0, showScrollAnimation: true)
        }
        self.tabBarView = TabBarView(viewModel: self.tabBarViewModel)
        
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
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.didSelectTabBar(selectedIndex: self.selectedIndex, showScrollAnimation: false)
        }
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

extension SwiftUITabBarViewController {
    func didSelectTabBar(selectedIndex index: Int, showScrollAnimation animation: Bool) {
//        self.isTabBarTriggered = true
        UIView.animate(withDuration: (animation == true ? 0.20 : 0.0)) { [weak self] in
                guard let self else { return }
            self.contentScrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.size.width * CGFloat(index), y: 0), animated: false)
        } completion: { finished in
//            self.isTabBarTriggered = false
        }

    }
}

extension SwiftUITabBarViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.selectedIndex != scrollView.currentPage {
            self.selectedIndex = scrollView.currentPage
            self.tabBarView?.selectedIndex = self.selectedIndex
        }
        
//        if self.isTabBarTriggered == false {
//            
//            let page = scrollView.currentPage
//            var fractional = scrollView.contentOffset.x / scrollView.frame.size.width
//            if fractional.isInfinite {
//                fractional = CGFloat(page)
//            }
//            
//            self.tabBarView.viewScroll(page: scrollView.currentPage, fractional: fractional)
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
}

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

    /// 마지막으로 페이지 오프셋을 맞춘 스크롤뷰 폭. 회전·접기·펼치기로 폭이 바뀌면 선택된 페이지로 다시 맞춘다.
    private var lastPagingWidth: CGFloat = 0.0
    /// 마지막 레이아웃 때의 뷰 폭. 폭이 바뀌는 레이아웃 패스를 미리 알아채는 데 쓴다.
    private var lastViewWidth: CGFloat = 0.0
    /// 창 크기가 바뀌는 동안 true. 페이징 스크롤뷰가 offset을 다시 맞추며 보내는 스크롤 이벤트를 무시한다.
    private var isRestoringPageAfterResize = false

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let width = self.view.bounds.width
        if self.lastViewWidth > 0.0, width > 0.0, width != self.lastViewWidth {
            self.isRestoringPageAfterResize = true
        }
        self.lastViewWidth = width
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        defer { self.isRestoringPageAfterResize = false }

        let width = self.contentScrollView.bounds.width
        guard width > 0.0, width != self.lastPagingWidth else { return }
        self.lastPagingWidth = width
        guard self.selectedIndex >= 0 else { return }

        self.contentScrollView.layoutIfNeeded()
        self.contentScrollView.setContentOffset(CGPoint(x: width * CGFloat(self.selectedIndex), y: 0), animated: false)
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
            $0.top.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.then { [unowned self] in
            $0.bounces = false
            // 화면 옆면 상태바(iPhone Duo)로 생기는 safe area를 스크롤뷰가 inset으로 더하면
            // 마지막 페이지가 그만큼 더 밀려 빈 영역이 보인다. 페이지 폭은 스크롤뷰 폭 그대로 쓴다.
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.delegate = self
            $0.isScrollEnabled = self.isScrollEnabled
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
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
        UIView.animate(withDuration: (animation == true ? 0.20 : 0.0)) { [weak self] in
                guard let self else { return }
            self.contentScrollView.setContentOffset(CGPoint(x: self.contentScrollView.bounds.width * CGFloat(index), y: 0), animated: false)
        } completion: { finished in

        }

    }
}

extension SwiftUITabBarViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.isRestoringPageAfterResize == false else { return }
        if self.selectedIndex != scrollView.currentPage {
            self.selectedIndex = scrollView.currentPage
            self.tabBarView?.selectedIndex = self.selectedIndex
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
}

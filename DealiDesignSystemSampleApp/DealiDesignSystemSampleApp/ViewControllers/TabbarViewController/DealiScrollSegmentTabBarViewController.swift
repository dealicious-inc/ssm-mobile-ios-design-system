//
//  DealiScrollSegmentTabBarViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/04/01.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

@objc protocol DealiScrollSegmentTabBarViewControllerDelegate {
    @objc optional func willChangeSelectedIndex(_ tabBarViewController: DealiScrollSegmentTabBarViewController, willSelectedIndex newIndex: Int, oldIndex: Int)
    @objc optional func didChangeSelectedIndex(_ tabBarViewController: DealiScrollSegmentTabBarViewController, didSelectedIndex index: Int)
}

final class DealiScrollSegmentTabBarViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    weak var delegate: DealiScrollSegmentTabBarViewControllerDelegate?
    
    private let tabbarView: DealiTabBarView
    
    private var contentScrollView = UIScrollView()
    private var contentStackView = UIStackView()
    
    // @이창호 ChildViewController와 1:1 매칭이 되는 탭바 아이템 리스트
    var tabbarItemArray: [DealiTabBarItem] = []
    
    // 스크롤이벤트로 탭바를 변경할지 안할지 세팅
    private var isScrollEnabled: Bool = true
    var autoVisible = true
    
    var rxSomethingChangedInside = PublishSubject<Any>()
    
    // 화면에 표시될때 특정 페이지를 보여줘야 할때 세팅
    private var _startPageIndex = -1
    // @박경우 왜 아래와 같은 삽질을 했느냐~ 예를 들어 딥링크로 앱이 열리고 매장->내거래매장 으로 간다면.. 딥링크에서 탭을 이동시키고 startPageIndex = 2 로 했을것이다.. 하지만 TradeRootViewController 초기화 하면서 startPageIndex = 1로 바꾼다. 실제 딥링크로 앱이 실행되면 매장->추천매장 으로 열려 내가 가려던 곳으로 안간다.. 말이 길었지만.. 결론은 그걸 방지하기 위해..
    var startPageIndex: Int {
        get {
            if _startPageIndex == -1 {
                _startPageIndex = 0
            }
            return _startPageIndex
        }
        set(newVal) {
            if _startPageIndex == -1 {
                _startPageIndex = newVal
            }
        }
    }
    var selectedIndex: Int = -1 {
        willSet {
            self.delegate?.willChangeSelectedIndex?(self, willSelectedIndex: newValue, oldIndex: self.selectedIndex)
        }
        didSet {
            for tabbarItem in self.tabbarItemArray {
                if tabbarItem.viewController is DealiScrollSegmentTabBarChildViewController {
                    let old = (tabbarItem.viewController as! DealiScrollSegmentTabBarChildViewController).isVisible
                    let new = (self.selectedIndex == tabbarItem.page)
                    if old != new {
                        (tabbarItem.viewController as! DealiScrollSegmentTabBarChildViewController).isVisible = new
                    }
                }
            }
            if oldValue != self.selectedIndex && oldValue > -1 {
                self.delegate?.didChangeSelectedIndex?(self, didSelectedIndex: self.selectedIndex)
            }
        }
    }
    
    required init(tabbarView: DealiTabBarView, isScrollEnabled: Bool = true) {
        
        self.tabbarView = tabbarView
        
        super.init(nibName: nil, bundle: nil)
        
        self.isScrollEnabled = isScrollEnabled
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.autoVisible == true {
            for tabbarItem in self.tabbarItemArray {
                if tabbarItem.viewController is DealiScrollSegmentTabBarChildViewController {
                    let old = (tabbarItem.viewController as! DealiScrollSegmentTabBarChildViewController).isVisible
                    let new = (self.selectedIndex == tabbarItem.page)
                    if old != new {
                        (tabbarItem.viewController as! DealiScrollSegmentTabBarChildViewController).isVisible = new
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for tabbarItem in self.tabbarItemArray {
            if tabbarItem.viewController is DealiScrollSegmentTabBarChildViewController {
                (tabbarItem.viewController as! DealiScrollSegmentTabBarChildViewController).isVisible = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if self.selectedIndex == -1 {
            self.view.layoutSubviews()
            self.contentScrollView.layoutSubviews()
            self.moveViewerPageIndex(index: self.startPageIndex)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.tabbarView)
        self.tabbarView.then {
            $0.isStandAloneView = false
            $0.delegate = self
        }.snp.makeConstraints {
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
        }.snp.makeConstraints { [unowned self] in
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(tabbarView.snp.bottom).offset(0)
            
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
        
        self.set(items: self.tabbarItemArray)
    }
    
    func changeTabBarButtonTitle(index: Int, title: String) {
        self.tabbarView.changeTabBarButtonTitle(index: index, title: title)
    }
    
    private func clear() {
        self.contentStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        if self.children.count > 0 {
            self.children.forEach({
                $0.willMove(toParent: nil)
                $0.view.removeFromSuperview()
                $0.removeFromParent()
            })
        }
        
        self.tabbarItemArray.removeAll()
    }
    
    func set(items: [DealiTabBarItem]) {
        
        self.clear()
        
        self.tabbarItemArray = items
        
        self.tabbarView.setTabBarItems(tabBarItemArray: self.tabbarItemArray)

        for index in 0..<self.tabbarItemArray.count {
            self.addChild(self.tabbarItemArray[index].viewController!)
            guard let view = self.tabbarItemArray[index].viewController?.view else {
                continue
            }

            self.tabbarItemArray[index].page = index

            self.contentStackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.size.equalTo(contentScrollView)
            }
        }
        
    }
    
    // 화면이 떠 있는 상태에서 다른 이벤트로 화면을 변경해줘야 하는 경우에 사용
    func moveViewerPageIndex(index: Int, animation: Bool = false) {
        self.selectedIndex = index
        self.tabbarView.setSelectedIndex(index: self.selectedIndex, animated: animation)
        
    }
    
    func hiddenViewPage(tabbarItemArray: [DealiTabBarItem], maintainContentOffset: Bool = true) {
        self.tabbarView.setTabBarItems(tabBarItemArray: tabbarItemArray, maintainContentOffset: maintainContentOffset)
        
        for (index, item) in tabbarItemArray.enumerated() {
            self.contentStackView.arrangedSubviews[index].isHidden = item.isHidden
        }
    }
    
    func showTabBarItemBadge(index: Int, shouldShowBadge: Bool) {
        self.tabbarView.showTabBarItemBadge(index: index, shouldShowBadge: shouldShowBadge)
    }

}

extension DealiScrollSegmentTabBarViewController: DealiTabBarViewDelegate {
    func didSelectTabBar(_ tabBarView: DealiTabBarView, selectedIndex index: Int, showScrollAnimation animation: Bool) {
        UIView.animate(withDuration: (animation == true ? 0.20 : 0.0)) { [weak self] in
            guard let self else { return }
            self.contentScrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.size.width * CGFloat(index), y: 0), animated: false)
        }
    }
}

extension DealiScrollSegmentTabBarViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.selectedIndex != scrollView.currentPage {
            self.selectedIndex = scrollView.currentPage
        }
        
        let page = scrollView.currentPage
        var fractional = scrollView.contentOffset.x / scrollView.frame.size.width
        if fractional.isInfinite {
            fractional = CGFloat(page)
        }
        
        self.tabbarView.viewScroll(page: scrollView.currentPage, fractional: fractional)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
}


extension UIScrollView {
    var currentPage: Int {
        get {
            return lround(Double(self.contentOffset.x / UIScreen.main.bounds.width))
        }
    }
}

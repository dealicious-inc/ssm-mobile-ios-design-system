//
//  DealiTabBarView.swift
//  
//
//  Created by hoji on 2024/03/26.
//

import UIKit
import RxSwift
import RxCocoa

public class DealiTabBar {
    
    public static func tabBar01() -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBar01)
    }
    
    public static func tabBar02() -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBar02)
    }
    
    public static func tabBar03() -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBar03)
    }
    
    public static func tabBar04() -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBar04)
    }
    
    public static func tabBar05() -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBar05)
    }
}

@objc public protocol DealiTabBarViewDelegate {
    @objc func didSelectTabBar(_ tabbarView: DealiTabBarView, selectedIndex index: Int, showScrollAnimation animation: Bool)
}

final public class DealiTabBarView: UIView {
    
    public weak var delegate: DealiTabBarViewDelegate?

    private lazy var contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let selectedUnderLineImageView = UIImageView()
    
    private var tabbarItemInfoArray: [DealiTabBarItemInfo] = []
    
    /// 해당 TabbarView를 단독으로 사용되면 true / tabbarViewController 와 함께 사용되면 false
    public var isStandAloneView: Bool = true
    
    private var selectedIndex: Int = 0 {
        didSet {
            for i in 0..<self.tabbarItemInfoArray.count {
                self.tabbarItemInfoArray[i].itemSelected = (self.tabbarItemInfoArray[i].itemIndex == self.selectedIndex)
            }
        }
    }
    
    private var preset: DealiTabBarPreset
    
    init(preset: DealiTabBarPreset) {
        
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.then {
            $0.backgroundColor = DealiColor.primary04
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.height.equalTo(preset.tabBarViewHeight)
        }
        
        switch preset.style {
        case .segment:
            self.addSubview(self.contentStackView)
            self.contentStackView.then {
                $0.axis = .horizontal
                $0.spacing = 0.0
                $0.distribution = .fillEqually
                $0.alignment = .center
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.left.right.equalToSuperview().inset(preset.tabBarMargin)
            }
            
            self.addSubview(self.selectedUnderLineImageView)
            
        default:

            self.addSubview(self.contentScrollView)
            self.contentScrollView.then {
                $0.bounces = false
                $0.clipsToBounds = false
                $0.showsHorizontalScrollIndicator = false
                $0.showsVerticalScrollIndicator = false
            }.snp.makeConstraints {
                $0.bottom.equalToSuperview()
                $0.left.right.equalToSuperview().inset(preset.tabBarMargin)
                $0.height.equalTo(preset.tabBerContentHeight)
            }
            
            let contentView = UIView()
            self.contentScrollView.addSubview(contentView)
            contentView.snp.makeConstraints {
                $0.top.bottom.left.right.equalToSuperview()
                $0.height.equalToSuperview()
            }
            
            contentView.addSubview(self.contentStackView)
            self.contentStackView.then {
                $0.axis = .horizontal
                $0.spacing = preset.contentSpacing
                $0.distribution = .equalSpacing
                $0.alignment = .center
            }.snp.makeConstraints {
                $0.top.bottom.left.right.equalToSuperview()
            }
            
            self.contentScrollView.addSubview(self.selectedUnderLineImageView)
        }
        
        
        self.selectedUnderLineImageView.then {
            if case .sliderChip(_) = preset.style {
                $0.isHidden = true
            } else {
                $0.isHidden = false
            }
            $0.backgroundColor = preset.selectedTextColor
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(2.0)
            $0.left.equalToSuperview().offset(0.0)
            $0.width.equalTo(0.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Tabbar ItemButton click Event
    @objc func itemPressed(_ sender: UIControl) {
        self.setSelectedIndex(index: sender.tag, animated: true)
    }
    
    public func setSelectedIndex(index: Int, animated: Bool = false) {
        self.selectedIndex = index
        
        /// tabbar Item button 클릭으로 이벤트 발생시 선택된 Button의 index값을 didSelectTabBarIndex를 통해 전달
        self.delegate?.didSelectTabBar(self, selectedIndex: self.selectedIndex, showScrollAnimation: animated)
        
        /// chip을 사용하는 tabbar에서는 따로 underLine 표시되지않기 때문에 chip이 아닌 경우에만 값을 세팅하도록 처리
        if self.preset.style == .segment || self.preset.style == .sliderButton {
            self.selectedUnderLineImageView.snp.updateConstraints {
                $0.left.equalToSuperview().offset(self.tabbarItemInfoArray[self.selectedIndex].contentStartPositionX)
                $0.width.equalTo(self.tabbarItemInfoArray[self.selectedIndex].contentWidth)
            }
        }
        
        /// tabbar가 단독으로 생성되어 사용되는경우에만 tabbar Button 을 클릭했을 경우 해당 버튼이 화면에 모두 노출되도록 처리
        if self.preset.style != .segment && self.isStandAloneView {
            self.moveScrollContentOffset(positionX: self.tabbarItemInfoArray[index].contentStartPositionX, contentWidth: self.tabbarItemInfoArray[index].contentWidth)
        }
    }
    
    /// Tabbar를 다시 구성하거나할때 기존 tabbar의 정보를 초기화
    private func clear() {
        self.tabbarItemInfoArray.forEach { itemInfo in
            itemInfo.itemButton?.removeFromSuperview()
            itemInfo.itemChip?.removeFromSuperview()
        }
        self.contentStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.tabbarItemInfoArray.removeAll()
    }
    
    /// tabbar를 구성할 정보를 받아 Tabbar Item Button 생성 및 정보 저장
    public func setTabbarItems(tabbarItemArray: [DealiTabBarItem], maintainContentOffset: Bool = true) {
        
        /// 가려지는 tabbar item이 있다면 해당 아이템을 제외하고 tabbarView를 재구성
        let itemArray = tabbarItemArray.filter({ $0.isHidden == false })
        
        if self.selectedIndex >= itemArray.count {
            self.selectedIndex = (itemArray.count - 1)
        }
        
        let offset = self.contentScrollView.contentOffset
        
        self.clear()
        
        for (index, item) in itemArray.enumerated() {
            guard let title = item.title else { continue }
            var buttonContentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
            if let _ = item.iconUrl, case .sliderButton = self.preset.style  {
                buttonContentWidth += 20.0
            }
            
            switch self.preset.style {
            case .sliderChip(let chipStyle):
                switch chipStyle {
                case .chipFilledSmall01:
                    let itemChip = DealiControl.chipFilledSmall01()
                    self.contentStackView.addArrangedSubview(itemChip)
                    itemChip.then {
                        $0.title = title
                        $0.addTarget(self, action: #selector(itemPressed(_:)), for: .touchUpInside)
                        $0.tag = index
                        $0.isSelected = (index == self.selectedIndex)
                    }.snp.makeConstraints {
                        $0.centerY.equalToSuperview()
                    }
                    
                    var itemInfo = DealiTabBarItemInfo()
                    itemInfo.itemIndex = index
                    itemInfo.itemChip = itemChip
                    itemInfo.itemSelected = (index == self.selectedIndex)
                    
                    self.tabbarItemInfoArray.append(itemInfo)
                }
                
            default:
                
                let itemButton = DealiTabBarItemButton()
                self.contentStackView.addArrangedSubview(itemButton)
                itemButton.then {
                    $0.configure(uiModel: DealiTabBarItemButtonUIModel.make(preset: self.preset, tabbarItem: item))
                    $0.tag = index
                    $0.isSelected = (index == self.selectedIndex)
                    $0.addTarget(self, action: #selector(itemPressed(_:)), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    
                    if case .sliderButton = self.preset.style {
                        $0.width.equalTo(buttonContentWidth + (self.preset.contentButtonPadding * 2.0))
                    }
                }
            
                var itemInfo = DealiTabBarItemInfo()
                itemInfo.itemIndex = index
                itemInfo.itemButton = itemButton
                itemInfo.itemSelected = (index == self.selectedIndex)
                itemInfo.contentWidth = buttonContentWidth
                
                self.tabbarItemInfoArray.append(itemInfo)
            }
        }
        
        self.updateTabbarItemInfo()
        
        self.contentScrollView.setContentOffset((maintainContentOffset ? offset : .zero), animated: false)
        
    }
    
    /// 특정 index에 위치한 tabbaritem의 title 변경 처리
    public func changeTabBarButtonTitle(index: Int, title: String) {
        guard index < self.tabbarItemInfoArray.count else { return }
        
        if case .sliderChip(_) = self.preset.style {
            self.tabbarItemInfoArray[index].itemChip?.title = title
        } else {
            if var uiModel = self.tabbarItemInfoArray[index].itemButton?.uiModel {
                let contentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
                uiModel.title = title
                self.tabbarItemInfoArray[index].itemButton?.configure(uiModel: uiModel)
                
                if case .sliderButton = self.preset.style {
                    self.tabbarItemInfoArray[index].itemButton?.snp.updateConstraints {
                        $0.width.equalTo(contentWidth + (self.preset.contentButtonPadding * 2))
                    }
                }
            }
        }
        
        self.updateTabbarItemInfo()
    }
    
    /// tabbar가 생성되거나 tabbar에 구성된 item의 정보가 변경되었을경우 해당 item 의 최종 width, position X 값을 갱신
    private func updateTabbarItemInfo() {
        self.layoutIfNeeded()
        for index in 0..<self.tabbarItemInfoArray.count {
            if let itemButton = self.tabbarItemInfoArray[index].itemButton {
                if self.preset.style == .segment {
                    self.tabbarItemInfoArray[index].contentWidth = ((UIScreen.main.bounds.size.width - (self.preset.tabBarMargin * 2.0)) / CGFloat(self.tabbarItemInfoArray.count))
                    self.tabbarItemInfoArray[index].contentStartPositionX = self.preset.tabBarMargin + (self.tabbarItemInfoArray[index].contentWidth * CGFloat(index))
                } else {
                    self.tabbarItemInfoArray[index].contentStartPositionX = itemButton.frame.origin.x + self.preset.contentButtonPadding
                    self.tabbarItemInfoArray[index].contentWidth = itemButton.bounds.size.width - (self.preset.contentButtonPadding * 2)
                }
            } else if let itemChip = self.tabbarItemInfoArray[index].itemChip {
                self.tabbarItemInfoArray[index].contentStartPositionX = (itemChip.frame.origin.x)
                self.tabbarItemInfoArray[index].contentWidth = itemChip.frame.size.width
            }
        }
        
        if self.preset.style == .segment || self.preset.style == .sliderButton {
            self.selectedUnderLineImageView.snp.updateConstraints {
                $0.left.equalToSuperview().offset(self.tabbarItemInfoArray[self.selectedIndex].contentStartPositionX)
                $0.width.equalTo(self.tabbarItemInfoArray[self.selectedIndex].contentWidth)
            }
        }
    }
    
    public func showTabBarItemBadge(index: Int, shouldShowBadge: Bool) {
        if self.preset.style == .segment || self.preset.style == .sliderButton {
            if var tabBarItemButtonUIModel = self.tabbarItemInfoArray[index].itemButton?.uiModel {
                tabBarItemButtonUIModel.shouldExposeNewBadge = shouldShowBadge
                self.tabbarItemInfoArray[index].itemButton?.configure(uiModel: tabBarItemButtonUIModel)
            }
        }
    }
    
    /// ViewController ScrollView의 Scroll 이벤트가 발생했을 경우 Scroll offset 수치에 비례하게 UnderLine과 Tabbar Item Button이 움직이도록 처리하는 함수
    public func viewScroll(page: Int, fractional: CGFloat) {

        if fractional.isInfinite {
            return
        }

        let preIdx: Int = Int(floor(fractional))
        let nexIdx: Int = Int(ceil(fractional))
        let calc = fractional - CGFloat(preIdx)

        var positionX = 0.0
        var contentWidth = 0.0

        if preIdx < 0 {
            if let item = self.tabbarItemInfoArray.first {
                positionX = item.contentStartPositionX
                contentWidth = item.contentWidth
            }
        } else if nexIdx >= self.tabbarItemInfoArray.count {
            if let item = self.tabbarItemInfoArray.last {
                positionX = item.contentStartPositionX
                contentWidth = item.contentWidth
            }
        } else {
            let preItem = self.tabbarItemInfoArray[preIdx]
            let nexItem = self.tabbarItemInfoArray[nexIdx]
            positionX = preItem.contentStartPositionX + (nexItem.contentStartPositionX - preItem.contentStartPositionX) * calc
            contentWidth = (preItem.contentWidth) + ((nexItem.contentWidth) - (preItem.contentWidth)) * calc
        }
        
        self.selectedIndex = page
        
        if self.preset.style == .segment || self.preset.style == .sliderButton {
            self.selectedUnderLineImageView.snp.updateConstraints {
                $0.width.equalTo(contentWidth)
                $0.left.equalToSuperview().offset(positionX)
            }
        }

        if self.preset.style == .segment {
            return
        }
        
        self.moveScrollContentOffset(positionX: positionX, contentWidth: contentWidth)
    }
    
    /// tabbar Item button을 클릭하거나 ViewController에서 스크롤이 발생했을경우 해당 선택된 tabbar Item Button이 화면에 노출되도록 offset 변경
    private func moveScrollContentOffset(positionX: CGFloat, contentWidth: CGFloat) {
        var offset: CGFloat = -1

        if case .sliderChip(_) = self.preset.style {
            if positionX < self.contentScrollView.contentOffset.x {
                offset = positionX
            } else if (positionX + contentWidth) > self.contentScrollView.contentOffset.x + self.contentScrollView.frame.width {
                offset = (positionX + contentWidth) - self.contentScrollView.frame.width
            }
        } else {
            if (positionX - self.preset.contentButtonPadding) < self.contentScrollView.contentOffset.x {
                offset = (positionX - self.preset.contentButtonPadding)
            } else if (positionX + contentWidth + self.preset.contentButtonPadding) > self.contentScrollView.contentOffset.x + self.contentScrollView.frame.width {
                offset = (positionX + contentWidth + self.preset.contentButtonPadding) - self.contentScrollView.frame.width
            }
        }

        if offset >= 0 {
            self.contentScrollView.setContentOffset(CGPoint(x: offset, y: self.contentScrollView.contentOffset.y), animated: false)
        }
    }
}

public struct DealiTabBarItem {
    public var viewController: UIViewController?
    public var page: Int = 0
    var title: String?
    /// 해당 메뉴 노출유무
    public var isHidden: Bool = false
    /// 배지 보여줄지 여부
    public var showsBadge: Bool = false
     var iconUrl: String?
    
    public static func make(_ viewController: UIViewController? = nil, title: String, isHidden: Bool = false, showsBadge: Bool = false, iconUrl: String? = nil) -> DealiTabBarItem {
        var item = DealiTabBarItem()
        item.viewController = viewController
        item.title = title
        item.iconUrl = iconUrl
        item.isHidden = isHidden
        item.showsBadge = showsBadge
        return item
    }
}

struct DealiTabBarItemInfo {
    var contentWidth: CGFloat = 0.0
    var contentStartPositionX: CGFloat = 0.0
    var itemIndex: Int = 0
    var itemButton: DealiTabBarItemButton?
    var itemChip: ClickableComponentChip?
    var itemSelected: Bool = false {
        didSet {
            if let itemChip = self.itemChip {
                itemChip.isSelected = self.itemSelected
            }
            
            if let itemButton = self.itemButton {
                itemButton.isSelected = self.itemSelected
            }
        }
    }
}

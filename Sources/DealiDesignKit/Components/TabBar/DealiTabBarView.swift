//
//  DealiTabBarView.swift
//  
//
//  Created by hoji on 2024/03/26.
//

import UIKit
import RxSwift
import RxCocoa

/// tabber Item Style
enum DealiTabBarStyle {
    case slider
    case segment
    case sliderChip
}

/// tabber item color
enum DealiTabBarChipStyle {
    case chipFilledSmall01
    case chipFilledSmall02
}

struct DealiTabBarPreset {
    var normalFont: UIFont = .b4r12
    var selectedFont: UIFont = .b4r12
    var normalTextColor: UIColor = .clear
    var selectedTextColor: UIColor = .clear
    var spacing: CGFloat = 8.0
    var padding: CGFloat = 0.0
    var segmentTabbarMargin: CGFloat = 16.0
    var sliderTabbarContentInset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 4.0)
    /// 3depth의 경우 tabbar에 높이만 달라질뿐, content영역은 동일하게 위치해야 하기 때문에 height값을 따로 지정,
    var tabberHeight: CGFloat = 44.0
    var tabberContentHeight: CGFloat = 44.0
    
    var style: DealiTabBarStyle = .slider
    var chipStyle: DealiTabBarChipStyle = .chipFilledSmall02
}

public class DealiTabber {
    
    public static func testTabberSegment() -> DealiTabBarView {
        var preset = DealiTabBarPreset()
        preset.normalFont = .b1r15
        preset.selectedFont = .b1sb15
        preset.normalTextColor = DealiColor.g70
        preset.selectedTextColor = DealiColor.g100
        preset.spacing = 0.0
        preset.style = .segment
        return DealiTabBarView(preset: preset)
    }
    
    public static func testTabberSlider() -> DealiTabBarView {
        var preset = DealiTabBarPreset()
        preset.normalFont = .b1r15
        preset.selectedFont = .b1sb15
        preset.normalTextColor = DealiColor.g100
        preset.selectedTextColor = DealiColor.primary01
        preset.spacing = 0.0
        preset.padding = 12.0
        preset.style = .slider
        return DealiTabBarView(preset: preset)
    }
    
    public static func testTabberChip() -> DealiTabBarView {
        var preset = DealiTabBarPreset()
        preset.normalFont = .b1r15
        preset.selectedFont = .b1sb15
        preset.normalTextColor = DealiColor.g100
        preset.selectedTextColor = DealiColor.primary01
        preset.spacing = 8.0
        preset.tabberHeight = 56.0
        preset.tabberContentHeight = 56.0
        preset.sliderTabbarContentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        preset.style = .sliderChip
        preset.chipStyle = .chipFilledSmall01
        return DealiTabBarView(preset: preset)
    }
    
    public static func testTabber3Depth() -> DealiTabBarView {
        var preset = DealiTabBarPreset()
        preset.normalFont = .b1r15
        preset.selectedFont = .b1sb15
        preset.normalTextColor = DealiColor.g100
        preset.selectedTextColor = DealiColor.primary01
        preset.spacing = 0.0
        preset.padding = 12.0
        preset.style = .slider
        preset.tabberHeight = 36.0
        preset.tabberContentHeight = 44.0
        return DealiTabBarView(preset: preset)
    }
}

final public class DealiTabBarView: UIView {
    
    public let didSelectTabBarIndex = PublishRelay<(index: Int, animated: Bool)>()

    private lazy var contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let selectedUnderLineImageView = UIImageView()
    
    private var tabbarItemInfoArray: [DealiTabBarItemInfo] = []
    
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
            $0.height.equalTo(preset.tabberHeight)
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
                $0.left.right.equalToSuperview().inset(preset.segmentTabbarMargin)
            }
            
            self.addSubview(self.selectedUnderLineImageView)
            
        default:

            self.addSubview(self.contentScrollView)
            self.contentScrollView.then {
                $0.bounces = false
                $0.clipsToBounds = false
                $0.showsHorizontalScrollIndicator = false
                $0.showsVerticalScrollIndicator = false
                $0.contentInset = preset.sliderTabbarContentInset
            }.snp.makeConstraints {
                $0.bottom.left.right.equalToSuperview()
                $0.height.equalTo(preset.tabberContentHeight)
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
                $0.spacing = preset.spacing
                $0.distribution = .equalSpacing
                $0.alignment = .center
            }.snp.makeConstraints {
                $0.top.bottom.left.right.equalToSuperview()
            }
            
            self.contentScrollView.addSubview(self.selectedUnderLineImageView)
        }
        
        
        self.selectedUnderLineImageView.then {
            $0.isHidden = (preset.style == .sliderChip)
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
    
    private func clear() {
        self.tabbarItemInfoArray.forEach { itemInfo in
            itemInfo.itemButton?.removeFromSuperview()
            itemInfo.itemChip?.removeFromSuperview()
        }
        self.contentStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.tabbarItemInfoArray.removeAll()
    }
    
    public func setTabbarItems(tabbarItemArray: [DealiTabBarItem], maintainContentOffset: Bool = true) {
        
        if self.selectedIndex >= tabbarItemArray.count {
            self.selectedIndex = (tabbarItemArray.count - 1)
        }
        
        let offset = self.contentScrollView.contentOffset
        
        self.clear()
        
        for (index, item) in tabbarItemArray.enumerated() {
            guard let title = item.title else { continue }
            var buttonContentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
            if let _ = item.iconUrl, self.preset.style != .sliderChip {
                buttonContentWidth += 20.0
            }
            
            switch self.preset.style {
            case .sliderChip:
                switch self.preset.chipStyle {
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
                    
                    self.tabbarItemInfoArray.append(DealiTabBarItemInfo(itemIndex: index, itemChip: itemChip, itemSelected: (index == self.selectedIndex)))
                case .chipFilledSmall02:
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
                    
                    self.tabbarItemInfoArray.append(DealiTabBarItemInfo(itemIndex: index, itemChip: itemChip, itemSelected: (index == self.selectedIndex)))
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
                    if self.preset.style == .slider {
                        $0.width.equalTo(buttonContentWidth + (self.preset.padding * 2.0))
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
        
        if self.preset.style != .sliderChip {
            self.layoutIfNeeded()
            for index in 0..<self.tabbarItemInfoArray.count {
                if let itemButton = self.tabbarItemInfoArray[index].itemButton {
                    if self.preset.style == .segment {
                        self.tabbarItemInfoArray[index].contentWidth = ((UIScreen.main.bounds.size.width - (self.preset.segmentTabbarMargin * 2.0)) / CGFloat(tabbarItemArray.count))
                        self.tabbarItemInfoArray[index].contentStartPositionX = self.preset.segmentTabbarMargin + (self.tabbarItemInfoArray[index].contentWidth * CGFloat(index))
                    } else {
                        self.tabbarItemInfoArray[index].contentStartPositionX = itemButton.frame.origin.x + self.preset.padding
                    }
                }
            }
            
            self.selectedUnderLineImageView.snp.updateConstraints {
                $0.left.equalToSuperview().offset(self.tabbarItemInfoArray[self.selectedIndex].contentStartPositionX)
                $0.width.equalTo(self.tabbarItemInfoArray[self.selectedIndex].contentWidth)
            }
        }
        
    }
    
    @objc func itemPressed(_ sender: UIControl) {
        self.setSelectedIndex(sender.tag, animated: true)
    }
    
    public func setSelectedIndex(_ index: Int, animated: Bool) {
        self.selectedIndex = index
        
        self.didSelectTabBarIndex.accept((index: self.selectedIndex, animated: animated))
        
        if self.preset.style != .sliderChip {
            self.selectedUnderLineImageView.snp.updateConstraints {
                $0.left.equalToSuperview().offset(self.tabbarItemInfoArray[self.selectedIndex].contentStartPositionX)
                $0.width.equalTo(self.tabbarItemInfoArray[self.selectedIndex].contentWidth)
            }
        }
    }
    
    public func viewScroll(page: Int, fractional: CGFloat) {

        if fractional.isInfinite {
            return
        }

        let preIdx: Int = Int(floor(fractional))
        let nexIdx: Int = Int(ceil(fractional))
        let calc = fractional - CGFloat(preIdx)

        var posX = 0.0
        var width = 0.0

        if preIdx < 0 {
            if let item = self.tabbarItemInfoArray.first {
                posX = item.contentStartPositionX
                width = item.contentWidth
            }
        } else if nexIdx >= self.tabbarItemInfoArray.count {
            if let item = self.tabbarItemInfoArray.last {
                posX = item.contentStartPositionX
                width = item.contentWidth
            }
        } else {
            let preItem = self.tabbarItemInfoArray[preIdx]
            let nexItem = self.tabbarItemInfoArray[nexIdx]
            posX = preItem.contentStartPositionX + (nexItem.contentStartPositionX - preItem.contentStartPositionX) * calc
            width = (preItem.contentWidth) + ((nexItem.contentWidth) - (preItem.contentWidth)) * calc
        }
        self.selectedIndex = page
        
        self.selectedUnderLineImageView.snp.updateConstraints {
            $0.width.equalTo(width)
            $0.left.equalToSuperview().offset(posX)
        }

        if self.preset.style == .segment {
            return
        }
        
        var offset: CGFloat = -1
        var margin: CGFloat = self.preset.padding

        if posX - margin < self.contentScrollView.contentOffset.x {
            offset = posX - margin
        } else if posX + width + margin > self.contentScrollView.contentOffset.x + self.contentScrollView.frame.width - self.contentScrollView.contentInset.right {
            offset = (posX + width + margin) - self.contentScrollView.frame.width + self.contentScrollView.contentInset.right
        }

        if offset >= 0 {
            self.contentScrollView.contentOffset = CGPoint(x: offset, y: self.contentScrollView.contentOffset.y)
        }
    }

}

public struct DealiTabBarItem {
    public var viewController: UIViewController?
    public var page: Int = 0
    
    var title: String?
    /// 배지 보여줄지 여부
    var showsBadge: Bool = false
    var iconUrl: String?
    
    public static func make(_ viewController: UIViewController? = nil, title: String, iconUrl: String? = nil) -> DealiTabBarItem {
        var item = DealiTabBarItem()
        item.viewController = viewController
        item.title = title
        item.iconUrl = iconUrl
        
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

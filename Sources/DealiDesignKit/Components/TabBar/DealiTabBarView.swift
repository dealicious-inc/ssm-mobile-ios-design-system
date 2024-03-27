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
    var tabberHeight: CGFloat = 44.0
    var tabberContentHeight: CGFloat = 44.0
    
    var style: DealiTabBarStyle = .slider
    var chipStyle: DealiTabBarChipStyle = .chipFilledSmall02
}

class DealiTabBarView: UIView {
    
    var didSelectTabBarIndex = PublishRelay<Int>()

    private lazy var contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let selectedUnderLineImageView = UIImageView()
    
    private var tabbarItemButtonArray: [DealiTabBarItemButton] = []
    private var tabbarItemInfoArray: [DealiTabBarItemInfo] = []
    
    private var selectedIndex: Int = 0 {
        didSet {
//            self.tabbarItemInfoArray.forEach({ $0.itemSelected = ($0.itemIndex == self.selectedIndex) })
            
            for var itemInfo in self.tabbarItemInfoArray {
                itemInfo.itemSelected = (itemInfo.itemIndex == self.selectedIndex)
            }
        }
    }
    
    private var preset: DealiTabBarPreset
    
    init(preset: DealiTabBarPreset) {
        
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.then {
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.height.equalTo(preset.tabberHeight)
        }
        
        switch preset.style {
        case .segment:
            self.addSubview(self.contentStackView)
            self.addSubview(self.selectedUnderLineImageView)
            
        default:
            self.addSubview(self.contentScrollView)
            self.contentScrollView.then {
                $0.bounces = false
                $0.clipsToBounds = false
                $0.showsHorizontalScrollIndicator = false
                $0.showsVerticalScrollIndicator = false
                $0.contentInset = UIEdgeInsets(top: 0.0, left: (preset.style == .sliderChip ? 16.0 : 4.0), bottom: 0.0, right: (preset.style == .sliderChip ? 16.0 : 4.0))
            }.snp.makeConstraints {
                $0.top.bottom.left.right.equalToSuperview()
            }
            
            self.contentScrollView.addSubview(self.contentStackView)
            self.contentScrollView.addSubview(self.selectedUnderLineImageView)
        }
        
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.spacing = preset.spacing
            $0.distribution = (preset.style == .segment ? .fillEqually : .equalSpacing)
            $0.alignment = .center
            $0.clipsToBounds = false
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset((preset.style == .segment ? 16.0 : 0.0))
            
        }
        
        self.selectedUnderLineImageView.then {
            $0.isHidden = (preset.style != .sliderChip)
            $0.backgroundColor = preset.selectedTextColor
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(1.0)
            $0.left.equalToSuperview()
            $0.height.equalTo(2.0)
            $0.width.equalTo(0.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func clear() {
        self.tabbarItemButtonArray.forEach({ $0.removeFromSuperview() })
        self.contentStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.tabbarItemButtonArray.removeAll()
    }
    
    func setTabbarItems(tabbarItemArray: [DealiTabBarItem], maintainContentOffset: Bool = true) {
        
        if self.selectedIndex >= tabbarItemArray.count {
            self.selectedIndex = (tabbarItemArray.count - 1)
        }
        
        let offset = self.contentScrollView.contentOffset
        
        self.clear()
        
        for (index, item) in tabbarItemArray.enumerated() {
            guard let title = item.title else { continue }
            var buttonContentWidth = title.size(withAttributes: [.font: self.preset.normalFont]).width
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
                    }.snp.makeConstraints {
                        $0.centerY.equalToSuperview()
                    }
                    
                    self.tabbarItemInfoArray.append(DealiTabBarItemInfo(itemIndex: index, itemSelected: (index == self.selectedIndex), itemChip: itemChip))
                case .chipFilledSmall02:
                    let itemChip = DealiControl.chipFilledSmall01()
                    self.contentStackView.addArrangedSubview(itemChip)
                    itemChip.then {
                        $0.title = title
                        $0.addTarget(self, action: #selector(itemPressed(_:)), for: .touchUpInside)
                        $0.tag = index
                    }.snp.makeConstraints {
                        $0.centerY.equalToSuperview()
                    }
                    
                    self.tabbarItemInfoArray.append(DealiTabBarItemInfo(itemIndex: index, itemSelected: (index == self.selectedIndex), itemChip: itemChip))
                }
                
            default:
                let itemButton = DealiTabBarItemButton()
                self.contentStackView.addArrangedSubview(itemButton)
                itemButton.then {
                    $0.setTitle(title, for: .normal)
                    $0.configure(preset: self.preset)
                    $0.tag = index
                    $0.addTarget(self, action: #selector(itemPressed(_:)), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
                
                self.tabbarItemInfoArray.append(DealiTabBarItemInfo(itemIndex: index, itemSelected: (index == self.selectedIndex), itemButton: itemButton))
            }
        }
    }
    
    @objc func itemPressed(_ sender: UIControl) {
        self.selectedIndex = sender.tag
        self.didSelectTabBarIndex.accept(self.selectedIndex)
    }

}

struct DealiTabBarItem {
    var viewController: UIViewController?
    var title: String?
    var page: Int = 0
    /// 배지 보여줄지 여부
    var showsBadge: Bool = false
    var iconUrl: String?
    
    static func make(_ viewController: UIViewController, title: String, iconUrl: String? = nil) -> DealiTabBarItem {
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
    var itemButton: DealiTabBarItemButton?
    var itemChip: ClickableComponentChip?
}

class DealiTabBarItemButton: UIButton {
    
    private var preset: DealiTabBarPreset?
    
    private let badgeImageView = UIImageView()
    private let iconImageView = UIImageView()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.alpha = 0.3
            } else {
                self.alpha = 1.0
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.isExclusiveTouch = true
        
        self.addSubview(self.badgeImageView)
        self.badgeImageView.then {
            $0.backgroundColor = DealiColor.primary01
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 2.0
            $0.isHidden = true
        }.snp.makeConstraints {
            guard let titleLabel = titleLabel else {return}
            $0.left.equalTo(titleLabel.snp.right).offset(0.0)
            $0.bottom.equalTo(titleLabel.snp.top).offset(3.0)
            $0.size.equalTo(CGSize(width: 4.0, height: 4.0))
        }
        
        self.addSubview(self.iconImageView)
        self.iconImageView.then {
            $0.clipsToBounds = true
            $0.isHidden = true
        }.snp.makeConstraints {
            guard let titleLabel = titleLabel else { return }
            $0.right.equalTo(titleLabel.snp.left)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(preset: DealiTabBarPreset) {
        self.preset = preset
        
        self.setTitleColor(preset.normalTextColor, for: .normal)
        self.setTitleColor(preset.selectedTextColor, for: .selected)
         
        self.titleLabel?.font = preset.normalFont
        
    }
}

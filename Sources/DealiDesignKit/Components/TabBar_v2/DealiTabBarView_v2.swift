//
//  DealiTabBarView_v2.swift
//  
//
//  Created by 이창호 on 11/4/24.
//

import UIKit
import RxSwift
import RxCocoa

public class DealiTabBar_v2 {
    
    public static func tabBarSegment01() -> DealiTabBarView_v2 {
        return DealiTabBarView_v2(preset: .tabBarSegment01)
    }
    
    public static func tabBarSlider01() -> DealiTabBarView_v2 {
        return DealiTabBarView_v2(preset: .tabBarSlider01)
    }
    
    public static func tabBarSlider02() -> DealiTabBarView_v2 {
        return DealiTabBarView_v2(preset: .tabBarSlider02)
    }
    
    public static func tabBarChip01() -> DealiTabBarView_v2 {
        return DealiTabBarView_v2(preset: .tabBarChip01)
    }
    
    public static func tabBarSlider03() -> DealiTabBarView_v2 {
        return DealiTabBarView_v2(preset: .tabBarSlider03)
    }
}

@objc public protocol DealiTabBarViewDelegate_v2 {
    @objc func didSelectTabBar(_ tabBarView: DealiTabBarView_v2, selectedIndex index: Int, showScrollAnimation animation: Bool)
}

final public class DealiTabBarView_v2: UIView {

    public weak var delegate: DealiTabBarViewDelegate_v2?

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let selectedLineImageView = UIImageView()
    private let bottomDividerView = UIView()
    
    private var tabBarItemInfoArray: [DealiTabBarItemInfo_v2] = []
    
    /// 해당 TabBarView를 단독으로 사용되면 true / tabBarViewController 와 함께 사용되면 false
    public var isStandAloneView: Bool = false
    
    /// TabBar의 구성 및 레이아웃 처리가 정상적으로 완료되었는지에 대한 Bool값(선택된 tab이 center 정렬로 적용하기 위해서는 collectionView width값이 있어야 하는데 then에서 Tabbar item을 구성하게 되면 collectionView width 값이 아직 0.0이라서 레이아웃이 정상적으로 적용되지 않는 이슈로 인해 layoutSubviews 에서 collectionView width값이 세팅되면 그때 다시 레이아웃을 적용하기위해 추가)
    private var isLayoutInitialized = false
    
    private var selectedIndex: Int = -1 {
        didSet {
            for index in 0..<self.tabBarItemInfoArray.count {
                self.tabBarItemInfoArray[index].itemSelected = (self.tabBarItemInfoArray[index].itemIndex == self.selectedIndex)
            }
            self.collectionView.reloadData()
        }
    }
    
    private var preset: DealiTabBarPreset_V2
    
    init(preset: DealiTabBarPreset_V2) {
        
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.then {
            $0.backgroundColor = DealiColor.primary04
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.height.equalTo(preset.tabBarViewHeight)
        }
        
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
        self.addSubview(self.collectionView)
        self.collectionView.then {
            $0.delegate = self
            $0.dataSource = self
            if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.do {
                    $0.scrollDirection = .horizontal
                    $0.minimumLineSpacing = self.preset.itemSpacing
                    $0.sectionInset = UIEdgeInsets.init(top: 0.0, left: self.preset.tabBarLRMargin, bottom: 0.0, right: self.preset.tabBarLRMargin)
                }
            }
            $0.backgroundColor = .white
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(cellClass: DealiTabBarItemTextStyleCell.self)
            $0.register(cellClass: DealiTabBarItemChipStyleCell.self)
        }.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(self.preset.tabBerContentHeight)
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        
        self.addSubview(self.bottomDividerView)
        self.bottomDividerView.then {
            if case .sliderChip(_) = preset.style {
                $0.isHidden = true
            } else {
                $0.isHidden = false
                $0.backgroundColor = DealiColor.g30
            }
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(-preset.tabBarLRMargin)
            $0.height.equalTo(1.0)
        }

        
        self.collectionView.addSubview(self.selectedLineImageView)
        self.selectedLineImageView.then {
            $0.backgroundColor = preset.selectedTextColor
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(preset.tabBerContentHeight - 2.0)
            $0.left.equalToSuperview().offset(0.0)
            $0.height.equalTo(2.0)
            $0.width.equalTo(0.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
       
        if self.collectionView.frame.width > 0.0 && self.collectionView.contentSize.width > 0.0 && self.isLayoutInitialized == false && self.tabBarItemInfoArray.count > 0 {

            self.isLayoutInitialized = true
            self.setSelectedIndexWithScroll(index: self.selectedIndex, isMoveAnimation: false)
        }
    }
    
    public func setSelectedIndex(index: Int, animated: Bool = false) {
        self.setSelectedIndexWithScroll(index: index)
        
        /// tabbar Item button 클릭으로 이벤트 발생시 선택된 Button의 index값을 didSelectTabBarIndex를 통해 전달
        self.delegate?.didSelectTabBar(self, selectedIndex: self.selectedIndex, showScrollAnimation: animated)
    }
    
    /// TabBar를 구성할 정보를 받아 TabBar Item Button 생성 및 정보 저장
    public func setTabBarItems(tabBarItemArray: [DealiTabBarItem], maintainContentOffset: Bool = true, startIndex: Int = 0, isStandAloneView: Bool = false) {
        /// 가려지는 tabbar item이 있다면 해당 아이템을 제외하고 TabBarView를 재구성
        let itemArray = tabBarItemArray.filter({ $0.isHidden == false })
        
        self.tabBarItemInfoArray.removeAll()
        
        self.isStandAloneView = isStandAloneView
        for (index, item) in itemArray.enumerated() {
            guard let title = item.title else { continue }
            var contentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
            if let _ = item.icon {
                contentWidth += 16.0 + 2.0
            }
            
            switch self.preset.style {
            case .segment, .slider:
                var itemInfo = DealiTabBarItemInfo_v2()
                itemInfo.itemIndex = index
                itemInfo.itemCellUIModel = DealiTabBarItemCellUIModel.make(preset: self.preset, tabbarItem: item)
                itemInfo.contentWidth = contentWidth
                
                if case .segment = self.preset.style {
                    itemInfo.containerWidth = ((UIScreen.main.bounds.size.width - (self.preset.tabBarLRMargin * 2.0)) / CGFloat(itemArray.count))
                    itemInfo.contentWidth = itemInfo.containerWidth
                } else {
                    itemInfo.containerWidth = contentWidth + (self.preset.itemLRPadding * 2.0)
                    itemInfo.contentWidth = contentWidth
                }
                
                self.tabBarItemInfoArray.append(itemInfo)
                
            case .sliderChip(let chipStyle):
                break
            default:
                break
            }
        }
        
        self.selectedIndex = startIndex
        self.updateTabBarItemPositions()
        
    }
    
    /// tabbar가 생성되거나 tabbar에 구성된 item의 정보가 변경되었을경우 해당 item 의 position X 값을 갱신 및 세팅
    private func updateTabBarItemPositions() {
        self.layoutIfNeeded()
        for index in 0..<self.tabBarItemInfoArray.count {
            
            let indexPath = IndexPath(item: index, section: 0)
            
            if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                let cellXPosition = attributes.frame.origin.x
                if case .segment = self.preset.style {
                    self.tabBarItemInfoArray[index].contentPositionX = cellXPosition
                } else if case .slider = self.preset.style {
                    self.tabBarItemInfoArray[index].contentPositionX = cellXPosition + self.preset.itemLRPadding
                }
            }
        }
        
        if self.isLayoutInitialized == true {
            self.setSelectedIndexWithScroll(index: self.selectedIndex)
        }
    }
    
    private func setSelectedIndexWithScroll(index: Int, isMoveAnimation: Bool = true) {
        print("setSelectedIndexWithScroll")
        guard index < self.tabBarItemInfoArray.count else { return }
        self.selectedIndex = index

        
        /// TabBar가 단독으로 생성되어 사용되는경우에만 TabBar Button 을 클릭했을 경우 해당 버튼이 화면에 모두 노출되도록 처리
        if self.preset.style != .segment && self.isStandAloneView {
            self.moveScrollContentOffset(positionX: self.tabBarItemInfoArray[index].contentPositionX, contentWidth: self.tabBarItemInfoArray[index].contentWidth, isMoveAnimation: isMoveAnimation)
        }
        
        self.updateSelectedLine(width: self.tabBarItemInfoArray[self.selectedIndex].contentWidth, positionX: self.tabBarItemInfoArray[self.selectedIndex].contentPositionX)
    }
    
    /// chip을 사용하는 tabBar에서는 따로 underLine 표시되지않기 때문에 chip이 아닌 경우에만 값을 세팅하도록 처리
    private func updateSelectedLine(width: CGFloat, positionX: CGFloat) {
        if self.preset.style == .segment || self.preset.style == .slider {
            self.selectedLineImageView.snp.updateConstraints {
                $0.left.equalToSuperview().offset(positionX)
                $0.width.equalTo(width)
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
            if let item = self.tabBarItemInfoArray.first {
                positionX = item.contentPositionX
                contentWidth = item.contentWidth
            }
        } else if nexIdx >= self.tabBarItemInfoArray.count {
            if let item = self.tabBarItemInfoArray.last {
                positionX = item.contentPositionX
                contentWidth = item.contentWidth
            }
        } else {
            let preItem = self.tabBarItemInfoArray[preIdx]
            let nexItem = self.tabBarItemInfoArray[nexIdx]
            positionX = preItem.contentPositionX + (nexItem.contentPositionX - preItem.contentPositionX) * calc
            contentWidth = (preItem.contentWidth) + ((nexItem.contentWidth) - (preItem.contentWidth)) * calc
        }
        
        self.selectedIndex = page
        
        self.updateSelectedLine(width: contentWidth, positionX: positionX)
        
        if self.preset.style != .segment {
            self.moveScrollContentOffset(positionX: positionX, contentWidth: contentWidth)
        }
        
    }
    
    /// tabbar Item button을 클릭하거나 ViewController에서 스크롤이 발생했을경우 해당 선택된 tabbar Item Button이 화면에 노출되도록 offset 변경
    private func moveScrollContentOffset(positionX: CGFloat, contentWidth: CGFloat, isMoveAnimation: Bool = false) {
        var offset: CGFloat = -1

        if case .sliderChip(_) = self.preset.style {
            if positionX < self.collectionView.contentOffset.x || self.collectionView.frame.width <= 0 {
                offset = positionX
            } else if (positionX + contentWidth) > self.collectionView.contentOffset.x + self.collectionView.frame.width {
                offset = (positionX + contentWidth) - self.collectionView.frame.width
            }
        } else {
            
            let centerOffsetX = (self.collectionView.frame.width / 2)
            offset = positionX - centerOffsetX + (contentWidth / 2)
            offset = max(offset, 0)
            let maxOffsetX = self.collectionView.contentSize.width - self.collectionView.frame.width
            offset = min(offset, maxOffsetX)
        }

        
        if offset >= 0 {
            self.collectionView.setContentOffset(CGPoint(x: offset, y: self.collectionView.contentOffset.y), animated: isMoveAnimation)
        }
    }
    
    
    /// 특정 index에 위치한 tabbaritem의 title 변경 처리
    public func changeTabBarButtonTitle(index: Int, title: String) {
//        guard index < self.tabBarItemInfoArray.count else { return }
//        
//        if case .sliderChip(_) = self.preset.style {
////            self.tabBarItemInfoArray[index].itemChip?.title = title
//        } else {
//            if var uiModel = self.tabBarItemInfoArray[index].itemCellUIModel {
//                var contentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
//                if let _ = uiModel.iconURL {
//                    contentWidth += 16.0 + 2.0
//                }
//                self.tabBarItemInfoArray[index].contentWidth = contentWidth
//                self.tabBarItemInfoArray[index].containerWidth = contentWidth + (self.preset.contentButtonPadding * 2.0)
//                
//                uiModel.title = title
//            }
//        }
//        self.collectionView.reloadData()
//        self.updateTabBarItemPositions()
    }
    
    
    
    public func showTabBarItemBadge(index: Int, shouldShowBadge: Bool) {
//        guard index < self.tabBarItemInfoArray.count else { return }
//        if self.preset.style == .segment || self.preset.style == .sliderButton {
//            if var itemCellUIModel = self.tabBarItemInfoArray[index].itemCellUIModel {
//                itemCellUIModel.shouldExposeNewBadge = shouldShowBadge
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    
}

extension DealiTabBarView_v2: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tabBarItemInfoArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             
        if case .sliderChip(_) = self.preset.style {
            let cell = collectionView.dequeueReusableCell(cellClass: DealiTabBarItemChipStyleCell.self, indexPath: indexPath)
//            cell.configure(uiModel: self.tabBarItemInfoArray[indexPath.item].itemCellUIModel!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(cellClass: DealiTabBarItemTextStyleCell.self, indexPath: indexPath)
            cell.configure(uiModel: self.tabBarItemInfoArray[indexPath.item].itemCellUIModel!)
            return cell
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == self.selectedIndex {
            return
        }
        self.setSelectedIndex(index: indexPath.item, animated: true)
    }
}

extension DealiTabBarView_v2: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.tabBarItemInfoArray[indexPath.item].containerWidth, height: self.preset.tabBarViewHeight)
    }
}

struct DealiTabBarItemInfo_v2 {
    /// View width 정보
    var containerWidth: CGFloat = 0.0
    /// View 안에 들어가는 content width 정보
    var contentWidth: CGFloat = 0.0
    var contentPositionX: CGFloat = 0.0
    var itemIndex: Int = 0
    var itemCellUIModel: DealiTabBarItemCellUIModel?
    var itemSelected: Bool = false {
        didSet {
            if let _ = self.itemCellUIModel {
                self.itemCellUIModel?.isSelected = self.itemSelected
            }
        }
    }
}

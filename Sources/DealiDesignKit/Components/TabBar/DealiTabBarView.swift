//
//  DealiTabBarView.swift
//
//
//  Created by 이창호 on 11/4/24.
//

import UIKit
import RxSwift
import RxCocoa

public class DealiTabBar {
    
    public static func tabBarSegment01(isSelectedItemCentered: Bool = true) -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBarSegment01, isSelectedItemCentered: isSelectedItemCentered)
    }
    
    public static func tabBarSlider01(isSelectedItemCentered: Bool = true) -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBarSlider01, isSelectedItemCentered: isSelectedItemCentered)
    }
    
    public static func tabBarSlider02(isSelectedItemCentered: Bool = true) -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBarSlider02, isSelectedItemCentered: isSelectedItemCentered)
    }
    
    public static func tabBarChip01(isSelectedItemCentered: Bool = true) -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBarChip01, isSelectedItemCentered: isSelectedItemCentered)
    }
    
    public static func tabBarChip02(isSelectedItemCentered: Bool = true) -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBarChip02, isSelectedItemCentered: isSelectedItemCentered)
    }
    
    public static func tabBarImgChip01(isSelectedItemCentered: Bool = true, showImageChipSlotWhenSelected: Bool = true) -> DealiTabBarView {
        return DealiTabBarView(preset: .tabBarImgChip01, isSelectedItemCentered: isSelectedItemCentered, showImageChipSlotWhenSelected: showImageChipSlotWhenSelected)
    }
}

@objc public protocol DealiTabBarViewDelegate {
    @objc func didSelectTabBar(_ tabBarView: DealiTabBarView, selectedIndex index: Int, showScrollAnimation animation: Bool)
}

final public class DealiTabBarView: UIView {
    
    public weak var delegate: DealiTabBarViewDelegate?
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var selectedLineView = UIView()
    private lazy var bottomDividerView = UIView()
    
    private var tabBarItemInfoArray: [DealiTabBarItemInfo] = []
    
    /// 선택된 탭바아이템이 화면 중앙에 위치하는 인터랙션 적용 유무 (중요!!!! setTabBarItems 함수보다 먼저 세팅)
    public var isSelectedItemCentered: Bool = true
    /// Image Chip Slot 영역이 선택 상태일 때만 노출되는지 여부
    /// true일 경우 선택 상태에서만 노출, false일 경우 항상 노출
    public var showImageChipSlotWhenSelected: Bool = true
    
    /// TabBar의 구성 및 레이아웃 처리가 정상적으로 완료되었는지에 대한 Bool값(선택된 tab이 center 정렬로 적용하기 위해서는 collectionView width값이 있어야 하는데 then에서 Tabbar item을 구성하게 되면 collectionView width 값이 아직 0.0이라서 레이아웃이 정상적으로 적용되지 않는 이슈로 인해 layoutSubviews 에서 collectionView width값이 세팅되면 그때 다시 레이아웃을 적용하기위해 추가)
    private var isLayoutInitialized = false
    
    private var selectedIndex: Int = -1 {
        didSet {
            for index in 0..<self.tabBarItemInfoArray.count {
                self.tabBarItemInfoArray[index].itemSelected = (self.tabBarItemInfoArray[index].itemIndex == self.selectedIndex)
            }
            self.collectionView.reloadData()
            
            self.updateImageChipPosition()
        }
    }
    
    private var preset: DealiTabBarPreset
    
    init(preset: DealiTabBarPreset, isSelectedItemCentered: Bool = true, showImageChipSlotWhenSelected: Bool = true) {
        
        self.preset = preset
        self.isSelectedItemCentered = isSelectedItemCentered
        self.showImageChipSlotWhenSelected = showImageChipSlotWhenSelected
        
        super.init(frame: .zero)
        
        self.then {
            $0.backgroundColor = .primary04
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.height.equalTo(preset.tabBarViewHeight).priority(.high)
        }
        
        self.addSubview(self.collectionView)
        self.collectionView.then {
            $0.delegate = self
            $0.dataSource = self
            if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.do {
                    $0.scrollDirection = .horizontal
                    $0.minimumInteritemSpacing = self.preset.itemSpacing
                    $0.minimumLineSpacing = 0.0
                }
            }
            $0.contentInset = UIEdgeInsets.init(top: 0.0, left: self.preset.tabBarHorizontalMargin, bottom: 0.0, right: self.preset.tabBarHorizontalMargin)
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.register(cellClass: DealiTabBarItemTextStyleCell.self)
            $0.register(cellClass: DealiTabBarItemChipStyleCell.self)
            $0.register(cellClass: DealiTabBarItemImageChipStyleCell.self)
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(self.preset.tabBarContentHeight)
        }
        
        self.collectionView.backgroundView = UIView()
        
        self.collectionView.backgroundView?.addSubview(self.bottomDividerView)
        self.bottomDividerView.then {
            $0.backgroundColor = preset.bottomDividerColor
        }.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        
        if self.preset.style == .segment || preset.style == .slider {
            self.createSelectedLine()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSelectedLine() {
        
        self.collectionView.addSubview(self.selectedLineView)
        self.selectedLineView.then {
            $0.backgroundColor = preset.selectedTextColor
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(preset.tabBarContentHeight - 2.0)
            $0.left.equalToSuperview().offset(0.0)
            $0.height.equalTo(2.0)
            $0.width.equalTo(0.0)
        }
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.collectionView.frame.width > 0.0 && self.collectionView.contentSize.width > 0.0 && self.isLayoutInitialized == false && self.tabBarItemInfoArray.count > 0 {
            
            self.isLayoutInitialized = true
            if self.selectedIndex >= 0 {
                self.setSelectedIndexWithScroll(index: self.selectedIndex, isMoveAnimation: false)
            }
        }
    }
    
    public func setSelectedIndex(index: Int, animated: Bool = true) {
        guard index >= 0 else { return }
        self.selectedIndex = index
        self.setSelectedIndexWithScroll(index: index)
        
        /// tabbar Item button 클릭으로 이벤트 발생시 선택된 Button의 index값을 didSelectTabBarIndex를 통해 전달
        self.delegate?.didSelectTabBar(self, selectedIndex: index, showScrollAnimation: animated)
    }
    
    /// TabBar를 구성할 정보를 받아 TabBar Item Button 생성 및 정보 저장
    public func setTabBarItems(tabBarItemArray: [DealiTabBarItemProtocol], startIndex: Int = 0) {
        /// 가려지는 tabbar item이 있다면 해당 아이템을 제외하고 TabBarView를 재구성
        let itemArray = tabBarItemArray.filter({ $0.isHidden == false })
        
        self.tabBarItemInfoArray.removeAll()
        
        for (index, item) in itemArray.enumerated() {
            guard let title = item.title else { continue }
            var contentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
            if let _ = item.icon {
                contentWidth += 16.0 + 2.0
            }
            
            switch self.preset.style {
            case .segment, .slider:
                var itemInfo = DealiTabBarItemInfo()
                itemInfo.itemIndex = index
                itemInfo.itemTextCellUIModel = DealiTabBarItemTextStyleCellUIModel.make(preset: self.preset, tabbarItem: item)
                
                if case .segment = self.preset.style {
                    itemInfo.containerWidth = ((UIScreen.main.bounds.size.width - (self.preset.tabBarHorizontalMargin * 2.0)) / CGFloat(itemArray.count))
                    itemInfo.contentWidth = itemInfo.containerWidth
                } else {
                    itemInfo.containerWidth = contentWidth + (self.preset.itemHorizontalPadding * 2.0)
                    itemInfo.contentWidth = contentWidth
                }
                
                self.tabBarItemInfoArray.append(itemInfo)
                
            case .sliderChip(let chipStyle):
                var itemInfo = DealiTabBarItemInfo()
                itemInfo.itemIndex = index
                itemInfo.itemChipCellUIModel = DealiTabBarItemChipStyleCellUIModel.make(chipStyle: chipStyle, tabbarItem: item)
                itemInfo.itemSelected = (index == self.selectedIndex)
                if let itemChip = itemInfo.itemChipCellUIModel?.itemChip {
                    itemInfo.containerWidth = (itemChip.fixedSize.width)
                    itemInfo.contentWidth = (itemChip.fixedSize.width)
                }
                
                self.tabBarItemInfoArray.append(itemInfo)
                
            case .sliderImageChip(let imageChipStyle):
                var itemInfo = DealiTabBarItemInfo()
                itemInfo.itemIndex = index
                itemInfo.itemImageChipCellUIModel = DealiTabBarItemImageChipStyleCellUIModel.make(imageChipStyle: imageChipStyle, tabbarItem: item, showImageChipSlotWhenSelected: self.showImageChipSlotWhenSelected)
                itemInfo.itemSelected = (index == self.selectedIndex)
                if let itemImageChip = itemInfo.itemImageChipCellUIModel?.itemImageChip {
                    itemInfo.containerWidth = (itemImageChip.intrinsicContentSize.width)
                    itemInfo.contentWidth = (itemImageChip.intrinsicContentSize.width)
                }
                
                self.tabBarItemInfoArray.append(itemInfo)
            }
        }
        
        var selectedIndex = self.selectedIndex
        
        if selectedIndex == -1 || (startIndex < self.tabBarItemInfoArray.count) {
            selectedIndex = startIndex
        } else {
            if selectedIndex >= self.tabBarItemInfoArray.count {
                selectedIndex = (self.tabBarItemInfoArray.count - 1)
            }
        }
        
        /// startIndex 값이 -2인경우는 초기화면에서 선택된 탭이 없는경우이므로 selectedIndex 값을 -2로 설정
        if startIndex == -2 {
            selectedIndex = startIndex
        }
        
        /// TabBar가 세팅될때 offset 값을 초기 세팅으로 돌린 후에 포지션을 다시 적용한다.
        self.collectionView.setContentOffset(CGPoint(x: -self.preset.tabBarHorizontalMargin, y: self.collectionView.contentOffset.y), animated: false)
        
        self.selectedIndex = selectedIndex
        self.updateTabBarItemPositions()
        
    }
    
    /// tabbar가 생성되거나 tabbar에 구성된 item의 정보가 변경되었을경우 해당 item 의 position X 값을 갱신 및 세팅
    private func updateTabBarItemPositions(isOnlyPositionUpdate: Bool = false) {
        self.layoutIfNeeded()
        for index in 0..<self.tabBarItemInfoArray.count {
            
            let indexPath = IndexPath(item: index, section: 0)
            
            if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                let cellXPosition = attributes.frame.origin.x
                
                if self.preset.style == .slider {
                    self.tabBarItemInfoArray[index].contentPositionX = cellXPosition + self.preset.itemHorizontalPadding
                } else {
                    self.tabBarItemInfoArray[index].contentPositionX = cellXPosition
                }
            }
        }
        
        if self.selectedIndex >= 0 && isOnlyPositionUpdate == false {
            self.setSelectedIndexWithScroll(index: self.selectedIndex, isMoveAnimation: false)
        }
    }
    
    private func setSelectedIndexWithScroll(index: Int, isMoveAnimation: Bool = true) {
        guard index < self.tabBarItemInfoArray.count else { return }
        
        /// tabBar 스타일이 segment가 아닌경우에만 tabBar item 이 센터에 위치하게 하거나 화면에 노출되도록 이동함수 호출
        if self.preset.style != .segment {
            self.moveScrollContentOffset(positionX: self.tabBarItemInfoArray[index].contentPositionX, contentWidth: self.tabBarItemInfoArray[index].contentWidth, isMoveAnimation: isMoveAnimation)
        }
        
        self.updateSelectedLine(width: self.tabBarItemInfoArray[index].contentWidth, positionX: self.tabBarItemInfoArray[index].contentPositionX)
    }
    
    /// chip을 사용하는 tabBar에서는 따로 underLine 표시되지않기 때문에 chip이 아닌 경우에만 값을 세팅하도록 처리
    private func updateSelectedLine(width: CGFloat, positionX: CGFloat) {
        if self.preset.style == .segment || self.preset.style == .slider {
            self.selectedLineView.snp.updateConstraints {
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
            self.moveScrollContentOffset(positionX: positionX, contentWidth: contentWidth, isMoveAnimation: false)
        }
        
    }
    
    /// tabbar Item button을 클릭하거나 ViewController에서 스크롤이 발생했을경우 해당 선택된 tabbar Item Button이 화면에 노출되도록 offset 변경
    private func moveScrollContentOffset(positionX: CGFloat, contentWidth: CGFloat, isMoveAnimation: Bool = false) {
        /// content width가 frame width보다 작으면 offset 변경 처리를 하지 않도록 함
        guard (self.collectionView.contentSize.width + (self.preset.tabBarHorizontalMargin * 2.0)) > self.collectionView.bounds.size.width else {
            return
        }
        var offset: CGFloat = -1
        
        if self.isSelectedItemCentered == true {
            
            let centerOffsetX = (self.collectionView.frame.width / 2)
            let maxOffsetX = self.collectionView.contentSize.width - self.collectionView.frame.width + self.preset.tabBarHorizontalMargin

            // ContentInset을 고려한 offset 계산
            offset = positionX - centerOffsetX + (contentWidth / 2)
            offset = max(offset, -self.preset.tabBarHorizontalMargin) // 최소 offset을 tabBarHorizontalMargin에 맞춤
            offset = min(offset, maxOffsetX) // 최대 offset을 maxOffsetX에 맞춤
            
        } else {
            
            var offsetMargin = 0.0
            
            if self.preset.style == .slider {
                offsetMargin = (self.preset.tabBarHorizontalMargin + self.preset.itemHorizontalPadding)
            } else {
                offsetMargin = (self.preset.tabBarHorizontalMargin)
            }
            
            if (positionX - offsetMargin) < self.collectionView.contentOffset.x || self.collectionView.frame.width <= 0 {
                offset = (positionX - offsetMargin)
            } else if (positionX + contentWidth + offsetMargin) > self.collectionView.contentOffset.x + self.collectionView.frame.width {
                offset = (positionX + contentWidth + offsetMargin) - self.collectionView.frame.width
            }
        }
        
        if offset != -1.0 {
            self.collectionView.setContentOffset(CGPoint(x: offset, y: self.collectionView.contentOffset.y), animated: isMoveAnimation)
        }
        
    }
    
    /// 특정 index에 위치한 tabbaritem의 title 변경 처리
    public func changeTabBarButtonTitle(index: Int, title: String) {
        guard index < self.tabBarItemInfoArray.count else { return }
        
        if self.preset.style == .segment || self.preset.style == .slider {
            if let uiModel = self.tabBarItemInfoArray[index].itemTextCellUIModel {
                var contentWidth = title.size(withAttributes: [.font: self.preset.selectedFont]).width
                if let _ = uiModel.iconURL {
                    contentWidth += 16.0 + 2.0
                }
                
                if case .slider = self.preset.style {
                    self.tabBarItemInfoArray[index].contentWidth = contentWidth
                    self.tabBarItemInfoArray[index].containerWidth = contentWidth + (self.preset.itemHorizontalPadding * 2.0)
                }
                
                self.tabBarItemInfoArray[index].itemTextCellUIModel?.title = title
            }
        } else {
            if case .sliderChip(_) = self.preset.style {
                self.tabBarItemInfoArray[index].itemChipCellUIModel?.itemChip?.title = title
                if let itemChip = self.tabBarItemInfoArray[index].itemChipCellUIModel?.itemChip {
                    self.tabBarItemInfoArray[index].contentWidth = (itemChip.fixedSize.width)
                    self.tabBarItemInfoArray[index].containerWidth = (itemChip.fixedSize.width)
                }
            } else if case .sliderImageChip(_) = self.preset.style {
                self.tabBarItemInfoArray[index].itemImageChipCellUIModel?.itemImageChip?.title = title
                if let itemImageChip = self.tabBarItemInfoArray[index].itemImageChipCellUIModel?.itemImageChip {
                    self.tabBarItemInfoArray[index].contentWidth = (itemImageChip.intrinsicContentSize.width)
                    self.tabBarItemInfoArray[index].containerWidth = (itemImageChip.intrinsicContentSize.width)
                }
            }
        }
        
        self.collectionView.reloadData()
        self.updateTabBarItemPositions()
    }
    
    // MARK - segment와 slider의 경우 틍정항목에 new 뱃지를 노출하도록 처리 함수
    public func showTabBarItemBadge(index: Int, shouldShowBadge: Bool) {
        guard index < self.tabBarItemInfoArray.count else { return }
        if self.preset.style == .segment || self.preset.style == .slider {
            self.tabBarItemInfoArray[index].itemTextCellUIModel?.shouldExposeNewBadge = shouldShowBadge
            self.collectionView.reloadData()
        }
    }
    
    // MARK - 이미지칩 사용시 선택된 항목에만 Slot View가 노출되야하는 상광일때 SeletedIndex 값이 변할때 마다 변화된 Image CHip width와 position값을 새롭게 세팅
    private func updateImageChipPosition() {
        if case .sliderImageChip(_) = self.preset.style {
            if self.showImageChipSlotWhenSelected == true {
                for index in 0..<self.tabBarItemInfoArray.count {
                    self.tabBarItemInfoArray[index].containerWidth = (self.tabBarItemInfoArray[index].itemImageChipCellUIModel?.itemImageChip?.intrinsicContentSize.width ?? 0.0)
                    self.tabBarItemInfoArray[index].contentWidth = (self.tabBarItemInfoArray[index].itemImageChipCellUIModel?.itemImageChip?.intrinsicContentSize.width ?? 0.0)
                }
                self.updateTabBarItemPositions(isOnlyPositionUpdate: true)
            }
        }
    }
}

extension DealiTabBarView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tabBarItemInfoArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if case .sliderChip(_) = self.preset.style {
            let cell = collectionView.dequeueReusableCell(cellClass: DealiTabBarItemChipStyleCell.self, indexPath: indexPath)
            cell.configure(uiModel: self.tabBarItemInfoArray[indexPath.item].itemChipCellUIModel)
            return cell
        } else if case .sliderImageChip(_) = self.preset.style {
            let cell = collectionView.dequeueReusableCell(cellClass: DealiTabBarItemImageChipStyleCell.self, indexPath: indexPath)
            cell.configure(uiModel: self.tabBarItemInfoArray[indexPath.item].itemImageChipCellUIModel)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(cellClass: DealiTabBarItemTextStyleCell.self, indexPath: indexPath)
            cell.configure(uiModel: self.tabBarItemInfoArray[indexPath.item].itemTextCellUIModel)
            return cell
        }
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == self.selectedIndex {
            return
        }
        /// 탭바 이동시 터치하면 스크롤이 멈추는 이슈가 있어 해당 처리를 통해 스크롤 되고 잇을때 다른 터치를 받이 않도록 처리
        collectionView.isUserInteractionEnabled = false
        
        self.setSelectedIndex(index: indexPath.item)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            collectionView.isUserInteractionEnabled = true
        }
        
    }
}

extension DealiTabBarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.tabBarItemInfoArray[indexPath.item].containerWidth, height: self.preset.tabBarViewHeight)
    }
}

public struct DealiTabBarIcon {
    var url: URL?
    var size: CGSize
    
    public init(url: URL?, size: CGSize) {
        self.url = url
        self.size = size
    }
}

struct DealiTabBarItemInfo {
    /// View width 정보
    var containerWidth: CGFloat = 0.0
    /// View 안에 들어가는 content width 정보
    var contentWidth: CGFloat = 0.0
    var contentPositionX: CGFloat = 0.0
    var itemIndex: Int = 0
    var itemTextCellUIModel: DealiTabBarItemTextStyleCellUIModel?
    var itemChipCellUIModel: DealiTabBarItemChipStyleCellUIModel?
    var itemImageChipCellUIModel: DealiTabBarItemImageChipStyleCellUIModel?
    var itemSelected: Bool = false {
        didSet {
            if let _ = self.itemTextCellUIModel {
                self.itemTextCellUIModel?.isSelected = self.itemSelected
            }
            
            if let itemCellUIModel = self.itemChipCellUIModel, let itemChip = itemCellUIModel.itemChip {
                itemChip.isSelected = self.itemSelected
            }
            
            if let itemImageChipCellUIModel = self.itemImageChipCellUIModel, let itemImageChip = itemImageChipCellUIModel.itemImageChip {
                itemImageChip.isSelected = self.itemSelected
            }
        }
    }
}

public protocol DealiTabBarItemProtocol {
    var viewController: UIViewController? { get set }
    var page: Int { get set }
    var title: String? { get set }
    var isHidden: Bool { get set }
    var showsBadge: Bool { get set }
    var icon: DealiTabBarIcon? { get set }
    var imageChipSlotView: DealiCustomView? { get set }
    
}

public struct DealiTabBarItem: DealiTabBarItemProtocol {
    public var viewController: UIViewController?
    public var page: Int = 0
    public var title: String?
    public var isHidden: Bool = false
    public var showsBadge: Bool = false
    public var icon: DealiTabBarIcon?
    public var imageChipSlotView: DealiCustomView?

    public static func make(_ viewController: UIViewController? = nil,
                            title: String,
                            isHidden: Bool = false,
                            showsBadge: Bool = false,
                            icon: DealiTabBarIcon? = nil,
                            imageChipSlotView: DealiCustomView? = nil) -> DealiTabBarItem {
        var item = DealiTabBarItem()
        item.viewController = viewController
        item.title = title
        item.icon = icon
        item.isHidden = isHidden
        item.showsBadge = showsBadge
        item.imageChipSlotView = imageChipSlotView
        return item
    }
}

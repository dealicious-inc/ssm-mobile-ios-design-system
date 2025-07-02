//
//  TabBarView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 6/9/25.
//

import SwiftUI

public final class TabBarItemViewModel: ObservableObject {
    @Published public var title: String?
    @Published public var isHidden: Bool
    @Published public var showBadge: Bool
    @Published public var icon: DealiTabBarIcon?
    
    public init(title: String?,
                isHidden: Bool = false,
                showBadge: Bool = false,
                icon: DealiTabBarIcon? = nil) {
        self.title = title
        self.isHidden = isHidden
        self.showBadge = showBadge
        self.icon = icon
    }
}

public final class TabBarViewModel: ObservableObject {
    public var type: DealiTabBarPreset
    @Published public var selectedIndex: Int = 0
    @Published public var items: [TabBarItemViewModel] = []
    @Published public var imageChipItems: [DealiImageChipTabBarItem] = []
    public var action: () -> Void
    
    var isScrollable: Bool = false
    
    public init(type: DealiTabBarPreset,
                items: [TabBarItemViewModel] = [],
                imageChipItems: [DealiImageChipTabBarItem] = [],
                selectedIndex: Int = 0,
                action: @escaping () -> Void = {}) {
        self.type = type
        self.selectedIndex = selectedIndex
        self.items = items
        self.imageChipItems = imageChipItems
        self.isScrollable = {
            switch type.style {
            case .slider, .sliderChip, .sliderImageChip:
                return true
            default:
                return false
            }
        }()
        self.action = action
    }
}

public struct TabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    public var selectedIndex: Int {
        get {
            return self.viewModel.selectedIndex
        } set {
            self.viewModel.selectedIndex = newValue
        }
    }
    
    public init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }
    
    public init(type: DealiTabBarPreset,
                items: [TabBarItemViewModel] = [],
                selectedIndex: Int = 0) {
        let viewModel = TabBarViewModel(type: type,
                                        items: items,
                                        selectedIndex: selectedIndex)
        self.init(viewModel: viewModel)
    }
    
    public init(type: DealiTabBarPreset,
                imageChipItems: [DealiImageChipTabBarItem] = [],
                selectedIndex: Int = 0) {
        let viewModel = TabBarViewModel(type: type,
                                        imageChipItems: imageChipItems,
                                        selectedIndex: selectedIndex)
        self.init(viewModel: viewModel)
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            divider
            Group {
                if viewModel.isScrollable {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: viewModel.type.itemSpacing) {
                                tabButtons
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .onAppear {
                            proxy.scrollTo(viewModel.selectedIndex, anchor: .center)
                        }
                        .onChange(of: viewModel.selectedIndex) { index in
                            withAnimation {
                                proxy.scrollTo(index, anchor: .center)
                            }
                        }
                    }
                } else {
                    HStack(spacing: viewModel.type.itemHorizontalPadding) {
                        tabButtons
                    }
                }
            }
            .padding(.horizontal, viewModel.type.tabBarHorizontalMargin)
        }
        .frame(height: viewModel.type.tabBarContentHeight)
    }

    private var tabButtons: some View {
        Group {
            switch viewModel.type.style {
            case .sliderImageChip(let style):
                ForEach(viewModel.imageChipItems.indices, id: \.self) { index in
                    imageChipTabItemView(viewModel.imageChipItems[index], index: index, style: style)
                }
            default:
                ForEach(viewModel.items.indices, id: \.self) { index in
                    switch viewModel.type.style {
                    case .segment, .slider:
                        buttonTabItemView(viewModel.items[index], index: index)
                    case .sliderChip(let style):
                        chipTabItemView(viewModel.items[index], index: index, style: style)
                    case .sliderImageChip:
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(Color(viewModel.type.bottomDividerColor))
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
    
    private var badge: some View {
        Circle()
            .fill(Color(.primary01))
            .frame(width: 4, height: 4)
            .offset(x: 4, y: -4)
    }
    
    private struct IndicatorView: View {
        let isSelected: Bool
        let color: Color

        var body: some View {
            Rectangle()
                .fill(isSelected ? color : .clear)
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
    
    @ViewBuilder
    private func buttonTabItemView(_ item: TabBarItemViewModel, index: Int) -> some View {
        Button(action: {
            selectTabItem(index)
        }) {
            let isSelected = viewModel.selectedIndex == index
            let type = viewModel.type
            
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    HStack(spacing: 0) {
                        if let icon = viewModel.items[index].icon {
                            ImageHelper.kfImage(url: icon.url, size: icon.size)
                        }
                        
                        Text(viewModel.items[index].title ?? "")
                            .font(isSelected ? Font(type.selectedFont) : Font(type.font))
                            .foregroundColor(isSelected ? Color(type.selectedTextColor) : Color(type.textColor))
                            .frame(maxWidth: .infinity , maxHeight: .infinity)
                    }
                    
                    if viewModel.items[index].showBadge {
                        badge
                    }
                }
                .fixedSize()
                .frame(height: viewModel.type.tabBarContentHeight - 2)
                
                if type.style == .segment || type.style == .slider {
                    IndicatorView(isSelected: isSelected, color: Color(type.selectedTextColor))
                }
            }
            .padding(.horizontal, type.itemHorizontalPadding)
            .fixedSize(horizontal: viewModel.isScrollable, vertical: false)
        }
    }
    
    @ViewBuilder
    private func chipTabItemView(_ item: TabBarItemViewModel,
                                 index: Int,
                                 style: DealiTabBarPreset.DealiTabBarSliderChipStyle) -> some View {
        let chipType: ChipViewType = {
            switch style {
            case .chipFilledSmall02: return .chipFilledSmall02
            case .chipFilledSmall03: return .chipFilledSmall03
            }
        }()
        let chipViewModel = ChipViewModel(
            type: chipType,
            text: item.title ?? "",
            status: index == viewModel.selectedIndex ? .selected : .normal
        )
        
        ChipView(
            viewModel: chipViewModel,
            action: {
                selectTabItem(index)
            }
        )
        .padding(.horizontal, viewModel.type.itemHorizontalPadding)
        .frame(height: viewModel.type.tabBarContentHeight - 2)
        .fixedSize(horizontal: viewModel.isScrollable, vertical: false)
    }
    
    @ViewBuilder
    private func imageChipTabItemView(_ item: DealiImageChipTabBarItem,
                                      index: Int,
                                      style: DealiTabBarPreset.DealiTabBarSliderImageChipStyle) -> some View {
        let presentType: ImageChipPreset = {
            switch style {
            case .imgChipSmall01: return .imgChipSmall01
            }
        }()
        let imgChipViewModel = DealiImageChipViewModel(urlString: item.viewModel.urlString,
                                                       text: item.viewModel.text,
                                                       status: index == viewModel.selectedIndex ? .selected : .normal,
                                                       iconName: item.viewModel.iconName)
        DealiImageChip(
            viewModel: imgChipViewModel,
            action: {
                selectTabItem(index)
            },
            content: {
                item.content()
            }, preset: presentType
        )
        .padding(.horizontal, viewModel.type.itemHorizontalPadding)
        .frame(height: viewModel.type.tabBarContentHeight - 2)
        .fixedSize(horizontal: viewModel.isScrollable, vertical: false)
    }
    
    private func selectTabItem(_ index: Int) {
        viewModel.selectedIndex = index
        viewModel.action()
    }
}

#Preview {
    let icon = DealiTabBarIcon(url: URL(string: "https://v4.img.sinsang.market?f=https://image-cache.sinsang.market/home_tab/img_mbs_filled_16_ver01.png&w=48&h=48"), size: CGSize(width: 16.0, height: 16.0))
    let tabBarItems = [TabBarItemViewModel(title: "1번 Tab", showBadge: true),
                       TabBarItemViewModel(title: "2번 Tab"),
                       TabBarItemViewModel(title: "3번 Tab", icon: icon)]
    
    let tabBarLongItems = [TabBarItemViewModel(title: "1번 Tab", showBadge: true),
                           TabBarItemViewModel(title: "2번 Tab", showBadge: true),
                           TabBarItemViewModel(title: "3번 Tab", icon: icon),
                           TabBarItemViewModel(title: "4번 Tab"),
                           TabBarItemViewModel(title: "5번 Tab"),
                           TabBarItemViewModel(title: "6번 Tab"),
                           TabBarItemViewModel(title: "7번 Tab"),
                           TabBarItemViewModel(title: "8번 Tab"),
                           TabBarItemViewModel(title: "9번 Tab")]
    
    Text("Segment01")
    TabBarView(type: .tabBarSegment01, items: tabBarItems)
    
    Text("Slider01")
    TabBarView(type: .tabBarSlider01, items: tabBarItems)
    Text("Slider02")
    TabBarView(type: .tabBarSlider02, items: tabBarLongItems, selectedIndex: 2)
}

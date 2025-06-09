//
//  TabBarView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 6/9/25.
//

import SwiftUI

public final class TabBarItemViewModel: ObservableObject {
    @Published public var title: String?
    @Published public var isHidden: Bool = false
    @Published public var showBadge: Bool = false
    
    public init(title: String?) {
        self.title = title
    }
}

public final class TabBarViewModel: ObservableObject {
    public var type: DealiTabBarPreset
    @Published public var selectedIndex: Int = 0
    @Published public var items: [TabBarItemViewModel] = []
    
    var isScrollable: Bool = false
    
    public init(type: DealiTabBarPreset,
                selectedIndex: Int = 0,
                items: [TabBarItemViewModel] = []) {
        self.type = type
        self.selectedIndex = selectedIndex
        self.items = items
        self.isScrollable = type.style == .slider
    }
}

public struct TabBarView: View {
    var viewModel: TabBarViewModel
    
    public init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }
    
    public init(type: DealiTabBarPreset,
                items: [TabBarItemViewModel] = []) {
        let viewModel = TabBarViewModel(type: type,
                                        selectedIndex: 0,
                                        items: items)
        self.init(viewModel: viewModel)
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            divider
            Group {
                if viewModel.isScrollable {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: viewModel.type.itemHorizontalPadding) {
                            tabButtons
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    HStack(spacing: viewModel.type.itemHorizontalPadding) {
                        tabButtons
                    }
                }
            }
            .padding(.horizontal, viewModel.type.tabBarHorizontalMargin)
        }.frame(height: viewModel.type.tabBarContentHeight)
        
    }

    private var tabButtons: some View {
        ForEach(viewModel.items.indices, id: \.self) { index in
            Button(action: {
                viewModel.selectedIndex = index
            }) {
                let isSelected = viewModel.selectedIndex == index
                let type = viewModel.type
                
                VStack(spacing: 0) {
                    Text(viewModel.items[index].title ?? "")
                        .font(isSelected ? Font(type.selectedFont) : Font(type.font))
                        .foregroundColor(isSelected ? Color(type.selectedTextColor) : Color(type.textColor))
                        .frame(maxWidth: .infinity , maxHeight: .infinity)
                    
                    if type.style == .segment || type.style == .slider {
                        Rectangle()
                            .fill(isSelected ? Color(type.selectedTextColor) : .clear)
                            .frame(maxWidth: .infinity, maxHeight: 2)
                    }
                }
                .fixedSize(horizontal: viewModel.isScrollable, vertical: false)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(Color(viewModel.type.bottomDividerColor))
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
}

#Preview {
    let tabBarItems = [TabBarItemViewModel(title: "1번 Tab"),
                       TabBarItemViewModel(title: "2번 Tab"),
                       TabBarItemViewModel(title: "3번 Tab")
    ]
                       
    TabBarView(type: .tabBarSegment01, items: tabBarItems)
    
    //margin 찾는중..
    TabBarView(type: .tabBarSlider01, items: tabBarItems)
}

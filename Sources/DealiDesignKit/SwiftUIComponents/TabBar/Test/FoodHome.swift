//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 4/28/25.
//

import SwiftUI

struct FoodHome: View {
    
    @State var currentTab = ""
    @Namespace var animation
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30.0) {
                        ForEach(tabItems) { tabItem in
                            VStack {
                                Text(tabItem.tabTitle)
                                    .foregroundStyle(currentTab.replacingOccurrences(of: " SCROLL", with: "") == tabItem.id ? .black : .gray)
                                
                                if currentTab.replacingOccurrences(of: " SCROLL", with: "") == tabItem.id {
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                        .frame(height: 2.0)
                                        .padding(.horizontal, -10)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(height: 2.0)
                                        .padding(.horizontal, -10)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.25)) {
                                    currentTab = "\(tabItem.id) TAP"
                                    proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(30.0)
                }
                .padding(.top)
                .onChange(of: currentTab) { _ in
                    if currentTab.contains(" SCROLL") {
                        withAnimation(.linear(duration: 0.25)) {
                            proxy.scrollTo(currentTab.replacingOccurrences(of: " SCROLL", with: ""), anchor: .center)
                        }
                    }
                }
            }
            .padding([.top])
            .background(scheme == .dark ? Color.black : Color.white)
            .overlay(alignment: .bottom) {
                Divider().padding(.horizontal, 0.0)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { proxy in
                    VStack(spacing: 15.0) {
                        ForEach(tabItems) { tabItem in
                            MenuCardView(tabItem: tabItem, currentTab: $currentTab)
                                .padding(.top)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .onChange(of: currentTab) { newValue in
                        if currentTab.contains(" TAP") {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topLeading)
                            }
                        }
                    }
                }
            }
            .coordinateSpace(name: "SCROLL")
        }
        .onAppear {
            currentTab = tabItems.first?.id ?? ""
        }
    }
}

#Preview {
    FoodHome()
}


struct MenuCardView: View {
    var tabItem: TabModel
    
    @Binding var currentTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text(tabItem.tabTitle)
                .font(.title.bold())
                .padding(.vertical)
                
            ForEach(tabItem.foodList) { food in
                VStack(alignment: .leading, spacing: 10.0) {
                    Text(food.title)
                        .font(.title3.bold())
                    
                    Text(food.description)
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    
                    Text("Price: \(food.price)")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            }
        }
        .modifier(OffsetModifier(tabItem: tabItem, currentTab: $currentTab))
        .id(tabItem.id)
    }
}

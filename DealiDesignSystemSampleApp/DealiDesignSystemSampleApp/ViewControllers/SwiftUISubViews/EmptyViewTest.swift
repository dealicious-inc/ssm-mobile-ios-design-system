//
//  EmptyViewTest.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 3/12/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct EmptyViewTest: View {
    @StateObject var defaultViewModel = DLEmptyViewModel(
        iconImage: Image.dealiIcon(named: "ic_refresh_2_filled"),
        title: "타이틀이 들어가는 영역이예요.",
        subtitle: "서브타이틀이 들어가는 영역이예요.",
        buttonTitle: "재시도"
    )
    
    @StateObject var subtitleViewModel = DLEmptyViewModel(
        iconImage: nil,
        subtitle: "등록된 상품이 없어요."
    )
    
    @StateObject var iconWithSubtitleViewModel = DLEmptyViewModel(
        subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."
    )
    
    @StateObject var iconWithSubtitleAndButtonViewModel = DLEmptyViewModel(
        subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.",
        buttonTitle: "재시도"
    )
    
    @StateObject var longButtonTitleViewModel = DLEmptyViewModel(
        subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.",
        buttonTitle: "일이삼사오육칠팔구십일이삼사"
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                DLEmptyView()
                    .environmentObject(defaultViewModel)
                
                DLEmptyView()
                    .environmentObject(subtitleViewModel)
                    .previewDisplayName("서브타이틀")
                
                DLEmptyView()
                    .environmentObject(iconWithSubtitleViewModel)
                    .previewDisplayName("아이콘 + 서브타이틀")
                
                DLEmptyView()
                    .environmentObject(iconWithSubtitleAndButtonViewModel)
                    .previewDisplayName("아이콘 + 서브타이틀 + 버튼")
                
                DLEmptyView()
                    .environmentObject(longButtonTitleViewModel)
                    .previewDisplayName("버튼이 길어질 때")
            }
        }
    }
}

#Preview {
    EmptyViewTest()
}

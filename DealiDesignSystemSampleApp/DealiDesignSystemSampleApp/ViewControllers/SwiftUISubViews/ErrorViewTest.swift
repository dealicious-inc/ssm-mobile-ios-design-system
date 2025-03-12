//
//  ErrorViewTest.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 3/12/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct ErrorViewTest: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                ErrorView(
                    title: .constant("타이틀이 들어가는 영역이예요."),
                    subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."),
                    buttonTitle: .constant("재시도")
                )
                
                ErrorView(
                    iconImage: nil,
                    subtitle: .constant("등록된 상품이 없어요.")
                )
                
                ErrorView(
                    subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.")
                )
                
                ErrorView(
                    subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."),
                    buttonTitle: .constant("재시도")
                )
                
                ErrorView(
                    title: .constant("타이틀이 들어가는 영역이예요."),
                    subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."),
                    buttonTitle: .constant("일이삼사오육칠팔구십일이삼사")
                )
                
                ErrorView(
                    iconImage: Image.dealiIcon(named: "ic_notice"),
                    title: .constant("타이틀이 들어가는 영역이예요."),
                    subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.")
                )
            }
        }
    }
}

#Preview {
    ErrorViewTest()
}

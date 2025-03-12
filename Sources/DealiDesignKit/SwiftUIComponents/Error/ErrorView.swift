//
//  ErrorView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 3/11/25.
//

import SwiftUI

public struct ErrorView: View {
    
    @State public var iconImage: Image?
    @Binding public var title: String?
    @Binding public var subtitle: String?
    @Binding public var buttonTitle: String?
    public var onTap: (() -> Void)?
    
    public init(iconImage: Image? = Image.dealiIcon(named: ("ic_refresh_2_filled")),
                title: Binding<String?> = .constant(nil),
                subtitle: Binding<String?>,
                buttonTitle: Binding<String?> = .constant(nil),
                onTap: (() -> Void)? = nil) {
        self.iconImage = iconImage
        self._title = title
        self._subtitle = subtitle
        self._buttonTitle = buttonTitle
        self.onTap = onTap
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12.0) {
            self.iconImageView
            self.textContentView
            self.buttonView
        }
    }

    @ViewBuilder var iconImageView: some View {
        if let iconImage {
            iconImage
                .renderingMode(.template)
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(Color(.g60))
        }
    }
    
    @ViewBuilder var textContentView: some View {
        VStack(spacing: 8.0) {
            if let title {
                Text(title)
                    .font(Font(UIFont.sh3sb16))
                    .foregroundColor(Color(.g100))
            }
            
            if let subtitle {
                Text(subtitle)
                    .font(Font(UIFont.b2r14))
                    .foregroundColor(Color(.g60))
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder var buttonView: some View {
        if let buttonTitle {
            ButtonView()
                .setStyle(.btnFilledLarge01)
                .setTitle(buttonTitle)
                .frame(minWidth: 170.0)
                .fixedSize()
                .padding(.top, 12.0)
        }
                
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ErrorView(
                title: .constant("타이틀이 들어가는 영역이예요."),
                subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."),
                buttonTitle: .constant("재시도")
            )
                .previewDisplayName("기본")
            
            ErrorView(
                iconImage: nil,
                subtitle: .constant("등록된 상품이 없어요.")
            )
                .previewDisplayName("서브타이틀")
            
            ErrorView(
                subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.")
            )
                .previewDisplayName("아이콘 + 서브타이틀")
            
            ErrorView(
                subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."),
                buttonTitle: .constant("재시도")
            )
                .previewDisplayName("아이콘 + 서브타이틀 + 버튼")
            
            ErrorView(
                title: .constant("타이틀이 들어가는 영역이예요."),
                subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."),
                buttonTitle: .constant("일이삼사오육칠팔구십일이삼사")
            )
                .previewDisplayName("버튼이 길어질 때")
            
            ErrorView(
                iconImage: Image.dealiIcon(named: "ic_notice"),
                title: .constant("타이틀이 들어가는 영역이예요."),
                subtitle: .constant("데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.")
            )
                .previewDisplayName("아이콘 커스텀")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

//
//  DLEmptyView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 3/11/25.
//

import SwiftUI

public struct DLEmptyView: View {

    @EnvironmentObject public var viewModel: DLEmptyViewModel
    
    public init() {
        
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12.0) {
            self.iconImageView
            self.textContentView
            self.buttonView
        }
    }

    @ViewBuilder var iconImageView: some View {
        if let iconImage = self.viewModel.iconImage {
            iconImage
                .renderingMode(.template)
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(Color(.g60))
        }
    }

    @ViewBuilder var textContentView: some View {
        VStack(spacing: 8.0) {
            if let title = self.viewModel.title {
                Text(title)
                    .font(Font(UIFont.sh3sb16))
                    .foregroundColor(Color(.g100))
            }

            if let subtitle = self.viewModel.subtitle {
                Text(subtitle)
                    .font(Font(UIFont.b2r14))
                    .foregroundColor(Color(.g60))
                    .multilineTextAlignment(.center)
            }
        }
    }

    @ViewBuilder var buttonView: some View {
        if let buttonTitle = self.viewModel.buttonTitle {
            ButtonView()
                .setStyle(.btnFilledLarge01)
                .setTitle(buttonTitle)
                .frame(minWidth: 170.0)
                .fixedSize()
                .padding(.top, 12.0)
        }

    }
}

public final class DLEmptyViewModel: ObservableObject {
    @Published public var iconImage: Image?
    @Published public var title: String?
    @Published public var subtitle: String?
    @Published public var buttonTitle: String?

    public init(
        iconImage: Image? = Image.dealiIcon(named: "ic_refresh_2_filled"),
        title: String? = nil,
        subtitle: String? = nil,
        buttonTitle: String? = nil
    ) {
        self.iconImage = iconImage
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }

    public func setIconImage(_ image: Image) {
        self.iconImage = image
    }

    public func setTitle(_ title: String) {
        self.title = title
    }

    public func setSubtitle(_ subtitle: String) {
        self.subtitle = subtitle
    }

    public func setButtonTitle(_ buttonTitle: String) {
        self.buttonTitle = buttonTitle
    }
}

struct DLEmptyView_Previews: PreviewProvider {

    @StateObject static var defaultViewModel = DLEmptyViewModel(
        iconImage: Image.dealiIcon(named: "ic_refresh_2_filled"),
        title: "타이틀이 들어가는 영역이예요.",
        subtitle: "서브타이틀이 들어가는 영역이예요.",
        buttonTitle: "재시도"
    )

    @StateObject static var subtitleViewModel = DLEmptyViewModel(
        iconImage: nil,
        subtitle: "등록된 상품이 없어요."
    )

    @StateObject static var iconWithSubtitleViewModel = DLEmptyViewModel(
        subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요."
    )
    
    @StateObject static var iconWithSubtitleAndButtonViewModel = DLEmptyViewModel(
        subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.",
        buttonTitle: "재시도"
    )
    
    @StateObject static var longButtonTitleViewModel = DLEmptyViewModel(
        subtitle: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.",
        buttonTitle: "일이삼사오육칠팔구십일이삼사"
    )

    static var previews: some View {

        Group {
            DLEmptyView()
                .environmentObject(defaultViewModel)
                .previewDisplayName("기본")

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
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

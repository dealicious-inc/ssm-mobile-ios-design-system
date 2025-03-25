//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/24/25.
//

import SwiftUI

public struct AccordionView: View {
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var title: String?
        @Published var backgroundColor: Color = Color(uiColor: .g10)
        @Published var contentViews: [AnyView]?
        @Published var contentTopPadding: CGFloat = 16.0
        @Published var contentItemSpacing: CGFloat = 0.0
        @Published var shouldExposeContent: Bool = false
    }
    
    public init() { }
    
    public var body: some View {
        VStack(spacing: 0.0) {
            Button(action: {
                withAnimation {
                    viewModel.shouldExposeContent.toggle()
                }
            }) {
                HStack(spacing: 8.0) {
                    if let icon = UIImage.dealiIcon(named: "ic_notice") {
                        Image(uiImage: icon)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16.0, height: 16.0)
                            .foregroundStyle(Color(uiColor: .g100))
                    }
                    Text(viewModel.title ?? "타이틀")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color(uiColor: .g100))
                        .font(.b2sb14)
                    
                    if let icon = UIImage.dealiIcon(named: "ic_arrow_open") {
                        Image(uiImage: icon)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16.0, height: 16.0)
                            .foregroundStyle(Color(uiColor: .g100))
                            .rotationEffect(Angle(degrees: (viewModel.shouldExposeContent ? 180 : 0)))
                        
                    }
                }.padding(16.0)
            }.background(viewModel.backgroundColor)
            
            if viewModel.shouldExposeContent {
                contentView
            }
            
        }
        .background(viewModel.backgroundColor)
        .cornerRadius(10.0)
        
        
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack(spacing: viewModel.contentTopPadding) {
            Divider()
                .frame(width: .infinity, height: 1.0)
                .background(Color(uiColor: .g30))
                
            VStack(spacing: viewModel.contentItemSpacing) {
                ForEach(Array((viewModel.contentViews ?? []).enumerated()), id: \.0) { index, view in
                    view
                }
            }.frame(maxWidth: .infinity, alignment: .center)
            
        }.padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 16.0, trailing: 16.0))
    }
    
    public func title(_ title: String?) -> Self {
        viewModel.title = title
        return self
    }
    
    public func backgroundColor(_ color: UIColor) -> Self {
        viewModel.backgroundColor = Color(uiColor: color)
        return self
    }
    /// content에 들어갈 View array 정보
    public func contentViews(_ viewArray: [(any View)]) -> Self {
        viewModel.contentViews = viewArray.map {
            return AnyView($0)
        }
        return self
    }
    /// title Button 와 content 간의 간격 수치 설정
    public func contentTopPadding(_ padding: CGFloat) -> Self {
        viewModel.contentTopPadding = padding
        return self
    }
    /// content 간의 spacing 수치 설정
    public func contentItemSpacing(_ spacing: CGFloat) -> Self {
        viewModel.contentItemSpacing = spacing
        return self
    }
    
    /// View 표시시 처음에 오픈된 상태로 보여줄때 호출
    public func isInitiallyOpen() -> Self {
        viewModel.shouldExposeContent = true
        return self
    }
}

#Preview {
    
    let modelArray: [LabeledTextModel] = {
        [
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient))
        ]
    }()
    
    let sss: [(any View)] = {
        [
            LabeledTextGroupView()
                .preset(.labeledTextNumber01)
                .icon(.dealiIcon(named: "ic_info"))
                .labeledModelArray(modelArray)
//            Circle()
//                .frame(width: 100.0, height: 100.0)
//                .foregroundStyle(MbsGradient.gradient01.swiftUIGradient),
//            
//            Circle()
//                .frame(width: 100.0, height: 100.0)
//                .foregroundStyle(MbsGradient.gradient01.swiftUIGradient),
//            
//            Circle()
//                .frame(width: 100.0, height: 100.0)
//                .foregroundStyle(MbsGradient.gradient01.swiftUIGradient)
            
        ]
    }()
    
    AccordionView()
        .title("LabeledText")
        .contentViews(sss)
        .contentItemSpacing(12.0)
        .isInitiallyOpen()
}

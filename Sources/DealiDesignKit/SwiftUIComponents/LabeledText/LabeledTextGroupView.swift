//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/28/25.
//

import SwiftUI

public struct LabeledTextGroupView: View {
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var preset: LabeledTextPreset = .labeledTextBullet01
        @Published var title: String?
        @Published var icon: UIImage?
        @Published var labeledModelArray: [LabeledTextModel] = []
    }
    
    public init() { }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack(alignment: .center, spacing: 8.0) {
                if let titleIconImage = viewModel.icon {
                    Image(uiImage: titleIconImage).renderingMode(.template).resizable().foregroundStyle(Color(uiColor: .g100)).frame(width: 16.0, height: 16.0, alignment: .center)
                }
                
                if let title = viewModel.title {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .foregroundStyle(Color(uiColor: .g100))
                        .font(.b3sb13)
                }
            }

            ForEach(Array(viewModel.labeledModelArray.enumerated()), id: \.0) { index, model in
                LabeledTextView()
                    .preset(viewModel.preset)
                    .model(model)
                    .number(index + 1)
            }
        }
    }
    
    public func preset(_ preset: LabeledTextPreset) -> Self {
        viewModel.preset = preset
        return self
    }
    
    public func title(_ title: String) -> Self {
        viewModel.title = title
        return self
    }
    
    public func icon(_ icon: UIImage?) -> Self {
        viewModel.icon = icon
        return self
    }
    
    public func labeledModelArray(_ labeledModelArray: [LabeledTextModel]) -> Self {
        viewModel.labeledModelArray = labeledModelArray
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
        
    
    VStack(spacing: 20.0) {
        LabeledTextGroupView()
            .preset(.labeledTextBullet01)
            .title("Bullet01")
            .icon(.dealiIcon(named: "ic_info"))
            .labeledModelArray(modelArray)
        
        LabeledTextGroupView()
            .preset(.labeledTextBullet02)
            .labeledModelArray(modelArray)
            .title("Bullet02")
        
        LabeledTextGroupView()
            .preset(.labeledTextNumber01)
            .title("Number01")
            .labeledModelArray(modelArray)
        
        LabeledTextGroupView()
            .preset(.labeledTextNumber02)
            .labeledModelArray(modelArray)
            .icon(.dealiIcon(named: "ic_info"))
            .title("Number02")
        
        LabeledTextGroupView()
            .preset(.labeledTextIcon01)
            .labeledModelArray(modelArray)
            .icon(.dealiIcon(named: "ic_info"))
            .title("Icon01")
        
        LabeledTextGroupView()
            .preset(.labeledTextIcon02)
            .labeledModelArray(modelArray)
            .title("Icon02")
        
        LabeledTextGroupView()
            .title("Custom01")
            .preset(.labeledTextCustom01)
            .labeledModelArray(modelArray)
            .icon(.dealiIcon(named: "ic_info"))
        
        LabeledTextGroupView()
            .title("Custom02")
            .preset(.labeledTextCustom01)
            .icon(.dealiIcon(named: "ic_info"))
            .labeledModelArray(modelArray)
    }
    
}

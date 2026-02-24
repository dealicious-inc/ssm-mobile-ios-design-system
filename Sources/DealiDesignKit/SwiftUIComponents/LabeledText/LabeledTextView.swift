//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/27/25.
//

import SwiftUI

public struct LabeledTextView: View {
    
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var preset: LabeledTextPreset = .labeledTextBullet01
        @Published var model: LabeledTextModel?
        @Published var number: Int?
    }
    
    public init() { }
    
    public var body: some View {
        
        if let model = viewModel.model {
            HStack(alignment: .top, spacing: viewModel.preset.itemSpacing) {
                labelView
                
                Text(model.message)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color(uiColor: viewModel.preset.textColor))
                    .font(viewModel.preset.font)
                    .background(Color.clear)
            }
        }
    }
    
    @ViewBuilder
    private var labelView: some View {
        if let model = viewModel.model {
            let textColor = Color(uiColor: viewModel.preset.textColor)
            switch viewModel.preset.style {
            case .bullet:
                Circle()
                    .frame(width: 3, height: 3)
                    .foregroundStyle(textColor)
                    .offset(y: 7.5)
                
            case .icon:
                if let icon = model.icon {
                    Image(uiImage: icon)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(textColor)
                        .frame(width: 16, height: 16)
                        .offset(y: 1)
                }
                
            case .number:
                Text("\(self.viewModel.number ?? 0).")
                    .foregroundStyle(textColor)
                    .font(viewModel.preset.font)
                
            case .custom:
                if let customView = model.customView {
                    customView
                        .foregroundStyle(textColor)
                        .offset(y: 1)
                }
            }
        }
        
    }
    
    public func preset(_ preset: LabeledTextPreset) -> Self {
        viewModel.preset = preset
        return self
    }
    
    public func model(_ model: LabeledTextModel) -> Self {
        viewModel.model = model
        return self
    }
    
    public func number(_ number: Int?) -> Self {
        viewModel.number = number
        return self
    }

}

#Preview {
    
    VStack(spacing: 20) {
        LabeledTextView()
            .preset(.labeledTextBullet01)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
        
        LabeledTextView()
            .preset(.labeledTextBullet02)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하").applyStyle(TextStyleAttributes(text: "가나다라", color: .primary01))))
        
        LabeledTextView()
            .preset(.labeledTextNumber01)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
        
        LabeledTextView()
            .preset(.labeledTextNumber02)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
        
        LabeledTextView()
            .preset(.labeledTextIcon01)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward")))
        
        LabeledTextView()
            .preset(.labeledTextIcon02)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_repeat")))
        
        LabeledTextView()
            .preset(.labeledTextCustom01)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)))
        
        LabeledTextView()
            .preset(.labeledTextCustom02)
            .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)))
    }
}


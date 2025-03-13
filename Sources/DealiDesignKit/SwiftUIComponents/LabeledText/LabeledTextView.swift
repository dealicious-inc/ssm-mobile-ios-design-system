//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/27/25.
//

import SwiftUI

public struct LabeledTextView: View {
    
    @ObservedObject private var uimodel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var preset: LabeledTextPreset = .labeledTextBullet01
        @Published var model: LabeledTextModel?
        @Published var text: [TextStyleAttributes]?
    }
    
    var text = {
        var dd = AttributedString("가나다라마바사아자차카타파하")
        dd.applyStyles([TextStyleAttributes(text: "가나다라", font: .h1sb32, color: .red),
                         TextStyleAttributes(text: "마바사", font: .h2sb24, color: .blue)])
        return dd
    }
        
    
    public init() {
        
        registerDealiSystemFonts()
        
    }
    
    public var body: some View {
        
        if let model = uimodel.model {
            let textColor = Color(uiColor: uimodel.preset.textColor)
            HStack(alignment: .top, spacing: 0) {
                labelView
                
//                Text(model.message)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundStyle(textColor)
//                    .background(Color.gray)
//                    .font(uimodel.preset.font)
                AttributedText(model.text)
                    .font(uimodel.preset.font)
                    .color(uimodel.preset.textColor)
            }
        }
    }
    
    @ViewBuilder
    private var labelView: some View {
        if let model = uimodel.model {
            let textColor = Color(uiColor: uimodel.preset.textColor)
            switch uimodel.preset.style {
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
                        .background(Color.green)
                        .frame(width: 16, height: 16)
                        .offset(y: 1)
                }
                
            case .number:
                Text("가\n파")
                    .foregroundStyle(textColor)
                    .font(uimodel.preset.font)
                
//                Text("테스트중").font(Font.custom("PretendardJP-Bold", size: 32))
                VStack(spacing: 0.0) {
                    Rectangle()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(Color.blue)

                    Rectangle()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(Color.gray)
                }
                
            case .custom:
                if let customView = model.customView {
                    customView
                        .foregroundStyle(textColor)
                        .background(Color.green)
                        .offset(y: 1)
                }
            }
        }
        
    }
    
    public func preset(_ preset: LabeledTextPreset) -> Self {
        uimodel.preset = preset
        return self
    }
    
    public func model(_ model: LabeledTextModel) -> Self {
        uimodel.model = model
        return self
    }

}

#Preview {
    
    var text = {
        var dd = AttributedString("가나다라마바사아자차카타파하")
//        dd.applyStyles([TextStyleAttributes(text: "가나다라", font: .h1sb32, color: .red),
//                         TextStyleAttributes(text: "마바사", font: .h2sb24, color: .blue)])
        return dd
    }
    
    LabeledTextView()
        .preset(.labeledTextNumber01)
        .model(LabeledTextModel(text: "안녕하세요.\n반갑습니다.", message: text()))
    
//    LabeledTextView()
//        .preset(.labeledTextCustom01)
//        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아가나다라마바사아자차카타파하 가나다라마바사아자차 카타파하", icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0)))
    
//    LabeledTextView()
//        .preset(.labeledTextBullet02)
//        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
//
//    LabeledTextView()
//        .preset(.labeledTextNumber01)
//        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
//    LabeledTextView()
//        .preset(.labeledTextNumber02)
//        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
//
//    LabeledTextView()
//        .preset(.labeledTextIcon01)
//        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디", icon: .dealiIcon(named: "ic_plus_ad_forward")))
//    LabeledTextView()
//        .preset(.labeledTextIcon02)
//        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디", icon: .dealiIcon(named: "ic_repeat")))
    
 
}



public extension AttributedString {
    func applyStyles(_ styles: [TextStyleAttributes]) -> AttributedString {
        for style in styles {
            if let range = self.range(of: style.text) {
//                self[range].foregroundColor = style.color
//                self[range].font = Font(style.font!)
            }
        }
        return self
    }
}

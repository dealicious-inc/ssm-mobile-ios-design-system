//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/27/25.
//

import SwiftUI

public struct LabeledTextView: View {
    
    @ObservedObject private var uimodel = UIModel()

    final class UIModel: ObservableObject {
        @Published var preset: LabeledTextPreset = .labeledTextBullet01
        @Published var model: LabeledTextModel?
    }
    
    public init() {}
    
    public var body: some View {
        if let model = uimodel.model {
            let textColor = Color(uiColor: uimodel.preset.textColor)
            HStack(alignment: .top, spacing: uimodel.preset.itemSpacing) {
                labelView
                
                let test = NSMutableAttributedString(string: model.message)
                    .font(uimodel.preset.font)
                    .color(uimodel.preset.textColor)
                    .updateAttributes(for: TextStyleAttributes(text: "가나다라", font: .b1sb15, color: .purple))
                    .setLineHeight()
                
             
                
                let attributedString: AttributedString = {
                    var string = try? AttributedString(test, including: \.uiKit)
//                    var string = AttributedString(model.message)
                    
//                    if let range1 = string.range(of: "가나") {
//                        string[range1].foregroundColor = UIColor.systemRed
//                    }
//                    
//                    if let range2 = string.range(of: "파하") {
//                        string[range2].strikethroughStyle = .single
//                    }
                    
                    
                    return string ?? AttributedString("실패")
                }()
                
                Text(attributedString)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundStyle(textColor)
//                    .font(uimodel.preset.font)
                
//                Text(model.message)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundStyle(textColor)
//                    .font(uimodel.preset.font)
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
                        .frame(width: 16, height: 16)
                        .offset(y: 1)
                }
                
            case .number:
                Text("\(model.number ?? 0).")
                    .foregroundStyle(textColor)
                    .font(uimodel.preset.font)
                
            case .custom:
                if let customView = model.customView {
                    customView
                        .foregroundStyle(textColor)
                        .offset(y: 1)
                }
//                Circle()
//                    .frame(width: 3, height: 3)
//                    .foregroundStyle(textColor)
//                    .offset(y: 7.5)
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
    
    LabeledTextView()
        .preset(.labeledTextBullet01)
        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아가나다라마바사아자차카타파하 가나다라마바사아자차카타파하", icon: .dealiIcon(named: "ic_plus_ad_forward")))
    
    LabeledTextView()
        .preset(.labeledTextCustom01)
        .model(LabeledTextModel(message: "가나다라마바사아자차카타파하 아가나다라마바사아자차카타파하 가나다라마바사아자차카타파하", icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0)))
    
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

extension View {
    func font(_ font: UIFont) -> some View {
        let fontSpacing = font.dealiLineHeight / 100 * 50 / 4
        return self
            .font(Font(font))
            .background(Color(uiColor: .yellow))
            .padding(.vertical, fontSpacing)
            .background(Color(uiColor: .green))
            .lineSpacing(fontSpacing * 2)
    }
}

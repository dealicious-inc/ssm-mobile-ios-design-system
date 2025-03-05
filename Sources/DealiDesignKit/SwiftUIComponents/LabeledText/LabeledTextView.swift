//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/27/25.
//

import SwiftUI

public struct LabeledTextView: View {
    
    private var preset: LabeledTextPreset?
    private var model: LabeledTextModel?
    
    public init() {
        
    }
    
    public var body: some View {
        if let preset = self.preset, let model = self.model {
            let textColor = Color(uiColor: preset.textColor)
            HStack(alignment: .top, spacing: preset.itemSpacing) {
                labelView
                Text(model.message)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(textColor)
                    .font(preset.font)
            }
        }
    }
    
    @ViewBuilder
    private var labelView: some View {
        if let preset = self.preset, let model = self.model {
            let textColor = Color(uiColor: preset.textColor)
            switch preset.style {
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
                    .font(preset.font)
                
            case .custom:
                Circle()
                    .frame(width: 3, height: 3)
            }
        }
        
    }
    
    public func preset(_ preset: LabeledTextPreset) -> LabeledTextView {
        var copy = self
        copy.preset = preset
        return copy
    }
    
    public func setModel(_ model: LabeledTextModel) -> LabeledTextView {
        var copy = self
        copy.model = model
        return copy
    }
}

#Preview {
    LabeledTextView()
        .preset(.labeledTextBullet01)
        .setModel(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
    LabeledTextView()
        .preset(.labeledTextBullet02)
        .setModel(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
    
    LabeledTextView()
        .preset(.labeledTextNumber01)
        .setModel(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
    LabeledTextView()
        .preset(.labeledTextNumber02)
        .setModel(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"))
    
    LabeledTextView()
        .preset(.labeledTextIcon01)
        .setModel(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디", icon: .dealiIcon(named: "ic_plus_ad_forward")))
    LabeledTextView()
        .preset(.labeledTextIcon02)
        .setModel(LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디", icon: .dealiIcon(named: "ic_repeat")))
}

extension View {
    func font(_ font: UIFont) -> some View {
        let fontSpacing = font.dealiLineHeight / 100 * 50 / 4
        return self
            .font(Font(font))
//            .background(Color(uiColor: .yellow))
            .padding(.vertical, fontSpacing)
//            .background(Color(uiColor: .green))
            .lineSpacing(fontSpacing * 2)
    }
}

//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/27/25.
//

import SwiftUI

struct LabeledTextView: View {
    
    var preset: DealiLabeledTextPreset
    
    var body: some View {
        HStack(alignment: .top, spacing: self.preset.itemSpacing) {
            switch self.preset.style {
            case .bullet:
                Circle().frame(width: 3.0, height: 3.0)
                    .foregroundStyle(Color(uiColor: self.preset.textColor))
                    .offset(y: 7.5)
                    
            case .icon:
                Image(uiImage: .dealiIcon(named: "ic_plus_ad_forward")!).renderingMode(.template).resizable().foregroundStyle(Color(uiColor: self.preset.textColor)).frame(width: 16.0, height: 16.0, alignment: .center)
                    .offset(y: 1.0)
            case .number:
                Text("1.").foregroundStyle(Color(uiColor: self.preset.textColor))
                    .font(self.preset.font)
            case .custom:
                Circle().frame(width: 3.0, height: 3.0)
            }
            
            Text("가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(uiColor: self.preset.textColor))
                .font(self.preset.font)
            
        }
    }
}

#Preview {
    LabeledTextView(preset: .labeledTextBullet01)
    LabeledTextView(preset: .labeledTextBullet02)
    
    LabeledTextView(preset: .labeledTextIcon01)
    LabeledTextView(preset: .labeledTextIcon02)
    
    LabeledTextView(preset: .labeledTextNumber01)
    LabeledTextView(preset: .labeledTextNumber02)
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

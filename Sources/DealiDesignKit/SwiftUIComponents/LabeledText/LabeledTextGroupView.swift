//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/28/25.
//

import SwiftUI

public struct LabeledText {
    public static var labeledTextBullet01: some View {
        LabeledTextGroupView(preset: .labeledTextBullet01)
    }
    
    public static var labeledTextBullet02: some View {
        LabeledTextGroupView(preset: .labeledTextBullet02)
    }
    
    public static var labeledTextNumber01: some View {
        LabeledTextGroupView(preset: .labeledTextNumber01)
    }
    
    public static var labeledTextNumber02: some View {
        LabeledTextGroupView(preset: .labeledTextNumber02)
    }
    
    public static var labeledTextIcon01: some View {
        LabeledTextGroupView(preset: .labeledTextIcon01)
    }
    
    public static var labeledTextIcon02: some View {
        LabeledTextGroupView(preset: .labeledTextIcon02)
    }
    
    public static var labeledTextCustom01: some View {
        LabeledTextGroupView(preset: .labeledTextCustom01)
    }
    
    public static var labeledTextCustom02: some View {
        LabeledTextGroupView(preset: .labeledTextCustom02)
    }
}

struct LabeledTextGroupView: View {
    public var preset: LabeledTextPreset
    public var title: String? = nil
    public var titleIconImage: UIImage? = nil
    public var items: [LabeledTextModel] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            if let title = self.title {
                HStack(alignment: .center, spacing: 8.0) {
                    if let titleIconImage = self.titleIconImage {
                        Image(uiImage: titleIconImage).renderingMode(.template).resizable().foregroundStyle(Color(uiColor: .g100)).frame(width: 16.0, height: 16.0, alignment: .center)
                    }
                    
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .foregroundStyle(Color(uiColor: .g100))
                        .font(.b3sb13)
                }
            }
            
            ForEach(items) { item in
                LabeledTextView(preset: preset, model: item)
            }
        }
    }
}

#Preview {
    LabeledTextGroupView(preset: .labeledTextBullet01,title: "타이틀",titleIconImage: .dealiIcon(named: "ic_info"), items: [LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")])
}

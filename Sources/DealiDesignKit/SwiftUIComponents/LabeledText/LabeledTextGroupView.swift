//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 2/28/25.
//

import SwiftUI

public struct LabeledText {
    public static var labeledTextBullet01: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextBullet01)
    }
    
    public static var labeledTextBullet02: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextBullet02)
    }
    
    public static var labeledTextNumber01: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextNumber01)
    }
    
    public static var labeledTextNumber02: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextNumber02)
    }
    
    public static var labeledTextIcon01: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextIcon01)
    }
    
    public static var labeledTextIcon02: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextIcon02)
    }
    
    public static var labeledTextCustom01: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextCustom01)
    }
    
    public static var labeledTextCustom02: LabeledTextGroupView {
        LabeledTextGroupView(preset: .labeledTextCustom02)
    }
}

public struct LabeledTextGroupView: View {
    public var preset: LabeledTextPreset
    
    private var model: LabeledTextGroupModel?
    
    public init(preset: LabeledTextPreset) {
        self.preset = preset
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            if let model = self.model {
                HStack(alignment: .center, spacing: 8.0) {
                    if let titleIconImage = model.icon {
                        Image(uiImage: titleIconImage).renderingMode(.template).resizable().foregroundStyle(Color(uiColor: .g100)).frame(width: 16.0, height: 16.0, alignment: .center)
                    }
                    
                    Text(model.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .foregroundStyle(Color(uiColor: .g100))
                        .font(.b3sb13)
                }
                

//                ForEach(model.labeledModelArray.enumerated().map { (index, labeledTextModel) in
//                    var copyModel = labeledTextModel
//                    copyModel.number = index + 1
//                    return copyModel
//                }, id: \.id) { model in
//                    LabeledTextView().preset(self.preset).setModel(model)
//                }
            }
        }
    }
    
    public func setModel(_ model: LabeledTextGroupModel) -> LabeledTextGroupView {
        var copy = self
        copy.model = model
        return copy
    }
}

#Preview {
    let model = LabeledTextGroupModel(title: "타이틀", labeledModelArray: [LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"),
                                                                        LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"),
                                                                        LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"),
                                                                        LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디"),
                                                                        LabeledTextModel(message: "가나다라마바사아자차카타파하 아야어여오요우유으이 가갸거겨고교규그기 나냐너녀노뇨누느니 다댜더뎌도됴두듀드디")])
    LabeledTextGroupView(preset: .labeledTextNumber01).setModel(model)
//    LabeledTextGroupView(preset: .labeledTextBullet01,title: "타이틀",titleIconImage: .dealiIcon(named: "ic_info"), items: [LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"), LabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")])
}

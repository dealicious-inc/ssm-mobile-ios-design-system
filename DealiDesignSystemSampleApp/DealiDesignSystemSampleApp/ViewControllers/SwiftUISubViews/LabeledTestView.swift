//
//  LabeledTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 3/4/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct LabeledTestView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    singleLabeledTextView
                    labeledTextGroupView
                }
                .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }.navigationBarTitle("Labeled Text", displayMode: .inline)
    }
    
    @ViewBuilder
    private var singleLabeledTextView: some View {
        VStack(spacing: 10.0) {
//            LabeledTextView().preset(.labeledTextBullet01).setModel(LabeledTextModel(message: "가나다라마바사"))
//            LabeledTextView().preset(.labeledTextBullet02).setModel(LabeledTextModel(message: "가나다라마바사"))
//            
//            LabeledTextView().preset(.labeledTextNumber01).setModel(LabeledTextModel(message: "가나다라마바사"))
//            LabeledTextView().preset(.labeledTextNumber02).setModel(LabeledTextModel(message: "가나다라마바사"))
//            
//            LabeledTextView().preset(.labeledTextIcon01).setModel(LabeledTextModel(message: "가나다라마바사", icon: .dealiIcon(named: "ic_plus_ad_forward")))
//            LabeledTextView().preset(.labeledTextIcon02).setModel(LabeledTextModel(message: "가나다라마바사", icon: .dealiIcon(named: "ic_repeat")))
        }
    }
    
    @ViewBuilder
    private var labeledTextGroupView: some View {
        let groupModel = LabeledTextGroupModel(title: "타이틀", icon: .dealiIcon(named: "ic_info"), labeledModelArray: [LabeledTextModel(message: "가나다라마바사"), LabeledTextModel(message: "가나다라마바사"), LabeledTextModel(message: "가나다라마바사"), LabeledTextModel(message: "가나다라마바사"), LabeledTextModel(message: "가나다라마바사"), LabeledTextModel(message: "가나다라마바사"), LabeledTextModel(message: "가나다라마바사")])
        VStack(spacing: 20.0) {
            LabeledText.labeledTextBullet01.setModel(groupModel)
            LabeledText.labeledTextBullet02.setModel(groupModel)
            
            LabeledText.labeledTextNumber01.setModel(groupModel)
            LabeledText.labeledTextNumber02.setModel(groupModel)
        }
    }
}

#Preview {
    LabeledTestView()
}

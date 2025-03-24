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
                .padding(EdgeInsets(top: 16.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }.navigationBarTitle("Labeled Text", displayMode: .inline)
    }
    
    @ViewBuilder
    private var singleLabeledTextView: some View {
        VStack(spacing: 20) {
            LabeledTextView()
                .preset(.labeledTextBullet01)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하 내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
            
            LabeledTextView()
                .preset(.labeledTextBullet02)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하 내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
            
            
            LabeledTextView()
                .preset(.labeledTextNumber01)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하 내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
            
            LabeledTextView()
                .preset(.labeledTextNumber02)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")))
            
            LabeledTextView()
                .preset(.labeledTextIcon01)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward")))
            
            LabeledTextView()
                .preset(.labeledTextIcon02)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하 내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_repeat")))
            
            LabeledTextView()
                .preset(.labeledTextCustom01)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)))
            
            LabeledTextView()
                .preset(.labeledTextCustom02)
                .model(LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)))
        }
    }
    
    @ViewBuilder
    private var labeledTextGroupView: some View {
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
}

#Preview {
    LabeledTestView()
}

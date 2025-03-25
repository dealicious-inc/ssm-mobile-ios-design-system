//
//  AccordionTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 3/24/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct AccordionTestView: View {
    
    let modelArray: [LabeledTextModel] = {
        [
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient))
        ]
    }()
    
    var body: some View {
        
        let viewArray: [(any View)] = {
            [
                LabeledTextGroupView()
                    .preset(.labeledTextNumber01)
                    .labeledModelArray(modelArray)
    //            Circle()
    //                .frame(width: 100.0, height: 100.0)
    //                .foregroundStyle(MbsGradient.gradient01.swiftUIGradient),
    //
    //            Circle()
    //                .frame(width: 100.0, height: 100.0)
    //                .foregroundStyle(MbsGradient.gradient01.swiftUIGradient),
    //
    //            Circle()
    //                .frame(width: 100.0, height: 100.0)
    //                .foregroundStyle(MbsGradient.gradient01.swiftUIGradient)
                
            ]
        }()
        
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 20.0) {
                    AccordionView()
                        .title("LabeledText_01")
                        .contentViews(viewArray)
                    AccordionView()
                        .title("LabeledText_02")
                        .contentViews(viewArray)
                    AccordionView()
                        .title("LabeledText_03")
                        .contentViews(viewArray)
                        .isInitiallyOpen()
                    AccordionView()
                        .title("LabeledText_04")
                        .contentViews(viewArray)
                }
                .padding(EdgeInsets(top: 16.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .g50))
        }.navigationBarTitle("Accordion", displayMode: .inline)
        
    }
}

#Preview {
    
    
    
    AccordionTestView()
}

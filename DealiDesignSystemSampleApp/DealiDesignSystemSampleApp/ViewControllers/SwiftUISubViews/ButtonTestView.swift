//
//  ButtonTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/25/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct ButtonTestView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    loadingContainer
                    enabledContainer
                    imageContainer
                    
                    Spacer().frame(height: 20)
                    Text("-- Buttons List --")
                        .fontWeight(.bold)
                    
                    largeButtonsContainer
                    mediumButtonsContainer
                    semiMediumButtonsContainer
                    smallButtonsContainer
                    
                    Spacer()
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray)
        }.navigationBarTitle("Button", displayMode: .inline)
    }
    
    @ViewBuilder
    private var loadingContainer: some View {
        HStack(spacing: 10) {
            let loadingButton = ButtonView()
            loadingButton
                .btnFilledLarge01()
                .setTitle("setLoading")
                .setLoading(false)
                .addAction {
                    loadingButton.toggleLoading()
                }
            
            ButtonView().btnOutlineBgLarge01().setTitle("On")
                .addAction {
                    loadingButton.setLoading(true)
                }
            
            ButtonView().btnOutlineBgLarge01().setTitle("Off")
                .addAction {
                    loadingButton.setLoading(false)
                }
        }
    }
    
    @ViewBuilder
    private var enabledContainer: some View {
        HStack(spacing: 10) {
            let enabledButton = ButtonView()
            enabledButton
                .btnFilledLarge01()
                .setTitle("isEnabled True")
            
            ButtonView()
                .btnOutlineBgLarge01()
                .setTitle("Enabled")
                .addAction {
                    enabledButton.setEnabled(true)
                    enabledButton.setTitle("isEnabled True")
                }
            
            ButtonView()
                .btnOutlineBgLarge01()
                .setTitle("Disabled")
                .addAction {
                    enabledButton.setEnabled(false)
                    enabledButton.setTitle("isEnabled False")
                }
        }
    }
    
    @ViewBuilder
    private var imageContainer: some View {
        let image = UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 16.0, height: 16.0))
        
        HStack(spacing: 10) {
            ButtonView()
                .btnFilledSemiMedium01()
                .setTitle("Left Image")
                .setTitleAlignment(.leading)
                .setLeftImage(image)
            
            ButtonView()
                .btnFilledSemiMedium01()
                .setTitle("Right Image")
                .setTitleAlignment(.trailing)
                .setRightImage(image)
            
            ButtonView()
                .btnFilledSemiMedium01()
                .setTitle("Both Image")
                .setTitleAlignment(.center)
                .setLeftImage(image)
                .setRightImage(image)
        }
    }
    
    @ViewBuilder
    private var largeButtonsContainer: some View {
        ButtonView().btnFilledLarge01().setTitle("btnFilledLarge01")
        ButtonView().btnFilledLarge02().setTitle("btnFilledLarge02")
        ButtonView().btnFilledLarge03().setTitle("btnFilledLarge03")
        ButtonView().btnFilledLarge04().setTitle("btnFilledLarge04")
        ButtonView().btnFilledLarge05().setTitle("btnFilledLarge05")
        ButtonView().btnFilledLarge06().setTitle("btnFilledLarge06")
        
        ButtonView().btnFilledRoundLarge01().setTitle("btnFilledRoundLarge01")
        ButtonView().btnFilledRoundLarge02().setTitle("btnFilledRoundLarge02")
        ButtonView().btnFilledRoundLarge03().setTitle("btnFilledRoundLarge03")
        ButtonView().btnFilledRoundLarge01().setTitle("btnFilledRoundLarge01")
        
        ButtonView().btnFilledTonalLarge01().setTitle("btnFilledTonalLarge01")
        ButtonView().btnFilledTonalLarge02().setTitle("btnFilledTonalLarge02")
        ButtonView().btnFilledTonalLarge03().setTitle("btnFilledTonalLarge03")
        ButtonView().btnFilledTonalLarge04().setTitle("btnFilledTonalLarge04")
        ButtonView().btnFilledTonalLarge05().setTitle("btnFilledTonalLarge05")
        ButtonView().btnFilledTonalLarge06().setTitle("btnFilledTonalLarge06")
        
        ButtonView().btnOutlineLarge01().setTitle("btnOutlineLarge01")
        ButtonView().btnOutlineLarge02().setTitle("btnOutlineLarge02")
        ButtonView().btnOutlineLarge03().setTitle("btnOutlineLarge03")
        ButtonView().btnOutlineLarge04().setTitle("btnOutlineLarge04")
        ButtonView().btnOutlineLarge05().setTitle("btnOutlineLarge05")
        ButtonView().btnOutlineLarge06().setTitle("btnOutlineLarge06")
        
        ButtonView().btnOutlineBgLarge01().setTitle("btnOutlineBgLarge01")
        ButtonView().btnOutlineBgLarge03().setTitle("btnOutlineBgLarge03")
        ButtonView().btnOutlineBgLarge04().setTitle("btnOutlineBgLarge04")
        ButtonView().btnOutlineBgLarge05().setTitle("btnOutlineBgLarge05")
        ButtonView().btnOutlineBgLarge06().setTitle("btnOutlineBgLarge06")
        
        ButtonView().btnTextLarge01().setTitle("btnTextLarge01")
        ButtonView().btnTextLarge02().setTitle("btnTextLarge02")
        ButtonView().btnTextLarge03().setTitle("btnTextLarge03")
        ButtonView().btnTextLarge04().setTitle("btnTextLarge04")
        ButtonView().btnTextLarge05().setTitle("btnTextLarge05")
        ButtonView().btnTextLarge06().setTitle("btnTextLarge06")
        ButtonView().btnTextLarge07().setTitle("btnTextLarge07")
    }
    
    @ViewBuilder
    private var mediumButtonsContainer: some View {
        ButtonView().btnFilledMedium01().setTitle("btnFilledMedium01")
        ButtonView().btnFilledMedium02().setTitle("btnFilledMedium02")
        ButtonView().btnFilledMedium03().setTitle("btnFilledMedium03")
        ButtonView().btnFilledMedium04().setTitle("btnFilledMedium04")
        ButtonView().btnFilledMedium05().setTitle("btnFilledMedium05")
        ButtonView().btnFilledMedium06().setTitle("btnFilledMedium06")
        
        ButtonView().btnFilledRoundMedium01().setTitle("btnFilledRoundMedium01")
        ButtonView().btnFilledRoundMedium02().setTitle("btnFilledRoundMedium02")
        ButtonView().btnFilledRoundMedium03().setTitle("btnFilledRoundMedium03")
        
        ButtonView().btnFilledTonalMedium01().setTitle("btnFilledTonalMedium01")
        ButtonView().btnFilledTonalMedium02().setTitle("btnFilledTonalMedium02")
        ButtonView().btnFilledTonalMedium03().setTitle("btnFilledTonalMedium03")
        ButtonView().btnFilledTonalMedium04().setTitle("btnFilledTonalMedium04")
        ButtonView().btnFilledTonalMedium05().setTitle("btnFilledTonalMedium05")
        ButtonView().btnFilledTonalMedium06().setTitle("btnFilledTonalMedium06")
        
        ButtonView().btnOutlineMedium01().setTitle("btnOutlineMedium01")
        ButtonView().btnOutlineMedium02().setTitle("btnOutlineMedium02")
        ButtonView().btnOutlineMedium03().setTitle("btnOutlineMedium03")
        ButtonView().btnOutlineMedium04().setTitle("btnOutlineMedium04")
        ButtonView().btnOutlineMedium05().setTitle("btnOutlineMedium05")
        ButtonView().btnOutlineMedium06().setTitle("btnOutlineMedium06")
        
        ButtonView().btnOutlineBgMedium01().setTitle("btnOutlineBgMedium01")
        ButtonView().btnOutlineBgMedium03().setTitle("btnOutlineBgMedium03")
        ButtonView().btnOutlineBgMedium04().setTitle("btnOutlineBgMedium04")
        ButtonView().btnOutlineBgMedium05().setTitle("btnOutlineBgMedium05")
        ButtonView().btnOutlineBgMedium06().setTitle("btnOutlineBgMedium06")
        
        ButtonView().btnTextMedium01().setTitle("btnTextMedium01")
        ButtonView().btnTextMedium02().setTitle("btnTextMedium02")
        ButtonView().btnTextMedium03().setTitle("btnTextMedium03")
        ButtonView().btnTextMedium04().setTitle("btnTextMedium04")
        ButtonView().btnTextMedium05().setTitle("btnTextMedium05")
        ButtonView().btnTextMedium06().setTitle("btnTextMedium06")
        ButtonView().btnTextMedium07().setTitle("btnTextMedium07")
    }
    
    @ViewBuilder
    private var semiMediumButtonsContainer: some View {
        ButtonView().btnFilledSemiMedium01().setTitle("btnFilledSemiMedium01")
        ButtonView().btnFilledSemiMedium02().setTitle("btnFilledSemiMedium02")
        ButtonView().btnFilledSemiMedium03().setTitle("btnFilledSemiMedium03")
        ButtonView().btnFilledSemiMedium04().setTitle("btnFilledSemiMedium04")
        ButtonView().btnFilledSemiMedium05().setTitle("btnFilledSemiMedium05")
        ButtonView().btnFilledSemiMedium06().setTitle("btnFilledSemiMedium06")
        
        ButtonView().btnFilledRoundSemiMedium01().setTitle("btnFilledRoundSemiMedium01")
        ButtonView().btnFilledRoundSemiMedium02().setTitle("btnFilledRoundSemiMedium02")
        ButtonView().btnFilledRoundSemiMedium03().setTitle("btnFilledRoundSemiMedium03")
        
        ButtonView().btnFilledTonalSemiMedium01().setTitle("btnFilledTonalSemiMedium01")
        ButtonView().btnFilledTonalSemiMedium02().setTitle("btnFilledTonalSemiMedium02")
        ButtonView().btnFilledTonalSemiMedium03().setTitle("btnFilledTonalSemiMedium03")
        ButtonView().btnFilledTonalSemiMedium04().setTitle("btnFilledTonalSemiMedium04")
        ButtonView().btnFilledTonalSemiMedium05().setTitle("btnFilledTonalSemiMedium05")
        ButtonView().btnFilledTonalSemiMedium06().setTitle("btnFilledTonalSemiMedium06")
        
        ButtonView().btnOutlineSemiMedium01().setTitle("btnOutlineSemiMedium01")
        ButtonView().btnOutlineSemiMedium02().setTitle("btnOutlineSemiMedium02")
        ButtonView().btnOutlineSemiMedium03().setTitle("btnOutlineSemiMedium03")
        ButtonView().btnOutlineSemiMedium04().setTitle("btnOutlineSemiMedium04")
        ButtonView().btnOutlineSemiMedium05().setTitle("btnOutlineSemiMedium05")
        ButtonView().btnOutlineSemiMedium06().setTitle("btnOutlineSemiMedium06")
        
        ButtonView().btnOutlineBgSemiMedium01().setTitle("btnOutlineBgSemiMedium01")
        ButtonView().btnOutlineBgSemiMedium03().setTitle("btnOutlineBgSemiMedium03")
        ButtonView().btnOutlineBgSemiMedium04().setTitle("btnOutlineBgSemiMedium04")
        ButtonView().btnOutlineBgSemiMedium05().setTitle("btnOutlineBgSemiMedium05")
        ButtonView().btnOutlineBgSemiMedium06().setTitle("btnOutlineBgSemiMedium06")
        
        ButtonView().btnTextSemiMedium01().setTitle("btnTextSemiMedium01")
        ButtonView().btnTextSemiMedium02().setTitle("btnTextSemiMedium02")
        ButtonView().btnTextSemiMedium03().setTitle("btnTextSemiMedium03")
        ButtonView().btnTextSemiMedium04().setTitle("btnTextSemiMedium04")
        ButtonView().btnTextSemiMedium05().setTitle("btnTextSemiMedium05")
        ButtonView().btnTextSemiMedium06().setTitle("btnTextSemiMedium06")
        ButtonView().btnTextSemiMedium07().setTitle("btnTextSemiMedium07")
    }
    
    @ViewBuilder
    private var smallButtonsContainer: some View {
        ButtonView().btnFilledSmall01().setTitle("btnFilledSmall01")
        ButtonView().btnFilledSmall02().setTitle("btnFilledSmall02")
        ButtonView().btnFilledSmall03().setTitle("btnFilledSmall03")
        ButtonView().btnFilledSmall04().setTitle("btnFilledSmall04")
        ButtonView().btnFilledSmall05().setTitle("btnFilledSmall05")
        ButtonView().btnFilledSmall06().setTitle("btnFilledSmall06")
        
        ButtonView().btnFilledRoundSmall01().setTitle("btnFilledRoundSmall01")
        ButtonView().btnFilledRoundSmall02().setTitle("btnFilledRoundSmall02")
        ButtonView().btnFilledRoundSmall03().setTitle("btnFilledRoundSmall03")
        
        ButtonView().btnFilledTonalSmall01().setTitle("btnFilledTonalSmall01")
        ButtonView().btnFilledTonalSmall02().setTitle("btnFilledTonalSmall02")
        ButtonView().btnFilledTonalSmall03().setTitle("btnFilledTonalSmall03")
        ButtonView().btnFilledTonalSmall04().setTitle("btnFilledTonalSmall04")
        ButtonView().btnFilledTonalSmall05().setTitle("btnFilledTonalSmall05")
        ButtonView().btnFilledTonalSmall06().setTitle("btnFilledTonalSmall06")
        
        ButtonView().btnOutlineSmall01().setTitle("btnOutlineSmall01")
        ButtonView().btnOutlineSmall02().setTitle("btnOutlineSmall02")
        ButtonView().btnOutlineSmall03().setTitle("btnOutlineSmall03")
        ButtonView().btnOutlineSmall04().setTitle("btnOutlineSmall04")
        ButtonView().btnOutlineSmall05().setTitle("btnOutlineSmall05")
        ButtonView().btnOutlineSmall06().setTitle("btnOutlineSmall06")
        
        ButtonView().btnOutlineBgSmall01().setTitle("btnOutlineBgSmall01")
        ButtonView().btnOutlineBgSmall03().setTitle("btnOutlineBgSmall03")
        ButtonView().btnOutlineBgSmall04().setTitle("btnOutlineBgSmall04")
        ButtonView().btnOutlineBgSmall05().setTitle("btnOutlineBgSmall05")
        ButtonView().btnOutlineBgSmall06().setTitle("btnOutlineBgSmall06")
        
        ButtonView().btnTextSmall01().setTitle("btnTextSmall01")
        ButtonView().btnTextSmall02().setTitle("btnTextSmall02")
        ButtonView().btnTextSmall03().setTitle("btnTextSmall03")
        ButtonView().btnTextSmall04().setTitle("btnTextSmall04")
        ButtonView().btnTextSmall05().setTitle("btnTextSmall05")
        ButtonView().btnTextSmall06().setTitle("btnTextSmall06")
        ButtonView().btnTextSmall07().setTitle("btnTextSmall07")
    }
}

#Preview {
    ButtonTestView()
}

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
                .setStyle(.btnFilledLarge01)
                .setTitle("setLoading")
                .setLoading(false)
                .addAction {
                    loadingButton.toggleLoading()
                }
            
            ButtonView()
                .setStyle(.btnOutlineBgLarge01)
                .setTitle("On")
                .addAction {
                    loadingButton.setLoading(true)
                }
            
            ButtonView()
                .setStyle(.btnOutlineBgLarge01)
                .setTitle("Off")
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
                .setStyle(.btnFilledLarge01)
                .setTitle("isEnabled True")
            
            ButtonView()
                .setStyle(.btnOutlineBgLarge01)
                .setTitle("Enabled")
                .addAction {
                    enabledButton.setEnabled(true)
                    enabledButton.setTitle("isEnabled True")
                }
            
            ButtonView()
                .setStyle(.btnOutlineBgLarge01)
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
                .setStyle(.btnFilledSemiMedium01)
                .setTitle("Left Image")
                .setTitleAlignment(.leading)
                .setLeftImage(image)
            
            ButtonView()
                .setStyle(.btnFilledSemiMedium01)
                .setTitle("Right Image")
                .setTitleAlignment(.trailing)
                .setRightImage(image)
            
            ButtonView()
                .setStyle(.btnFilledSemiMedium01)
                .setTitle("Both Image")
                .setTitleAlignment(.center)
                .setLeftImage(image)
                .setRightImage(image)
        }
    }
    
    @ViewBuilder
    private var largeButtonsContainer: some View {
        ButtonView().setStyle(.btnFilledLarge01).setTitle("btnFilledLarge01")
        ButtonView().setStyle(.btnFilledLarge02).setTitle("btnFilledLarge02")
        ButtonView().setStyle(.btnFilledLarge03).setTitle("btnFilledLarge03")
        ButtonView().setStyle(.btnFilledLarge04).setTitle("btnFilledLarge04")
        ButtonView().setStyle(.btnFilledLarge05).setTitle("btnFilledLarge05")
        ButtonView().setStyle(.btnFilledLarge06).setTitle("btnFilledLarge06")
        
        ButtonView().setStyle(.btnFilledRoundLarge01).setTitle("btnFilledRoundLarge01")
        ButtonView().setStyle(.btnFilledRoundLarge02).setTitle("btnFilledRoundLarge02")
        ButtonView().setStyle(.btnFilledRoundLarge03).setTitle("btnFilledRoundLarge03")
        ButtonView().setStyle(.btnFilledRoundLarge01).setTitle("btnFilledRoundLarge01")
        
        ButtonView().setStyle(.btnFilledTonalLarge01).setTitle("btnFilledTonalLarge01")
        ButtonView().setStyle(.btnFilledTonalLarge02).setTitle("btnFilledTonalLarge02")
        ButtonView().setStyle(.btnFilledTonalLarge03).setTitle("btnFilledTonalLarge03")
        ButtonView().setStyle(.btnFilledTonalLarge04).setTitle("btnFilledTonalLarge04")
        ButtonView().setStyle(.btnFilledTonalLarge05).setTitle("btnFilledTonalLarge05")
        ButtonView().setStyle(.btnFilledTonalLarge06).setTitle("btnFilledTonalLarge06")
        
        ButtonView().setStyle(.btnOutlineLarge01).setTitle("btnOutlineLarge01")
        ButtonView().setStyle(.btnOutlineLarge02).setTitle("btnOutlineLarge02")
        ButtonView().setStyle(.btnOutlineLarge03).setTitle("btnOutlineLarge03")
        ButtonView().setStyle(.btnOutlineLarge04).setTitle("btnOutlineLarge04")
        ButtonView().setStyle(.btnOutlineLarge05).setTitle("btnOutlineLarge05")
        ButtonView().setStyle(.btnOutlineLarge06).setTitle("btnOutlineLarge06")
        
        ButtonView().setStyle(.btnOutlineBgLarge01).setTitle("btnOutlineBgLarge01")
        ButtonView().setStyle(.btnOutlineBgLarge03).setTitle("btnOutlineBgLarge03")
        ButtonView().setStyle(.btnOutlineBgLarge04).setTitle("btnOutlineBgLarge04")
        ButtonView().setStyle(.btnOutlineBgLarge05).setTitle("btnOutlineBgLarge05")
        ButtonView().setStyle(.btnOutlineBgLarge06).setTitle("btnOutlineBgLarge06")
    
        ButtonView().setStyle(.btnTextLarge01).setTitle("btnTextLarge01")
        ButtonView().setStyle(.btnTextLarge02).setTitle("btnTextLarge02")
        ButtonView().setStyle(.btnTextLarge03).setTitle("btnTextLarge03")
        ButtonView().setStyle(.btnTextLarge04).setTitle("btnTextLarge04")
        ButtonView().setStyle(.btnTextLarge05).setTitle("btnTextLarge05")
        ButtonView().setStyle(.btnTextLarge06).setTitle("btnTextLarge06")
        ButtonView().setStyle(.btnTextLarge07).setTitle("btnTextLarge07")
    }
    
    @ViewBuilder
    private var mediumButtonsContainer: some View {
        ButtonView().setStyle(.btnFilledMedium01).setTitle("btnFilledMedium01")
        ButtonView().setStyle(.btnFilledMedium02).setTitle("btnFilledMedium02")
        ButtonView().setStyle(.btnFilledMedium03).setTitle("btnFilledMedium03")
        ButtonView().setStyle(.btnFilledMedium04).setTitle("btnFilledMedium04")
        ButtonView().setStyle(.btnFilledMedium05).setTitle("btnFilledMedium05")
        ButtonView().setStyle(.btnFilledMedium06).setTitle("btnFilledMedium06")
        
        ButtonView().setStyle(.btnFilledRoundMedium01).setTitle("btnFilledRoundMedium01")
        ButtonView().setStyle(.btnFilledRoundMedium02).setTitle("btnFilledRoundMedium02")
        ButtonView().setStyle(.btnFilledRoundMedium03).setTitle("btnFilledRoundMedium03")
        
        ButtonView().setStyle(.btnFilledTonalMedium01).setTitle("btnFilledTonalMedium01")
        ButtonView().setStyle(.btnFilledTonalMedium02).setTitle("btnFilledTonalMedium02")
        ButtonView().setStyle(.btnFilledTonalMedium03).setTitle("btnFilledTonalMedium03")
        ButtonView().setStyle(.btnFilledTonalMedium04).setTitle("btnFilledTonalMedium04")
        ButtonView().setStyle(.btnFilledTonalMedium05).setTitle("btnFilledTonalMedium05")
        ButtonView().setStyle(.btnFilledTonalMedium06).setTitle("btnFilledTonalMedium06")
        
        ButtonView().setStyle(.btnOutlineMedium01).setTitle("btnOutlineMedium01")
        ButtonView().setStyle(.btnOutlineMedium02).setTitle("btnOutlineMedium02")
        ButtonView().setStyle(.btnOutlineMedium03).setTitle("btnOutlineMedium03")
        ButtonView().setStyle(.btnOutlineMedium04).setTitle("btnOutlineMedium04")
        ButtonView().setStyle(.btnOutlineMedium05).setTitle("btnOutlineMedium05")
        ButtonView().setStyle(.btnOutlineMedium06).setTitle("btnOutlineMedium06")
        
        ButtonView().setStyle(.btnOutlineBgMedium01).setTitle("btnOutlineBgMedium01")
        ButtonView().setStyle(.btnOutlineBgMedium03).setTitle("btnOutlineBgMedium03")
        ButtonView().setStyle(.btnOutlineBgMedium04).setTitle("btnOutlineBgMedium04")
        ButtonView().setStyle(.btnOutlineBgMedium05).setTitle("btnOutlineBgMedium05")
        ButtonView().setStyle(.btnOutlineBgMedium06).setTitle("btnOutlineBgMedium06")
        
        ButtonView().setStyle(.btnTextMedium01).setTitle("btnTextMedium01")
        ButtonView().setStyle(.btnTextMedium02).setTitle("btnTextMedium02")
        ButtonView().setStyle(.btnTextMedium03).setTitle("btnTextMedium03")
        ButtonView().setStyle(.btnTextMedium04).setTitle("btnTextMedium04")
        ButtonView().setStyle(.btnTextMedium05).setTitle("btnTextMedium05")
        ButtonView().setStyle(.btnTextMedium06).setTitle("btnTextMedium06")
        ButtonView().setStyle(.btnTextMedium07).setTitle("btnTextMedium07")
    }
    
    @ViewBuilder
    private var semiMediumButtonsContainer: some View {
        ButtonView().setStyle(.btnFilledSemiMedium01).setTitle("btnFilledSemiMedium01")
        ButtonView().setStyle(.btnFilledSemiMedium02).setTitle("btnFilledSemiMedium02")
        ButtonView().setStyle(.btnFilledSemiMedium03).setTitle("btnFilledSemiMedium03")
        ButtonView().setStyle(.btnFilledSemiMedium04).setTitle("btnFilledSemiMedium04")
        ButtonView().setStyle(.btnFilledSemiMedium05).setTitle("btnFilledSemiMedium05")
        ButtonView().setStyle(.btnFilledSemiMedium06).setTitle("btnFilledSemiMedium06")
            
        ButtonView().setStyle(.btnFilledRoundSemiMedium01).setTitle("btnFilledRoundSemiMedium01")
        ButtonView().setStyle(.btnFilledRoundSemiMedium02).setTitle("btnFilledRoundSemiMedium02")
        ButtonView().setStyle(.btnFilledRoundSemiMedium03).setTitle("btnFilledRoundSemiMedium03")
            
        ButtonView().setStyle(.btnFilledTonalSemiMedium01).setTitle("btnFilledTonalSemiMedium01")
        ButtonView().setStyle(.btnFilledTonalSemiMedium02).setTitle("btnFilledTonalSemiMedium02")
        ButtonView().setStyle(.btnFilledTonalSemiMedium03).setTitle("btnFilledTonalSemiMedium03")
        ButtonView().setStyle(.btnFilledTonalSemiMedium04).setTitle("btnFilledTonalSemiMedium04")
        ButtonView().setStyle(.btnFilledTonalSemiMedium05).setTitle("btnFilledTonalSemiMedium05")
        ButtonView().setStyle(.btnFilledTonalSemiMedium06).setTitle("btnFilledTonalSemiMedium06")
            
        ButtonView().setStyle(.btnOutlineSemiMedium01).setTitle("btnOutlineSemiMedium01")
        ButtonView().setStyle(.btnOutlineSemiMedium02).setTitle("btnOutlineSemiMedium02")
        ButtonView().setStyle(.btnOutlineSemiMedium03).setTitle("btnOutlineSemiMedium03")
        ButtonView().setStyle(.btnOutlineSemiMedium04).setTitle("btnOutlineSemiMedium04")
        ButtonView().setStyle(.btnOutlineSemiMedium05).setTitle("btnOutlineSemiMedium05")
        ButtonView().setStyle(.btnOutlineSemiMedium06).setTitle("btnOutlineSemiMedium06")
            
        ButtonView().setStyle(.btnOutlineBgSemiMedium01).setTitle("btnOutlineBgSemiMedium01")
        ButtonView().setStyle(.btnOutlineBgSemiMedium03).setTitle("btnOutlineBgSemiMedium03")
        ButtonView().setStyle(.btnOutlineBgSemiMedium04).setTitle("btnOutlineBgSemiMedium04")
        ButtonView().setStyle(.btnOutlineBgSemiMedium05).setTitle("btnOutlineBgSemiMedium05")
        ButtonView().setStyle(.btnOutlineBgSemiMedium06).setTitle("btnOutlineBgSemiMedium06")
            
        ButtonView().setStyle(.btnTextSemiMedium01).setTitle("btnTextSemiMedium01")
        ButtonView().setStyle(.btnTextSemiMedium02).setTitle("btnTextSemiMedium02")
        ButtonView().setStyle(.btnTextSemiMedium03).setTitle("btnTextSemiMedium03")
        ButtonView().setStyle(.btnTextSemiMedium04).setTitle("btnTextSemiMedium04")
        ButtonView().setStyle(.btnTextSemiMedium05).setTitle("btnTextSemiMedium05")
        ButtonView().setStyle(.btnTextSemiMedium06).setTitle("btnTextSemiMedium06")
        ButtonView().setStyle(.btnTextSemiMedium07).setTitle("btnTextSemiMedium07")
    }
    
    @ViewBuilder
    private var smallButtonsContainer: some View {
        ButtonView().setStyle(.btnFilledSmall01).setTitle("btnFilledSmall01")
        ButtonView().setStyle(.btnFilledSmall02).setTitle("btnFilledSmall02")
        ButtonView().setStyle(.btnFilledSmall03).setTitle("btnFilledSmall03")
        ButtonView().setStyle(.btnFilledSmall04).setTitle("btnFilledSmall04")
        ButtonView().setStyle(.btnFilledSmall05).setTitle("btnFilledSmall05")
        ButtonView().setStyle(.btnFilledSmall06).setTitle("btnFilledSmall06")
            
        ButtonView().setStyle(.btnFilledRoundSmall01).setTitle("btnFilledRoundSmall01")
        ButtonView().setStyle(.btnFilledRoundSmall02).setTitle("btnFilledRoundSmall02")
        ButtonView().setStyle(.btnFilledRoundSmall03).setTitle("btnFilledRoundSmall03")
            
        ButtonView().setStyle(.btnFilledTonalSmall01).setTitle("btnFilledTonalSmall01")
        ButtonView().setStyle(.btnFilledTonalSmall02).setTitle("btnFilledTonalSmall02")
        ButtonView().setStyle(.btnFilledTonalSmall03).setTitle("btnFilledTonalSmall03")
        ButtonView().setStyle(.btnFilledTonalSmall04).setTitle("btnFilledTonalSmall04")
        ButtonView().setStyle(.btnFilledTonalSmall05).setTitle("btnFilledTonalSmall05")
        ButtonView().setStyle(.btnFilledTonalSmall06).setTitle("btnFilledTonalSmall06")
            
        ButtonView().setStyle(.btnOutlineSmall01).setTitle("btnOutlineSmall01")
        ButtonView().setStyle(.btnOutlineSmall02).setTitle("btnOutlineSmall02")
        ButtonView().setStyle(.btnOutlineSmall03).setTitle("btnOutlineSmall03")
        ButtonView().setStyle(.btnOutlineSmall04).setTitle("btnOutlineSmall04")
        ButtonView().setStyle(.btnOutlineSmall05).setTitle("btnOutlineSmall05")
        ButtonView().setStyle(.btnOutlineSmall06).setTitle("btnOutlineSmall06")
            
        ButtonView().setStyle(.btnOutlineBgSmall01).setTitle("btnOutlineBgSmall01")
        ButtonView().setStyle(.btnOutlineBgSmall03).setTitle("btnOutlineBgSmall03")
        ButtonView().setStyle(.btnOutlineBgSmall04).setTitle("btnOutlineBgSmall04")
        ButtonView().setStyle(.btnOutlineBgSmall05).setTitle("btnOutlineBgSmall05")
        ButtonView().setStyle(.btnOutlineBgSmall06).setTitle("btnOutlineBgSmall06")
            
        ButtonView().setStyle(.btnTextSmall01).setTitle("btnTextSmall01")
        ButtonView().setStyle(.btnTextSmall02).setTitle("btnTextSmall02")
        ButtonView().setStyle(.btnTextSmall03).setTitle("btnTextSmall03")
        ButtonView().setStyle(.btnTextSmall04).setTitle("btnTextSmall04")
        ButtonView().setStyle(.btnTextSmall05).setTitle("btnTextSmall05")
        ButtonView().setStyle(.btnTextSmall06).setTitle("btnTextSmall06")
        ButtonView().setStyle(.btnTextSmall07).setTitle("btnTextSmall07")
    }
}

#Preview {
    ButtonTestView()
}

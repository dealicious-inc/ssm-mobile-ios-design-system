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
                    
                    largeButtonsContainer.fixedSize(horizontal: true, vertical: false)
                    mediumButtonsContainer.fixedSize(horizontal: true, vertical: false)
                    semiMediumButtonsContainer.fixedSize(horizontal: true, vertical: false)
                    smallButtonsContainer.fixedSize(horizontal: true, vertical: false)
                    
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
            let loadingButtonViewModel = ButtonViewModel(type: .btnFilledLarge01,
                                                         title: "setLoading",
                                                         isLoading: false)
            ButtonView(viewModel: loadingButtonViewModel)
            
            let loadingOn = ButtonViewModel(type: .btnOutlineBgLarge01,
                                            title: "On")
            ButtonView(viewModel: loadingOn) {
                loadingButtonViewModel.isLoading = true
            }
            
            let loadingOff = ButtonViewModel(type: .btnOutlineBgLarge01,
                                             title: "Off")
            ButtonView(viewModel: loadingOff) {
                loadingButtonViewModel.isLoading = false
            }
        }
    }
    
    @ViewBuilder
    private var enabledContainer: some View {
        HStack(spacing: 10) {
            let enabledViewModel = ButtonViewModel(type: .btnFilledLarge01,
                                                   title: "isEnabled True",
                                                   isEnabled: true)
            ButtonView(viewModel: enabledViewModel)
            
            let enabled = ButtonViewModel(type: .btnOutlineBgLarge01,
                                                            title: "Enabled")
            ButtonView(viewModel: enabled) {
                enabledViewModel.isEnabled = true
                enabledViewModel.title = "isEnabled True"
            }
            
            let disabled = ButtonViewModel(type: .btnOutlineBgLarge01,
                                                            title: "Disabled")
            ButtonView(viewModel: disabled) {
                enabledViewModel.isEnabled = false
                enabledViewModel.title = "isEnabled False"
            }
        }
    }
    
    @ViewBuilder
    private var imageContainer: some View {
        let image = UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 16.0, height: 16.0))
        
        HStack(spacing: 10) {
            ButtonView(type: .btnFilledLarge01,
                       title: "Left Image",
                       leftImage: ClickableImage(image))
            
            ButtonView(type: .btnFilledLarge01,
                       title: "Right Image",
                       rightImage: ClickableImage(image))
            
            
            ButtonView(type: .btnFilledLarge01,
                       title: "Both Image",
                       leftImage: ClickableImage(image),
                       rightImage: ClickableImage(image))
        }
    }
    
    @ViewBuilder
    private var largeButtonsContainer: some View {
        VStack(spacing: 8) {
            ButtonView(type: .btnFilledLarge01, title: "btnFilledLarge01")
            ButtonView(type: .btnFilledLarge02, title: "btnFilledLarge02")
            ButtonView(type: .btnFilledLarge03, title: "btnFilledLarge03")
            ButtonView(type: .btnFilledLarge04, title: "btnFilledLarge04")
            ButtonView(type: .btnFilledLarge05, title: "btnFilledLarge05")
            ButtonView(type: .btnFilledLarge06, title: "btnFilledLarge06")

            ButtonView(type: .btnFilledRoundLarge01, title: "btnFilledRoundLarge01")
            ButtonView(type: .btnFilledRoundLarge02, title: "btnFilledRoundLarge02")
            ButtonView(type: .btnFilledRoundLarge03, title: "btnFilledRoundLarge03")

            ButtonView(type: .btnFilledTonalLarge01, title: "btnFilledTonalLarge01")
            ButtonView(type: .btnFilledTonalLarge02, title: "btnFilledTonalLarge02")
            ButtonView(type: .btnFilledTonalLarge03, title: "btnFilledTonalLarge03")
            ButtonView(type: .btnFilledTonalLarge04, title: "btnFilledTonalLarge04")
            ButtonView(type: .btnFilledTonalLarge05, title: "btnFilledTonalLarge05")
            ButtonView(type: .btnFilledTonalLarge06, title: "btnFilledTonalLarge06")

            ButtonView(type: .btnOutlineLarge01, title: "btnOutlineLarge01")
            ButtonView(type: .btnOutlineLarge02, title: "btnOutlineLarge02")
            ButtonView(type: .btnOutlineLarge03, title: "btnOutlineLarge03")
            ButtonView(type: .btnOutlineLarge04, title: "btnOutlineLarge04")
            ButtonView(type: .btnOutlineLarge05, title: "btnOutlineLarge05")
            ButtonView(type: .btnOutlineLarge06, title: "btnOutlineLarge06")

            ButtonView(type: .btnOutlineBgLarge01, title: "btnOutlineBgLarge01")
            ButtonView(type: .btnOutlineBgLarge03, title: "btnOutlineBgLarge03")
            ButtonView(type: .btnOutlineBgLarge04, title: "btnOutlineBgLarge04")
            ButtonView(type: .btnOutlineBgLarge05, title: "btnOutlineBgLarge05")
            ButtonView(type: .btnOutlineBgLarge06, title: "btnOutlineBgLarge06")

            ButtonView(type: .btnTextLarge01, title: "btnTextLarge01")
            ButtonView(type: .btnTextLarge02, title: "btnTextLarge02")
            ButtonView(type: .btnTextLarge03, title: "btnTextLarge03")
            ButtonView(type: .btnTextLarge04, title: "btnTextLarge04")
            ButtonView(type: .btnTextLarge05, title: "btnTextLarge05")
            ButtonView(type: .btnTextLarge06, title: "btnTextLarge06")
            ButtonView(type: .btnTextLarge07, title: "btnTextLarge07")
        }
    }
    
    @ViewBuilder
    private var mediumButtonsContainer: some View {
        VStack(spacing: 8) {
            ButtonView(type: .btnFilledMedium01, title: "btnFilledMedium01")
            ButtonView(type: .btnFilledMedium02, title: "btnFilledMedium02")
            ButtonView(type: .btnFilledMedium03, title: "btnFilledMedium03")
            ButtonView(type: .btnFilledMedium04, title: "btnFilledMedium04")
            ButtonView(type: .btnFilledMedium05, title: "btnFilledMedium05")
            ButtonView(type: .btnFilledMedium06, title: "btnFilledMedium06")

            ButtonView(type: .btnFilledRoundMedium01, title: "btnFilledRoundMedium01")
            ButtonView(type: .btnFilledRoundMedium02, title: "btnFilledRoundMedium02")
            ButtonView(type: .btnFilledRoundMedium03, title: "btnFilledRoundMedium03")
            
            ButtonView(type: .btnFilledTonalMedium01, title: "btnFilledTonalMedium01")
            ButtonView(type: .btnFilledTonalMedium02, title: "btnFilledTonalMedium02")
            ButtonView(type: .btnFilledTonalMedium03, title: "btnFilledTonalMedium03")
            ButtonView(type: .btnFilledTonalMedium04, title: "btnFilledTonalMedium04")
            ButtonView(type: .btnFilledTonalMedium05, title: "btnFilledTonalMedium05")
            ButtonView(type: .btnFilledTonalMedium06, title: "btnFilledTonalMedium06")

            ButtonView(type: .btnOutlineMedium01, title: "btnOutlineMedium01")
            ButtonView(type: .btnOutlineMedium02, title: "btnOutlineMedium02")
            ButtonView(type: .btnOutlineMedium03, title: "btnOutlineMedium03")
            ButtonView(type: .btnOutlineMedium04, title: "btnOutlineMedium04")
            ButtonView(type: .btnOutlineMedium05, title: "btnOutlineMedium05")
            ButtonView(type: .btnOutlineMedium06, title: "btnOutlineMedium06")

            ButtonView(type: .btnOutlineBgMedium01, title: "btnOutlineBgMedium01")
            ButtonView(type: .btnOutlineBgMedium03, title: "btnOutlineBgMedium03")
            ButtonView(type: .btnOutlineBgMedium04, title: "btnOutlineBgMedium04")
            ButtonView(type: .btnOutlineBgMedium05, title: "btnOutlineBgMedium05")
            ButtonView(type: .btnOutlineBgMedium06, title: "btnOutlineBgMedium06")

            ButtonView(type: .btnTextMedium01, title: "btnTextMedium01")
            ButtonView(type: .btnTextMedium02, title: "btnTextMedium02")
            ButtonView(type: .btnTextMedium03, title: "btnTextMedium03")
            ButtonView(type: .btnTextMedium04, title: "btnTextMedium04")
            ButtonView(type: .btnTextMedium05, title: "btnTextMedium05")
            ButtonView(type: .btnTextMedium06, title: "btnTextMedium06")
            ButtonView(type: .btnTextMedium07, title: "btnTextMedium07")
        }
    }
    
    @ViewBuilder
    private var semiMediumButtonsContainer: some View {
        VStack(spacing: 8) {
            ButtonView(type: .btnFilledSemiMedium01, title: "btnFilledSemiMedium01")
            ButtonView(type: .btnFilledSemiMedium02, title: "btnFilledSemiMedium02")
            ButtonView(type: .btnFilledSemiMedium03, title: "btnFilledSemiMedium03")
            ButtonView(type: .btnFilledSemiMedium04, title: "btnFilledSemiMedium04")
            ButtonView(type: .btnFilledSemiMedium05, title: "btnFilledSemiMedium05")
            ButtonView(type: .btnFilledSemiMedium06, title: "btnFilledSemiMedium06")
            
            ButtonView(type: .btnFilledRoundSemiMedium01, title: "btnFilledRoundSemiMedium01")
            ButtonView(type: .btnFilledRoundSemiMedium02, title: "btnFilledRoundSemiMedium02")
            ButtonView(type: .btnFilledRoundSemiMedium03, title: "btnFilledRoundSemiMedium03")
            ButtonView(type: .btnFilledTonalSemiMedium01, title: "btnFilledTonalSemiMedium01")
            ButtonView(type: .btnFilledTonalSemiMedium02, title: "btnFilledTonalSemiMedium02")
            ButtonView(type: .btnFilledTonalSemiMedium03, title: "btnFilledTonalSemiMedium03")
            ButtonView(type: .btnFilledTonalSemiMedium04, title: "btnFilledTonalSemiMedium04")
            ButtonView(type: .btnFilledTonalSemiMedium05, title: "btnFilledTonalSemiMedium05")
            ButtonView(type: .btnFilledTonalSemiMedium06, title: "btnFilledTonalSemiMedium06")
            
            ButtonView(type: .btnOutlineSemiMedium01, title: "btnOutlineSemiMedium01")
            ButtonView(type: .btnOutlineSemiMedium02, title: "btnOutlineSemiMedium02")
            ButtonView(type: .btnOutlineSemiMedium03, title: "btnOutlineSemiMedium03")
            ButtonView(type: .btnOutlineSemiMedium04, title: "btnOutlineSemiMedium04")
            ButtonView(type: .btnOutlineSemiMedium05, title: "btnOutlineSemiMedium05")
            ButtonView(type: .btnOutlineSemiMedium06, title: "btnOutlineSemiMedium06")
            
            ButtonView(type: .btnOutlineBgSemiMedium01, title: "btnOutlineBgSemiMedium01")
            ButtonView(type: .btnOutlineBgSemiMedium03, title: "btnOutlineBgSemiMedium03")
            ButtonView(type: .btnOutlineBgSemiMedium04, title: "btnOutlineBgSemiMedium04")
            ButtonView(type: .btnOutlineBgSemiMedium05, title: "btnOutlineBgSemiMedium05")
            ButtonView(type: .btnOutlineBgSemiMedium06, title: "btnOutlineBgSemiMedium06")
            
            ButtonView(type: .btnTextSemiMedium01, title: "btnTextSemiMedium01")
            ButtonView(type: .btnTextSemiMedium02, title: "btnTextSemiMedium02")
            ButtonView(type: .btnTextSemiMedium03, title: "btnTextSemiMedium03")
            ButtonView(type: .btnTextSemiMedium04, title: "btnTextSemiMedium04")
            ButtonView(type: .btnTextSemiMedium05, title: "btnTextSemiMedium05")
            ButtonView(type: .btnTextSemiMedium06, title: "btnTextSemiMedium06")
            ButtonView(type: .btnTextSemiMedium07, title: "btnTextSemiMedium07")
        }
    }
    
    @ViewBuilder
    private var smallButtonsContainer: some View {
        VStack(spacing: 8) {
            ButtonView(type: .btnFilledSmall01, title: "btnFilledSmall01")
            ButtonView(type: .btnFilledSmall02, title: "btnFilledSmall02")
            ButtonView(type: .btnFilledSmall03, title: "btnFilledSmall03")
            ButtonView(type: .btnFilledSmall04, title: "btnFilledSmall04")
            ButtonView(type: .btnFilledSmall05, title: "btnFilledSmall05")
            ButtonView(type: .btnFilledSmall06, title: "btnFilledSmall06")
            
            ButtonView(type: .btnFilledRoundSmall01, title: "btnFilledRoundSmall01")
            ButtonView(type: .btnFilledRoundSmall02, title: "btnFilledRoundSmall02")
            ButtonView(type: .btnFilledRoundSmall03, title: "btnFilledRoundSmall03")
            ButtonView(type: .btnFilledTonalSmall01, title: "btnFilledTonalSmall01")
            ButtonView(type: .btnFilledTonalSmall02, title: "btnFilledTonalSmall02")
            ButtonView(type: .btnFilledTonalSmall03, title: "btnFilledTonalSmall03")
            ButtonView(type: .btnFilledTonalSmall04, title: "btnFilledTonalSmall04")
            ButtonView(type: .btnFilledTonalSmall05, title: "btnFilledTonalSmall05")
            ButtonView(type: .btnFilledTonalSmall06, title: "btnFilledTonalSmall06")
            
            ButtonView(type: .btnOutlineSmall01, title: "btnOutlineSmall01")
            ButtonView(type: .btnOutlineSmall02, title: "btnOutlineSmall02")
            ButtonView(type: .btnOutlineSmall03, title: "btnOutlineSmall03")
            ButtonView(type: .btnOutlineSmall04, title: "btnOutlineSmall04")
            ButtonView(type: .btnOutlineSmall05, title: "btnOutlineSmall05")
            ButtonView(type: .btnOutlineSmall06, title: "btnOutlineSmall06")
            
            ButtonView(type: .btnOutlineBgSmall01, title: "btnOutlineBgSmall01")
            ButtonView(type: .btnOutlineBgSmall03, title: "btnOutlineBgSmall03")
            ButtonView(type: .btnOutlineBgSmall04, title: "btnOutlineBgSmall04")
            ButtonView(type: .btnOutlineBgSmall05, title: "btnOutlineBgSmall05")
            ButtonView(type: .btnOutlineBgSmall06, title: "btnOutlineBgSmall06")
            
            ButtonView(type: .btnTextSmall01, title: "btnTextSmall01")
            ButtonView(type: .btnTextSmall02, title: "btnTextSmall02")
            ButtonView(type: .btnTextSmall03, title: "btnTextSmall03")
            ButtonView(type: .btnTextSmall04, title: "btnTextSmall04")
            ButtonView(type: .btnTextSmall05, title: "btnTextSmall05")
            ButtonView(type: .btnTextSmall06, title: "btnTextSmall06")
            ButtonView(type: .btnTextSmall07, title: "btnTextSmall07")
        }
    }
}

#Preview {
    ButtonTestView()
}

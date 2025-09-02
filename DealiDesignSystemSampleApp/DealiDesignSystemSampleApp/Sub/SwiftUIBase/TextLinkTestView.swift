//
//  TextLinkTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by Lee Chang Ho on 3/28/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct TextLinkTestView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    textLinkLarge
                    Divider()
                    textLinkLineLarge
                    Divider()
                    textLinkMedium
                    Divider()
                    textLinkLineMedium
                    Divider()
                    textLinkSmall
                    Divider()
                    textLinkLineSmall
                }
                .padding(EdgeInsets(top: 16.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .g30))
        }.navigationBarTitle("Text Link", displayMode: .inline)
    }
    
    @ViewBuilder
    private var textLinkLarge: some View {
        VStack(spacing: 10) {
            Text("-- TextLinkLarge List --")
                .fontWeight(.bold)
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge01)
                    .addAction {
                        print("textLinkLarge01 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge01)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge02)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLarge02 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge02)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge03)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLarge03 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge03)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge04)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLarge04 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge04)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge05)
                    .addAction {
                        print("textLinkLarge05 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge05)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLarge06 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLarge07)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLarge07 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLarge07)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
        }
    }
    
    @ViewBuilder
    private var textLinkLineLarge: some View {
        VStack(spacing: 10) {
            Text("-- TextLinkLineLarge List --")
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineLarge01 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge02)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLineLarge02 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge02)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge03)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineLarge03 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge03)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge04)
                    .addAction {
                        print("textLinkLineLarge04 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge04)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge05)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineLarge05 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge05)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge06)
                    .addAction {
                        print("textLinkLineLarge06 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge06)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLineLarge07 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineLarge07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
        }
    }
    
    @ViewBuilder
    private var textLinkMedium: some View {
        VStack(spacing: 10) {
            Text("-- TextLinkMedium List --")
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkMedium01 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium02)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkMedium02 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium02)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium03)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkMedium03 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium03)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium04)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkMedium04 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium04)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium05)
                    .addAction {
                        print("textLinkMedium05 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium05)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkMedium06 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkMedium07)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkMedium07 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkMedium07)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
        }
    }
    
    @ViewBuilder
    private var textLinkLineMedium: some View {
        VStack(spacing: 10) {
            Text("-- TextLinkLineMedium List --")
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium01)
                    .addAction {
                        print("textLinkLineMedium01 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium01)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium02)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineMedium02 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium02)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium03)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineMedium03 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium03)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium04)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLineMedium04 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium04)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium05)
                    .addAction {
                        print("textLinkLineMedium05 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium05)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineMedium06 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLineMedium07 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineMedium07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
        }
    }
    
    @ViewBuilder
    private var textLinkSmall: some View {
        VStack(spacing: 10) {
            Text("-- TextLinkSmall List --")
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkSmall01 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall02)
                    .addAction {
                        print("textLinkSmall02 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall02)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall03)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkSmall03 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall03)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall04)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkSmall04 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall04)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall05)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkSmall05 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall05)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall06)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkSmall06 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall06)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkSmall07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkSmall07 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkSmall07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
        }
    }
    
    @ViewBuilder
    private var textLinkLineSmall: some View {
        VStack(spacing: 10) {
            Text("-- TextLinkLineSmall List --")
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineSmall01 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall01)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall02)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineSmall02 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall02)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall03)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLineSmall03 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall03)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall04)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineSmall04 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall04)
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall05)
                    .addAction {
                        print("textLinkLineSmall05 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall05)
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .addAction {
                        print("textLinkLineSmall06 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall06)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .status(.disabled)
            }
            
            HStack(spacing: 40) {
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .addAction {
                        print("textLinkLineSmall07 Click Action")
                    }
                
                TextLinkView()
                    .setConfigStyle(.textLinkLineSmall07)
                    .leftImage(.dealiIcon(named: "ic_info"))
                    .rightImage(.dealiIcon(named: "ic_check_s"))
                    .status(.disabled)
            }
        }
    }
}

#Preview {
    TextLinkTestView()
}

//
//  ColorView.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 10/21/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import SwiftUI

struct ColorView: View {
    var columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
    ]
    
    let sections = [
        ColorFamilyData(
            name: "Primary",
            varients: [
                ColorData(name: "primary01", color: UIColor.primary01.asColor()),
                ColorData(name: "primary02", color: UIColor.primary02.asColor()),
                ColorData(name: "primary03", color: UIColor.primary03.asColor(), isDarkShade: false),
                ColorData(name: "primary04", color: UIColor.primary04.asColor(), isDarkShade: false),
                ColorData(name: "primary05", color: UIColor.primary05.asColor()),
            ]
        ),
        ColorFamilyData(
            name: "Secondary",
            varients: [
                ColorData(name: "secondary01", color: UIColor.secondary01.asColor()),
                ColorData(name: "secondary02", color: UIColor.secondary02.asColor()),
                ColorData(name: "secondary03", color: UIColor.secondary03.asColor(), isDarkShade: false),
                ColorData(name: "secondary04", color: UIColor.secondary04.asColor()),
                ColorData(name: "secondary05", color: UIColor.secondary05.asColor()),
                ColorData(name: "secondary06", color: UIColor.secondary06.asColor(), isDarkShade: false),
            ]
        ),

        ColorFamilyData(
            name: "Gray",
            varients: [
                ColorData(name: "g100", color: UIColor.g100.asColor()),
                ColorData(name: "g80", color: UIColor.g80.asColor()),
                ColorData(name: "g70", color: UIColor.g70.asColor()),
                ColorData(name: "g60", color: UIColor.g60.asColor(), isDarkShade: false),
                ColorData(name: "g50", color: UIColor.g50.asColor(), isDarkShade: false),
                ColorData(name: "g40", color: UIColor.g40.asColor(), isDarkShade: false),
                ColorData(name: "g30", color: UIColor.g30.asColor(), isDarkShade: false),
                ColorData(name: "g20", color: UIColor.g20.asColor(), isDarkShade: false),
                ColorData(name: "g10", color: UIColor.g10.asColor(), isDarkShade: false),
                ColorData(name: "g05", color: UIColor.g05.asColor(), isDarkShade: false),
            ]
        ),
        
        ColorFamilyData(
            name: "Service",
            varients: [
                ColorData(name: "error", color: UIColor.error.asColor()),
                ColorData(name: "warning", color: UIColor.warning.asColor()),
                ColorData(name: "linkAndInfo", color: UIColor.linkAndInfo.asColor()),
                ColorData(name: "success", color: UIColor.success.asColor()),

            ]
        ),
        
        ColorFamilyData(
            name: "Etc",
            varients: [
                ColorData(name: "b70", color: UIColor.b70.asColor()),
                ColorData(name: "b50", color: UIColor.b50.asColor()),
                ColorData(name: "b40", color: UIColor.b40.asColor()),
                ColorData(name: "b30", color: UIColor.b30.asColor()),
                ColorData(name: "b20", color: UIColor.b20.asColor()),
                ColorData(name: "b10", color: UIColor.b10.asColor()),
                ColorData(name: "b5", color: UIColor.b5.asColor()),
                ColorData(name: "w90", color: UIColor.w90.asColor(), isDarkShade: false),
                ColorData(name: "w70", color: UIColor.w70.asColor(), isDarkShade: false),
                ColorData(name: "w50", color: UIColor.w50.asColor(), isDarkShade: false),
                ColorData(name: "w30", color: UIColor.w30.asColor(), isDarkShade: false),
                ColorData(name: "w20", color: UIColor.w20.asColor(), isDarkShade: false),
                ColorData(name: "w15", color: UIColor.w15.asColor(), isDarkShade: false),
                ColorData(name: "w10", color: UIColor.w10.asColor(), isDarkShade: false),
                ColorData(name: "w5", color: UIColor.w5.asColor(), isDarkShade: false),

            ]
        ),
    ]
                 
    var body: some View {
        ZStack {
            Color(uiColor: .systemFill)
                .ignoresSafeArea(edges: .all)
            
            ScrollView {
                LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                    ForEach(sections, id: \.id) { section in
                        
                        Section(header: sectionHeader(colorFamily: section)) {
                            ForEach(section.varients, id: \.id) { color in
                                ColorItemView(colorData: color)
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        
    }
    
    func sectionHeader(colorFamily: ColorFamilyData) -> some View {
        Text(colorFamily.name)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
}

struct ColorFamilyData: Identifiable {
    let id: UUID = UUID()
    let name: String
    let varients: [ColorData]
}

#Preview {
    ColorView()
}

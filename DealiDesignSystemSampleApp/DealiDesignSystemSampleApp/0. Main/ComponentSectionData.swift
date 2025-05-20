//
//  SectionData.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/10/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit

struct ComponentSectionData: Hashable {
    let title: String?
    let items: [ItemData]
    
    init(title: String?, items: [ItemData]) {
        self.title = title
        self.items = items
    }
    
}

struct ItemData: Hashable {
    var title: String?
    var type: ActionType = .color
    
}

enum ActionType: Hashable {
    // MARK: - Token
    case typography
    case color
    case font
    
    // MARK: - Atom
    case accordion
    case badge
    case button
    case checkbox
    case chip
    case dropdown
    case imageChip
    case indicator
    case labeledText
    case placeholder
    case radioButton
    case searchInput
    case sliderBar
    case dealiSwitch
    case tag
    case textArea
    case textInput
    case textLink
    case toolTip
    
    // MARK: - Molecule
    case alert
    case bottomSheet
    case empty
    case notice
    case tabBar
    
}

extension ItemData {
    @MainActor
    var nextVC: UIViewController {
        switch self.type {
        case .color:
            ColorViewController()
        case .typography:
            TypographyViewController()
        case .font:
            FontComponentViewController()
            
        case .accordion:
            AccordionComponentViewController()
        case .badge:
            BadgeViewController()
        case .button:
            ButtonViewController()
        case .checkbox:
            CheckComponentViewController()
        case .chip:
            ChipViewController()
        case .dropdown:
            DropdownViewController()
        case .imageChip:
            ImageChipViewController()
        case .indicator:
            IndicatorViewController()
        case .labeledText:
            LabeledTextComponentViewController()
        case .placeholder:
            PlaceholderImageViewController()
        case .radioButton:
            RadioButtonViewController()
        case .searchInput:
            SearchInputViewController()
        case .sliderBar:
            SliderBarViewController()
        case .dealiSwitch:
            SwitchViewController()
        case .tag:
            TagViewController()
        case .textArea:
            TextAreaViewController()
        case .textInput:
            TextInputViewController()
        case .textLink:
            TextLinkViewController()
        case .toolTip:
            ToolTipViewController()
            
        case .alert:
            AlertTestViewController()
        case .bottomSheet:
            BottomSheetPopupTestViewController()
        case .empty:
            EmptyComponentViewController()
        case .notice:
            NoticeViewController()
        case .tabBar:
            TabBarViewController()
        }
    }
}

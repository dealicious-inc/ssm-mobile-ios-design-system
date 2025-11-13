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
    var isSwiftUI: Bool = false
}

enum ActionType: Hashable, CaseIterable {
    enum Group {
            case token
            case atom
            case molecule
            case etc
        }
    
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
    case countStepper
    case toast
    
    // MARK: - Molecule
    case alert
    case bottomSheet
    case empty
    case notice
    case tabBar
    
    // MARK: - etc
    case linkLabel
    
    var group: Group {
            switch self {
            case .typography, .color, .font:
                return .token
            case .accordion, .badge, .button, .checkbox, .chip, .dropdown,
                 .imageChip, .indicator, .labeledText, .placeholder,
                 .radioButton, .searchInput, .sliderBar, .dealiSwitch,
                 .tag, .textArea, .textInput, .textLink, .toolTip,
                 .countStepper, .toast:
                return .atom
            case .alert, .bottomSheet, .empty, .notice, .tabBar:
                return .molecule
            case .linkLabel:
                return .etc
            }
        }
    
    var hasSwiftUISample: Bool {
        switch self {
        case  .typography,
                .button, .searchInput, .checkbox,.imageChip, .chip, .tag, .dropdown,
                .alert, .empty, .tabBar, .toast:
            return true
        default:
            return false
        }
    }
    
    var title: String {
        switch self {
        case .typography: return "Typography"
        case .color: return "Color"
        case .font: return "Font"
          
        case .accordion: return "Accordion"
        case .badge: return "Badge"
        case .button: return "Button"
        case .checkbox: return "Checkbox"
        case .chip: return "Chip"
        case .dropdown: return "Dropdown"
        case .imageChip: return "ImageChip"
        case .indicator: return "Indicator"
        case .labeledText: return "LabeledText"
        case .placeholder: return "Placeholder"
        case .radioButton: return "RadioButton"
        case .searchInput: return "SearchInput"
        case .sliderBar: return "SliderBar"
        case .dealiSwitch: return "DealiSwitch"
        case .tag: return "Tag"
        case .textArea: return "TextArea"
        case .textInput: return "TextInput"
        case .textLink: return "TextLink"
        case .toolTip: return "ToolTip"
        case .countStepper: return "CountStepper"
        case .toast: return "Toast"
            
        case .alert: return "Alert"
        case .bottomSheet: return "BottomSheet"
        case .empty: return "Empty"
        case .notice: return "Notice"
        case .tabBar: return "TabBar"
        case .linkLabel: return "LinkLabel"
        }
    }
}

extension ItemData {
    @MainActor
    var nextVC: UIViewController {
        switch self.type {
        case .color:
            ColorViewController()
        case .typography:
            TypographyViewController(isSwiftUI: isSwiftUI)
        case .font:
            FontComponentViewController()
            
        case .accordion:
            AccordionComponentViewController()
        case .badge:
            BadgeViewController()
        case .button:
            ButtonViewController(isSwiftUI: isSwiftUI)
        case .checkbox:
            CheckComponentViewController(isSwiftUI: isSwiftUI)
        case .chip:
            ChipViewController(isSwiftUI: isSwiftUI)
        case .dropdown:
            DropdownViewController(isSwiftUI: isSwiftUI)
        case .imageChip:
            ImageChipViewController(isSwiftUI: isSwiftUI)
        case .indicator:
            IndicatorViewController()
        case .labeledText:
            LabeledTextComponentViewController()
        case .placeholder:
            PlaceholderImageViewController()
        case .radioButton:
            RadioButtonViewController()
        case .searchInput:
            SearchInputViewController(isSwiftUI: isSwiftUI)
        case .sliderBar:
            SliderBarViewController()
        case .dealiSwitch:
            SwitchViewController()
        case .tag:
            TagViewController(isSwiftUI: isSwiftUI)
        case .textArea:
            TextAreaViewController()
        case .textInput:
            TextInputViewController()
        case .textLink:
            TextLinkViewController()
        case .toolTip:
            ToolTipViewController(isSwiftUI: isSwiftUI)
        case .countStepper:
            CountStepperViewController()
        case .toast:
            ToastViewController() //Only SwiftUI
            
        case .alert:
            AlertTestViewController(isSwiftUI: isSwiftUI)
        case .bottomSheet:
            BottomSheetPopupTestViewController()
        case .empty:
            if type.hasSwiftUISample {
                EmptyViewController(isSwiftUI: true)
            } else {
                EmptyComponentViewController()
            }
        case .notice:
            NoticeViewController()
        case .tabBar:
            TabBarViewController(isSwiftUI: isSwiftUI)
            
        case .linkLabel:
            LinkLabelViewController()
        }
    }
}

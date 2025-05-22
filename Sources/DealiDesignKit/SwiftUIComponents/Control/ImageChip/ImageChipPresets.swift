//
//  ImageChipPresets.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/20/25.
//

import Foundation
import SwiftUI

// MARK: - Enums

enum DLChipVariant: CaseIterable {
    case filled, outline
}

enum DLChipSize: CaseIterable {
    case small, medium, large
}

// MARK: - Style Model

struct DLChipStyle {
    let backgroundColor: Color
    let textColor: Color
    let borderColor: Color
    let padding: EdgeInsets
    let font: Font
}

// MARK: - Style Provider

protocol ChipStyleProviding {
    func style(for variant: DLChipVariant, size: DLChipSize, state: DealiChipStatus) -> DLChipStyle
}

struct DefaultChipStyleProvider: ChipStyleProviding {
    func style(for variant: DLChipVariant, size: DLChipSize, state: DealiChipStatus) -> DLChipStyle {
        let basePadding: EdgeInsets
        let font: Font

        switch size {
        case .small:
            basePadding = EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
            font = .caption
        case .medium:
            basePadding = EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            font = .body
        case .large:
            basePadding = EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            font = .title3
        }

        var background: Color
        var text: Color
        var border: Color

        switch variant {
        case .filled:
            switch state {
            case .normal:
                background = .blue; text = .white; border = .clear
            case .selected:
                background = .indigo; text = .white; border = .clear
            case .disabled:
                background = .gray.opacity(0.3); text = .gray; border = .clear
            }
        case .outline:
            switch state {
            case .normal:
                background = .clear; text = .blue; border = .blue
            case .selected:
                background = .blue.opacity(0.1); text = .blue; border = .blue
            case .disabled:
                background = .clear; text = .gray; border = .gray
            }
        }

        return DLChipStyle(
            backgroundColor: background,
            textColor: text,
            borderColor: border,
            padding: basePadding,
            font: font
        )
    }
}

// MARK: - Config
struct DLImageChipConfig {
    let variant: DLChipVariant
    let size: DLChipSize
    let styleProvider: ChipStyleProviding
}

//
//  DealiControl+ImageChip.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//

import UIKit

public extension DealiControl {
    static func imgChipLarge01() -> ImageChip {
        return ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.large.size,
                style: ImageStyleType.basic.style
            )
        )
    }
    
    static func imgChipMedium01() -> ImageChip {
        return ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.medium.size,
                style: ImageStyleType.basic.style
            )
        )
    }
    
    static func imgChipSmall01() -> ImageChip {
        return ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.small.size,
                style: ImageStyleType.basic.style
            )
        )
    }
}

enum ImageChipSizeType {
    case large
    case medium
    case small
    
    var size: ChipSizeProtoocol {
        switch self {
        case .large:
            return ChipSize(
                height: 46.0,
                imageSize: .init(width: 38.0, height: 38.0),
                placeholderInset: 9.5,
                titleFont: DealiFont.sh3Regular
            )
        case .medium:
            return ChipSize(
                height: 40.0,
                imageSize: .init(width: 32.0, height: 32.0),
                placeholderInset: 8.0,
                titleFont: DealiFont.b2Regular
            )
        case .small:
            return ChipSize(
                height: 32.0,
                imageSize: .init(width: 24.0, height: 24.0),
                placeholderInset: 6.0,
                titleFont: DealiFont.b2Regular
            )
        }
    }
}


enum ImageStyleType {
    case basic
    
    var style: ChipStyle {
        switch self {
        case .basic:
            return ChipStyle(
                radiusProvider: ChipRadiusType.capsule,
                colorProvider: ChipColors(
                    normal: ChipColor(textColor: DealiColor.g80, backgroundColor: DealiColor.b5),
                    selected: ChipColor(textColor: DealiColor.primary04, backgroundColor: DealiColor.g100),
                    disabled: ChipColor(textColor: DealiColor.g50, backgroundColor: DealiColor.b5)
                )
            )
        }
    }
    
}

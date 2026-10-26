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
    
    static func chipOutlineSquareImageLarge01() -> ImageChip {
        let chip = ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.outlineSquareImageLarge.size,
                style: ImageStyleType.outlineSquare01.style
            )
        )
        chip.placeholderImage = nil
        return chip
    }
    
    static func chipOutlineSquareImageMedium01() -> ImageChip {
        let chip = ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.outlineSquareImageMedium.size,
                style: ImageStyleType.outlineSquare01.style
            )
        )
        chip.placeholderImage = nil
        return chip
    }

    /// 캡슐 외곽선 + 12pt 이미지 칩. 선택하면 외곽선이 g100 으로 바뀐다 (Figma chipOutlineImageLarge01)
    static func chipOutlineImageLarge01() -> ImageChip {
        let chip = ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.outlineImageLarge.size,
                style: ImageStyleType.outline01.style
            )
        )
        chip.placeholderImage = nil
        return chip
    }

    static func chipOutlineImageMedium01() -> ImageChip {
        let chip = ImageChip(
            configuration: ImageChipConfig(
                size: ImageChipSizeType.outlineImageMedium.size,
                style: ImageStyleType.outline01.style
            )
        )
        chip.placeholderImage = nil
        return chip
    }
}

enum ImageChipSizeType {
    case large
    case medium
    case small
    case outlineSquareImageLarge
    case outlineSquareImageMedium
    /// 크기 규칙은 outlineSquareImage 와 같고 모양만 캡슐이다
    case outlineImageLarge
    case outlineImageMedium

    var size: ChipSize {
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
        case .outlineSquareImageLarge, .outlineImageLarge:
            return ChipSize(
                height: 46.0,
                imageSize: .init(width: 12.0, height: 12.0),
                placeholderInset: 0,
                titleFont: DealiFont.b2SemiBold,
                leftPadding: 12.0,
                rightPadding: 12.0,
                verticalPadding: 10.0,
                interItemSpacing: 4.0
            )
        case .outlineSquareImageMedium, .outlineImageMedium:
            return ChipSize(
                height: 40.0,
                imageSize: .init(width: 12.0, height: 12.0),
                placeholderInset: 0,
                titleFont: DealiFont.b2SemiBold,
                leftPadding: 12.0,
                rightPadding: 12.0,
                verticalPadding: 10.0,
                interItemSpacing: 4.0
            )
        }
    }
}


enum ImageStyleType {
    case basic
    case outlineSquare01
    /// 캡슐 외곽선. 기본 g20, 선택 g100, 비활성 g20 테두리
    case outline01

    var style: ChipStyle {
        switch self {
        case .outline01:
            return ChipStyle(
                radiusProvider: ChipRadiusType.capsule,
                colorProvider: ChipColors(
                    normal: ChipColor(textColor: UIColor.g100, backgroundColor: UIColor.primary04, borderColor: UIColor.g20),
                    selected: ChipColor(textColor: UIColor.g100, backgroundColor: UIColor.primary04, borderColor: UIColor.g100),
                    disabled: ChipColor(textColor: UIColor.g50, backgroundColor: UIColor.primary04, borderColor: UIColor.g20)
                )
            )
        case .basic:
            return ChipStyle(
                radiusProvider: ChipRadiusType.capsule,
                colorProvider: ChipColors(
                    normal: ChipColor(textColor: UIColor.g80, backgroundColor: UIColor.b5),
                    selected: ChipColor(textColor: UIColor.primary04, backgroundColor: UIColor.g100),
                    disabled: ChipColor(textColor: UIColor.g50, backgroundColor: UIColor.b5)
                )
            )
        case .outlineSquare01:
            return ChipStyle(
                radiusProvider: ChipRadiusType.fixed(4.0),
                colorProvider: ChipColors(
                    normal: ChipColor(textColor: UIColor.g100, backgroundColor: UIColor.primary04, borderColor: UIColor.g20),
                    selected: ChipColor(textColor: UIColor.g100, backgroundColor: UIColor.primary04, borderColor: UIColor.g20),
                    disabled: ChipColor(textColor: UIColor.g50, backgroundColor: UIColor.primary04, borderColor: UIColor.g20)
                )
            )
        }
    }
    
}

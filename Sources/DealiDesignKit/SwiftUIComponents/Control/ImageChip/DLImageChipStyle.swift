//
//  DLImageChipStyle.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/20/25.
//

import Foundation
import SwiftUI

struct DLImageChipStyle {
    var height: CGFloat
    var imageSize: CGSize
    var cornerRadius: CGFloat = 8.0
    var placeholderInset: CGFloat
    var rightIconImageSize: CGSize = CGSize(width: 16.0, height: 16.0)
    
    var leftPadding: CGFloat = 4.0
    var interItemSpacing: CGFloat = 8.0
    var contentSpacing: CGFloat = 4.0
    var rightPadding: CGFloat = 12.0
    var verticalPadding: CGFloat = 4.0
    
    private(set) var titleFont: Font?
    var textColor: Color
    
    var backgroundColor: Color
    var borderColor: Color?
    
}
struct DLImageChipConfig: ChipConfigurable {
    
    let style: any ChipStyleProtocol
    let size: any ChipSizeProtoocol
    
    func style(for state: DealiChipStatus) -> DLImageChipStyle {
        let provider = self.style.colorProvider as! ChipColors
        let color: ChipColor = provider.getColor(for: state)
    
        var titleFont: Font {
            switch state {
            case .normal, .disabled:
                return Font(self.size.titleFont.systemFont)
            case .selected:
                return Font(self.size.titleFont.makeBolder())
            }
        }
        
        return DLImageChipStyle(
            height: size.height,
            imageSize: size.imageSize,
            cornerRadius: self.style.radiusProvider.getRadius(for: size.height),
            placeholderInset: size.placeholderInset,
            titleFont: titleFont,
            textColor: Color(color.textColor),
            backgroundColor: Color(color.backgroundColor),
            borderColor: Color(color.borderColor ?? UIColor.clear)
        )
    }
     
    init(size: any ChipSizeProtoocol,
         style: any ChipStyleProtocol) {
        
        self.size = size
        self.height = size.height
        self.imageSize = size.imageSize
        self.placeholderInset = size.placeholderInset
        
        self.style = style
    }
    
    var height: CGFloat
    var imageSize: CGSize
    var placeholderInset: CGFloat
}

public enum ImageChipPreset: CaseIterable {
    case imgChipLarge01
    case imgChipMedium01
    case imgChipSmall01
    
    var config: DLImageChipConfig {
        switch self {
        case .imgChipLarge01:
            return DLImageChipConfig(
                size: ImageChipSizeType.large.size,
                style: ImageStyleType.basic.style
            )
        case .imgChipMedium01:
            return DLImageChipConfig(
                size: ImageChipSizeType.medium.size,
                style: ImageStyleType.basic.style
            )
        case .imgChipSmall01:
            return DLImageChipConfig(
                size: ImageChipSizeType.small.size,
                style: ImageStyleType.basic.style
            )
        }
    }
}

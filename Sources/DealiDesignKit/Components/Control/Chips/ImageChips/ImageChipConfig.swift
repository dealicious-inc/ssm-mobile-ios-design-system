//
//  ImageChipConfig.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//
import UIKit

class ImageChipConfig: ChipConfigurable {
    
    func updateAppearance() {
        let color = self.style.colors.getColor(for: status)
        self.configColor(color)
        
        switch self.status {
        case .normal, .disabled:
            self.titleFont = self.size.titleFont.systemFont
        case .selected:
            self.titleFont = self.size.titleFont.makeBolder()
        }
    }
    
    var status: DealiChipStatus = .normal {
        didSet {
            self.updateAppearance()
        }
    }
    
    var radius: CGFloat {
        switch self.radiusType {
        case .none:
            return 0.0
        case .fixed(let radius):
            return radius
        case .capsule:
            return self.height / 2
        }
    }
    
    var style: ChipStyleProtocol
    var size: ChipSizeProtoocol
        
    init(size: ChipSizeProtoocol,
         style: ChipStyleProtocol) {
        
        self.size = size
        self.height = size.height
        self.imageSize = size.imageSize
        self.placeholderInset = size.placeholderInset
        
        self.style = style
        let color = style.colors.getColor(for: .normal)
        self.textColor = color.textColor
        self.backgroundColor = color.backgroundColor
        self.borderColor = color.borderColor
        self.radiusType = style.radius
    }
    
    var radiusType: ChipRadiusType
    
    var height: CGFloat
    var imageSize: CGSize
    var placeholderInset: CGFloat
    var rightIconImageSize: CGSize = CGSize(width: 16.0, height: 16.0)
    
    var leftPadding: CGFloat = 4.0
    var rightPadding: CGFloat = 12.0
    var verticalPadding: CGFloat = 4.0
    
    private(set) var titleFont: UIFont?
    var textColor: UIColor
    
    var backgroundColor: UIColor
    var borderColor: UIColor?
    
    func configColor(_ color: ChipColorProtocol) {
        self.backgroundColor = color.backgroundColor
        self.textColor = color.textColor
        self.borderColor = color.backgroundColor
    }
}

struct ChipSize: ChipSizeProtoocol {
    var height: CGFloat
    var imageSize: CGSize
    var placeholderInset: CGFloat
    var titleFont: FontProvider
}

struct ChipStyle: ChipStyleProtocol {
    var radius: ChipRadiusType = .capsule
    var colors: ChipColorsProtocol
}


struct ChipColors: ChipColorsProtocol {
    private var normal: ChipColor
    private var selected: ChipColor
    private var disabled: ChipColor
    
    init(normal: ChipColor, selected: ChipColor, disabled: ChipColor) {
        self.normal = normal
        self.selected = selected
        self.disabled = disabled
    }
    
    func getColor(for status: DealiChipStatus) -> ChipColorProtocol {
        switch status {
        case .normal:
            return self.normal
        case .selected:
            return self.selected
        case .disabled:
            return self.disabled
        }
    }
}

struct ChipColor: ChipColorProtocol {
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .white
    var borderColor: UIColor?
}

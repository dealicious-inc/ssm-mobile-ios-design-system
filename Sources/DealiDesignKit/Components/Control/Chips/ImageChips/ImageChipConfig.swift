//
//  ImageChipConfig.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//
import UIKit

class ImageChipConfig: ChipConfigurable {
    
    var style: any ChipStyleProtocol
    var size: any ChipSizeProtoocol
    
    func updateAppearance() {
      
        let provider = self.style.colorProvider as! ChipColors
        let color: ChipColor = provider.getColor(for: status)
        self.configColor(color as ChipColorProtocol)
        
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
        return self.style.radiusProvider.getRadius(for: self.height)
    }
     
    init(size: any ChipSizeProtoocol,
         style: any ChipStyleProtocol) {
        
        self.size = size
        self.height = size.height
        self.imageSize = size.imageSize
        self.placeholderInset = size.placeholderInset
        
        self.style = style
        
        let provider = self.style.colorProvider as! ChipColors
        let color = provider.getColor(for: .normal)
        self.textColor = color.textColor
        self.backgroundColor = color.backgroundColor
        self.borderColor = color.borderColor
    }
    
    var height: CGFloat
    var imageSize: CGSize
    var placeholderInset: CGFloat
    var rightIconImageSize: CGSize = CGSize(width: 16.0, height: 16.0)
    
    var leftPadding: CGFloat = 4.0
    var interItemSpacing: CGFloat = 8.0
    var contentSpacing: CGFloat = 4.0
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

struct ChipColors: ControlColorPrivider {
    typealias Status = DealiChipStatus
    typealias Color = ChipColor
    
    private var normal: ChipColor
    private var selected: ChipColor
    private var disabled: ChipColor
    
    init(normal: ChipColor, selected: ChipColor, disabled: ChipColor) {
        self.normal = normal
        self.selected = selected
        self.disabled = disabled
    }
    
    func getColor(for status: Status) -> Color {
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

struct ChipStyle: ChipStyleProtocol {
    
    var radiusProvider: any RadiusProvider
    var colorProvider: ColorProvider
}

struct ChipColor: ChipColorProtocol {
    var textColor: UIColor
    var backgroundColor: UIColor
    var borderColor: UIColor?
}

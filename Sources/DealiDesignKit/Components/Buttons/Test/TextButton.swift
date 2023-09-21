//
//  TextButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

public class TextButton: UIButton {
    public var title: String? = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    public var leftIconImage: UIImage? {
        didSet {
            self.setAppearance()
        }
    }
    
    public var rightIconImage: UIImage? {
        didSet {
            self.setAppearance()
        }
    }
    
    public var color: TextColorType
    public var size: TextSizeType
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            
            if newValue == false {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.borderWidth = 1.0
            }
            
            super.isEnabled = newValue
        }
    }
    
    public init(color: TextColorType, size: TextSizeType, title: String? = "") {
        self.color = color
        self.size = size
        self.title = title
        
        super.init(frame: .zero)
        
        self.setAppearance()
    }
    
    func setAppearance() {
        self.setBackgroundColor(self.color.attribute.defaultBackgroundColor, for: .normal)
        self.setBackgroundColor(self.color.attribute.disabledBackgroundColor, for: .disabled)
        self.setTitleColor(self.color.attribute.defaultTextColor, for: .normal)
        self.setTitleColor(self.color.attribute.disabledBackgroundColor, for: .disabled)
        
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        self.titleLabel?.font = self.size.attribute.font

        let horizontalPadding = self.size.attribute.padding.horizontal
        let verticalPadding = self.size.attribute.padding.vertical

        let internalSpacing = self.size.attribute.padding.internalSpacing

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        
        if let leftIconImage = self.leftIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: -internalSpacing, bottom: 0.0, right: internalSpacing)

            self.setImage(leftIconImage.withTintColor(self.color.attribute.defaultTextColor), for: .normal)
            self.setImage(leftIconImage.withTintColor(self.color.attribute.disabledBackgroundColor), for: .disabled)
            self.semanticContentAttribute = .forceLeftToRight
        } else if let rightIconImage = self.rightIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: internalSpacing, bottom: 0.0, right: -internalSpacing)

            self.setImage(rightIconImage.withTintColor(self.color.attribute.defaultTextColor), for: .normal)
            self.setImage(rightIconImage.withTintColor(self.color.attribute.disabledBackgroundColor), for: .disabled)
            self.semanticContentAttribute = .forceRightToLeft
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


public enum TextColorType {
    case primary01
    case primary02
    
    var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor:  .clear,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.primary01.cgColor,
                disabledBorderColor: DealiColor.g30.cgColor
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.w50,
                defaultBorderColor: DealiColor.primary04.cgColor,
                disabledBorderColor: DealiColor.w50.cgColor
            )
        }
    }
}

public enum TextSizeType {
    case large
    case medium
    case small
    
    var attribute: ButtonSize {
        switch self {
        case .large:
            return ButtonSize(
                font: UIFont.b1sb15,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 15.0)
            )
        case .medium:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 13.0)
            )
        case .small:
            return ButtonSize(
                font: UIFont.b1sb15,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 7.0)
            )
        }
        
    }
}

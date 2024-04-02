//
//  SystemButton.swift
//
//
//  Created by 윤조현 on 2023/09/22.
//

import UIKit

public protocol ButtonColorConfig {
    var attribute: ButtonColor { get }
}

public struct ButtonColor {
    var defaultBackgroundColor: UIColor
    var disabledBackgroundColor: UIColor
    var defaultTextColor: UIColor
    var disabledTextColor: UIColor
    var defaultBorderColor: UIColor = UIColor.clear
    var disabledBorderColor: UIColor = UIColor.clear
}

public protocol ButtonSizeConfig {
    var attribute: ButtonSize { get }
}


public struct ButtonSize {
    var font: UIFont
    var padding: DealiButtonPadding
}

public struct ButtonStyle {
    var font: UIFont
    var height: CGFloat
    var cornerRadius: CGFloat
    var sidePadding: CGFloat
}

public struct ButtonImage {
    enum EDirection {
        case left
        case right
    }
    var image: UIImage
    var size: CGSize
    var space: CGFloat
    var direction: EDirection
}

public class SystemButton: UIButton {
    public var title: String? = "" {
        didSet {
            self.setAppearance()
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
    
    public var color: ButtonColorConfig
    public var size: ButtonSizeConfig
        
    public init(color: ButtonColorConfig, size: ButtonSizeConfig, title: String? = "") {
        self.color = color
        self.size = size
        self.title = title
        
        super.init(frame: .zero)
        
        self.setAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            
            if newValue == false {
                self.layer.borderColor = self.color.attribute.disabledBorderColor.cgColor
                self.layer.borderWidth = 1.0
            }
            
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            self.backgroundColor = isHighlighted ? DealiColor.b10 : self.color.attribute.defaultBackgroundColor
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        

        if leftIconImage != nil {
            self.semanticContentAttribute = .forceLeftToRight
        }
        
        if rightIconImage != nil {
            self.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    func setAppearance() {
        
        self.setBackgroundColor(self.color.attribute.defaultBackgroundColor, for: .normal)
        self.setBackgroundColor(self.color.attribute.disabledBackgroundColor, for: .disabled)
        self.setTitleColor(self.color.attribute.defaultTextColor, for: .normal)
        self.setTitleColor(self.color.attribute.defaultTextColor, for: .highlighted)
        self.setTitleColor(self.color.attribute.disabledTextColor, for: .disabled)
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .disabled)
        
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        self.titleLabel?.font = self.size.attribute.font
        self.layer.borderColor = self.color.attribute.defaultBorderColor.cgColor
        self.layer.borderWidth = 1.0

        let horizontalPadding = self.size.attribute.padding.horizontal
        let verticalPadding = self.size.attribute.padding.vertical

        let internalSpacing = self.size.attribute.padding.internalSpacing
        let halfInternalSpacing = internalSpacing / 2

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        
        if let leftIconImage = self.leftIconImage {
            self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding + halfInternalSpacing, bottom: verticalPadding, right: horizontalPadding + halfInternalSpacing)

            self.imageEdgeInsets = .init(top: 0.0, left: -halfInternalSpacing, bottom: 0.0, right: halfInternalSpacing)
            self.titleEdgeInsets = .init(top: 0.0, left: halfInternalSpacing, bottom: 0.0, right: -halfInternalSpacing)

            self.setImage(leftIconImage.withTintColor(self.color.attribute.defaultTextColor), for: .normal)
            self.setImage(leftIconImage.withTintColor(self.color.attribute.defaultTextColor), for: .highlighted)

            self.setImage(leftIconImage.withTintColor(self.color.attribute.disabledTextColor), for: .disabled)
            self.semanticContentAttribute = .forceLeftToRight

            
        } else if let rightIconImage = self.rightIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: internalSpacing, bottom: 0.0, right: -internalSpacing)

            self.setImage(rightIconImage.withTintColor(self.color.attribute.defaultTextColor), for: .normal)
            self.setImage(rightIconImage.withTintColor(self.color.attribute.defaultTextColor), for: .highlighted)
            
            self.setImage(rightIconImage.withTintColor(self.color.attribute.disabledTextColor), for: .disabled)
            self.semanticContentAttribute = .forceRightToLeft
            
        }
                
    }
}


//
//  DealiButton.swift
//
//
//  Created by 윤조현 on 2023/06/23.
//

import UIKit

public enum DealiButtonStatus: Equatable {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
}


/// 디자인시스템 Buttons 적용
///
/// 1. 초기화 이후 `size` `style` `color`과  `title` 속성 `leftIconImage` 또는 `rightIconImage` 이미지 속성 설정
///     ```swift
///     let myButton = DealiButton()
///     myButton.size = .medium
///     myButton.style = .filled
///     myButton.color = .gradient
///     myButton.title = "로그인 하기"
///     myButton.leftIconImage = UIImage(named: "이미지이름")
///     또는
///     myButton.rightIconImage = UIImage(named: "이미지이름")
///     ```
public class DealiButton: UIButton {

    private var preset = DealiButtonStyle()
    
    public var size: DealiButtonSizeType = .large {
        didSet {
            self.preset.size = self.size
            self.setAppearance()
            
            self.snp.makeConstraints {
                $0.height.equalTo(preset.appearanceConfig.buttonHeight)
            }
        }
    }
    
    public var style: DealiButtonStyleType = .filled {
        didSet {
            self.preset.style = self.style
            self.setAppearance()
        }
    }
    
    public var color: DealiButtonColorType = .default {
        didSet {
            self.preset.color = self.color
            
            switch self.color {
            case .gradient:
                self.setGradient(direction: .horizontal, colorType: self.color)
            default:
                break
            }
            
            self.setAppearance()
        }
    }
    
    public var title: String? {
        didSet {
            self.setAppearance()
        }
    }
    
    public var subTitle: String? {
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
    private var gradient: CAGradientLayer?
    
    func setAppearance() {
        
        self.setBackgroundColor(self.preset.colorPreset.defaultBackgroundColor, for: .normal)
        self.setBackgroundColor(self.preset.colorPreset.pressedBackgroundColor, for: .highlighted)
        self.setBackgroundColor(self.preset.colorPreset.disabledBackgroundColor, for: .disabled)
        
        let horizontalPadding = self.preset.appearanceConfig.horizontalPadding
        let internalSpacing = self.preset.appearanceConfig.internalSpacing

        self.contentEdgeInsets = .init(top: 0.0, left: horizontalPadding + internalSpacing, bottom: 0.0, right: horizontalPadding + internalSpacing)
        if let leftIconImage = self.leftIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: -internalSpacing, bottom: 0.0, right: internalSpacing)

            self.setImage(leftIconImage.withTintColor(self.preset.colorPreset.defaultTitleColor), for: .normal)
            self.setImage(leftIconImage.withTintColor(self.preset.colorPreset.pressedTitleColor), for: .highlighted)
            self.setImage(leftIconImage.withTintColor(self.preset.colorPreset.disabledTitleColor), for: .disabled)
            self.semanticContentAttribute = .forceLeftToRight
        } else if let rightIconImage = self.rightIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: internalSpacing, bottom: 0.0, right: -internalSpacing)

            self.setImage(rightIconImage.withTintColor(self.preset.colorPreset.defaultTitleColor), for: .normal)
            self.setImage(rightIconImage.withTintColor(self.preset.colorPreset.pressedTitleColor), for: .highlighted)
            self.setImage(rightIconImage.withTintColor(self.preset.colorPreset.disabledTitleColor), for: .disabled)
            self.semanticContentAttribute = .forceRightToLeft
        }
        
        self.layer.masksToBounds = true
        self.layer.borderColor = self.preset.colorPreset.defaultBorderColor
        self.layer.cornerRadius = self.preset.appearanceConfig.cornerRadius
        self.layer.borderWidth = self.preset.appearanceConfig.borderWidth
        
        if let title = self.title {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 4.0
            style.alignment = .center
            let defaultTitle = NSMutableAttributedString(string: title, attributes: [.font: self.preset.appearanceConfig.titleFont, .foregroundColor: self.preset.colorPreset.defaultTitleColor, .paragraphStyle: style])
            let pressedTitle = NSMutableAttributedString(string: title, attributes: [.font: self.preset.appearanceConfig.titleFont, .foregroundColor: self.preset.colorPreset.pressedTitleColor, .paragraphStyle: style])
            let disabledTitle = NSMutableAttributedString(string: title, attributes: [.font: self.preset.appearanceConfig.titleFont, .foregroundColor: self.preset.colorPreset.disabledTitleColor, .paragraphStyle: style])
            if let subTitle = self.subTitle {
                self.titleLabel?.numberOfLines = 2
                defaultTitle.append(NSAttributedString(string: "\n\(subTitle)", attributes: [.font: self.preset.appearanceConfig.subTitleFont, .foregroundColor: self.preset.colorPreset.defaultTitleColor, .paragraphStyle: style]))
                pressedTitle.append(NSAttributedString(string: "\n\(subTitle)", attributes: [.font: self.preset.appearanceConfig.subTitleFont, .foregroundColor: self.preset.colorPreset.pressedTitleColor, .paragraphStyle: style]))
                disabledTitle.append(NSAttributedString(string: "\n\(subTitle)", attributes: [.font: self.preset.appearanceConfig.subTitleFont, .foregroundColor: self.preset.colorPreset.disabledTitleColor, .paragraphStyle: style]))
            }
            
            self.setAttributedTitle(defaultTitle, for: .normal)
            self.setAttributedTitle(pressedTitle, for: .highlighted)
            self.setAttributedTitle(disabledTitle, for: .disabled)
        }
        
    }
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            self.isUserInteractionEnabled = isEnabled

            if newValue == false {
                self.layer.borderColor = self.preset.colorPreset.disabledBorderColor
                self.layer.borderWidth = self.preset.appearanceConfig.borderWidth
                
                if let gradient = self.gradient {
                    gradient.removeFromSuperlayer()
                    self.gradient = nil
                }
            } else {
                self.setGradient(direction: .horizontal, colorType: self.color)
            }

            super.isEnabled = newValue
        }
    }
    
    public override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue == true {
                self.layer.borderColor = self.preset.colorPreset.pressedBorderColor
                
                if let gradient = self.gradient {
                    gradient.removeFromSuperlayer()
                    self.gradient = nil
                }
            } else {
                self.layer.borderColor = self.preset.colorPreset.defaultBorderColor
                
                self.setGradient(direction: .horizontal, colorType: self.color)
            }
            
            super.isHighlighted = newValue
        }
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradient = self.gradient {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradient.frame = self.bounds
            CATransaction.commit()
        }
    }
}

extension DealiButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func setGradient(direction: EGradientDirection, colorType: DealiButtonColorType, locations: [NSNumber] = [0.0, 1.0]) {
        print("setGradient")
        if let gradient = self.gradient {
            gradient.removeFromSuperlayer()
            self.gradient = nil
        }
        
        var colors: [UIColor] = []
        switch colorType {
        case .gradient:
            colors = DealiColor.primaryGradient
        default:
            break
        }
        
        let layer = CAGradientLayer()
        layer.do {
            if direction == .horizontal {
                $0.colors = colors.map({$0.cgColor})
                $0.locations = locations
                $0.startPoint = CGPoint(x: 0.0, y: 1.0)
                $0.endPoint = CGPoint(x: 1.0, y: 1.0)
                $0.frame = self.bounds
                $0.cornerRadius = self.preset.appearanceConfig.cornerRadius
            } else {
                $0.colors = colors.map({$0.cgColor})
                $0.locations = locations
                $0.frame = self.bounds
                $0.cornerRadius = self.preset.appearanceConfig.cornerRadius
            }
        }
        self.layer.insertSublayer(layer, at: 0)
        if let imageView = self.imageView {
            self.bringSubviewToFront(imageView)
        }
        self.gradient = layer
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonPreview: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                Text("DealiButton Test")
                    .font(.system(size: 30.0, weight: .bold))
                
                Group {
                    Text("Large")
                        .font(.system(size: 20.0, weight: .bold))
                    buttonStyle(size: .large, style: .filled, color: .gradient)
                    buttonStyle(size: .large, style: .outlined)
                    buttonStyle(size: .large, style: .tonal)
                    buttonStyle(size: .large, style: .text)
                }
                
                Group {
                    Text("Medium")
                        .font(.system(size: 20.0, weight: .bold))
                    
                    buttonStyle(size: .medium, style: .filled)
                    buttonStyle(size: .medium, style: .outlined)
                    buttonStyle(size: .medium, style: .tonal)
                    buttonStyle(size: .medium, style: .text)
                }
                
                Group {
                    Text("Small")
                        .font(.system(size: 20.0, weight: .bold))

                    buttonStyle(size: .small, style: .filled)
                    buttonStyle(size: .small, style: .outlined)
                    buttonStyle(size: .small, style: .tonal)
                    buttonStyle(size: .small, style: .text)

                }
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiButtonStyle")
    }
    
    
    @ViewBuilder static func buttonStyle(size: DealiButtonSizeType, style: DealiButtonStyleType, color: DealiButtonColorType = .default) -> some View {
        VStack(alignment: .leading) {
            Text(String(describing: style))
            UIViewPreview {
                let button = DealiButton()
                button.title = "Default 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.subTitle = "사입사/직접픽업/택배입니다요"
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Pressed 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.isHighlighted = true
                button.subTitle = "사입사/직접픽업/택배입니다요"
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Disabled 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.isEnabled = false
                button.subTitle = "사입사/직접픽업/택배입니다요"
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Default 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
                button.subTitle = "사입사/직접픽업/택배입니다요"
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Pressed 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
                button.subTitle = "사입사/직접픽업/택배입니다요"
                button.isHighlighted = true
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Disabled 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.rightIconImage = UIImage(named: "ic_arrow_right_16", in: Bundle.module, compatibleWith: nil)
                button.subTitle = "사입사/직접픽업/택배입니다요"
                button.isEnabled = true
                return button
            }
        }
    }
}
#endif

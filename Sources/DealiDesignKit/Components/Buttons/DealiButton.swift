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
/// 두 가지 방법 중 하나로 ``style`` 과 ``title`` 을 정의하여 사용가능
/// 1. 초기화 시에 `style`과  `title` 정의
///     ```swift
///     init(_ style: DealiButtonStyle, title: String?)
///     ```
/// 2. 초기화 이후 `style`과  `title` 속성 설정
///     ```swift
///     let myButton = DealiButton()
///     myButton.style = .medium(style: .filled)
///     myButton.title = "로그인 하기"
///     ```
public class DealiButton: UIButton {
//    public var style: DealiButtonStyle = .large(style: .filled) {
//        didSet {
//            self.setAppearance()
//        }
//    }
    private var preset = DealiButtonStyle()
    
    public var size: DealiButtonSizeType = .large {
        didSet {
            self.preset.size = self.size
            self.setAppearance()
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
            self.setAppearance()
        }
    }
    
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
    
    func setAppearance() {
        
        self.setBackgroundColor(self.preset.colorPreset.defaultBackgroundColor, for: .normal)
        self.setBackgroundColor(self.preset.colorPreset.pressedBackgroundColor, for: .highlighted)
        self.setBackgroundColor(self.preset.colorPreset.disabledBackgroundColor, for: .disabled)
        
        let horizontalPadding = self.preset.appearanceConfig.horizontalPadding
        let verticalPadding = self.preset.appearanceConfig.verticalPadding
        let internalSpacing = self.preset.appearanceConfig.internalSpacing

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
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
        
        self.setTitleColor(self.preset.colorPreset.defaultTitleColor, for: .normal)
        self.setTitleColor(self.preset.colorPreset.pressedTitleColor, for: .highlighted)
        self.setTitleColor(self.preset.colorPreset.disabledTitleColor, for: .disabled)
        self.titleLabel?.font = self.preset.appearanceConfig.font
        
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
            }

            super.isEnabled = newValue
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
                    buttonStyle(size: .large, style: .filled)
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
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Pressed 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.isHighlighted = true
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Disabled 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.isEnabled = false
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Default 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
                return button
            }
            
            UIViewPreview {
                let button = DealiButton()
                button.title = "Pressed 버튼"
                button.size = size
                button.style = style
                button.color = color
                button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
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
                button.isEnabled = true
                return button
            }
        }
    }
}
#endif

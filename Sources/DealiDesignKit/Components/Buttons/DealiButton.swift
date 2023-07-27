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
    public var style: DealiButtonStyle = .large(style: .filled) {
        didSet {
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
    
    public init(_ style: DealiButtonStyle = .large(style: .filled), title: String? = "") {
        super.init(frame: .zero)
        self.style = style
        self.title = title
        
        self.setTitle(title, for: .normal)
        
        self.setAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setAppearance()
    }
    
    func setAppearance() {
        
        self.setBackgroundColor(self.style.defaultBackgroundColor, for: .normal)
        self.setBackgroundColor(self.style.pressedBackgroundColor, for: .highlighted)
        self.setBackgroundColor(self.style.disabledBackgroundColor, for: .disabled)

        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        let horizontalPadding = self.style.padding.horizontal
        let verticalPadding = self.style.padding.vertical

        let internalSpacing = self.style.padding.internalSpacing

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        if let leftIconImage = self.leftIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: -internalSpacing, bottom: 0.0, right: internalSpacing)

            self.setImage(leftIconImage.withTintColor(self.style.textColor), for: .normal)
            self.setImage(leftIconImage.withTintColor(self.style.pressedTextColor), for: .highlighted)
            self.setImage(leftIconImage.withTintColor(self.style.disabledTextColor), for: .disabled)
            self.semanticContentAttribute = .forceLeftToRight
        } else if let rightIconImage = self.rightIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: internalSpacing, bottom: 0.0, right: -internalSpacing)

            self.setImage(rightIconImage.withTintColor(self.style.textColor), for: .normal)
            self.setImage(rightIconImage.withTintColor(self.style.pressedTextColor), for: .highlighted)
            self.setImage(rightIconImage.withTintColor(self.style.disabledTextColor), for: .disabled)
            self.semanticContentAttribute = .forceRightToLeft
        }

        
        if self.style.hasBorder {
            self.layer.borderColor = self.style.defaultBorderColor
            self.layer.borderWidth = 1.0
        }
        
        self.setTitleColor(self.style.textColor, for: .normal)
        self.setTitleColor(self.style.pressedTextColor, for: .highlighted)
        self.setTitleColor(self.style.disabledTextColor, for: .disabled)
        self.titleLabel?.font = self.style.font
        
    }
    
//    public override var isHighlighted: Bool {
//        get {
//            return super.isHighlighted
//        }
//        set {
//            if newValue {
//                backgroundColor = self.style.pressedBackgroundColor
//            } else {
//                backgroundColor = self.isEnabled ? self.style.defaultBackgroundColor : self.style.disabledBackgroundColor
//            }
//            super.isHighlighted = newValue
//        }
//    }
    
//    public override var isEnabled: Bool {
//        get {
//            return super.isEnabled
//        }
//        set {
//            self.isUserInteractionEnabled = isEnabled
//
//            if newValue == false {
////                backgroundColor =  self.style.disabledBackgroundColor
////                self.setTitleColor(self.style.disabledTextColor, for: .normal)
//
//                if self.style.hasBorder {
//                    self.layer.borderColor = self.style.disabledBorderColor
//                    self.layer.borderWidth = 1.0
//                }
//            }
//
//            super.isEnabled = newValue
//        }
//    }
    
    public override var isEnabled: Bool {
        didSet {
            self.isUserInteractionEnabled = self.isEnabled
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
                    
                    buttonStyle(style: .large(style: .filled))
                    buttonStyle(style: .large(style: .outlined))
                    buttonStyle(style: .large(style: .tonal))
                }
                
                Group {
                    Text("Medium")
                        .font(.system(size: 20.0, weight: .bold))
                    
                    buttonStyle(style: .medium(style: .filled))
                    buttonStyle(style: .medium(style: .outlined))
                    buttonStyle(style: .medium(style: .tonal))
                }
                
                Group {
                    Text("Small")
                        .font(.system(size: 20.0, weight: .bold))
                    
                    buttonStyle(style: .small(style: .filled))
                    buttonStyle(style: .small(style: .outlined))
                    buttonStyle(style: .small(style: .tonal))
                }
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiButtonStyle")
    }
    
    
    @ViewBuilder static func buttonStyle(style: DealiButtonStyle) -> some View {
        VStack(alignment: .leading) {
            Text(String(describing: style))
            UIViewPreview {
                let button = DealiButton(title: "Default 버튼")
                button.style = style
                return button
            }
            
            UIViewPreview {
                let button = DealiButton(title: "Pressed 버튼")
                button.style = style
                button.isHighlighted = true
                return button
            }
            
            UIViewPreview {
                let button = DealiButton(title: "Disabled 버튼")
                button.style = style
                button.isEnabled = false
                return button
            }
            
            UIViewPreview {
                let button = DealiButton(title: "Default 버튼")
                button.style = style
                button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
                return button
            }
            
            UIViewPreview {
                let button = DealiButton(title: "Pressed 버튼")
                button.style = style
                button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
                button.isHighlighted = true
                return button
            }
            
            UIViewPreview {
                let button = DealiButton(title: "Disabled 버튼")
                button.style = style
                button.rightIconImage = UIImage(named: "ic_arrow_right_16", in: Bundle.module, compatibleWith: nil)
                button.isEnabled = true
                return button
            }
        }
    }
}
#endif

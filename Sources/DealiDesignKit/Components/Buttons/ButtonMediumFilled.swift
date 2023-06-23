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

struct DealiButtonStyle {
    var buttonSize: DealiButtonSize = .medium
    
    
    enum DealiButtonSize: Equatable {
        case large
        case medium
        case small
    }
}

/**
 설명: 디자인시스템 Buttons - ButtonMediumFilled
 */
public class ButtonMediumFilled: UIButton {
    
    public var status: DealiButtonStatus = .default {
        didSet {
            
        }
    }
    
    private var disabledBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor?
    private var pressedBackgroundColor: UIColor?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        let horizontalPadding = 20.0
        let verticalPadding = 13.0
        
        let intervalSpacing = 0.0
        
        let halfIntervalSpacing = intervalSpacing / 2
        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding + halfIntervalSpacing, bottom: verticalPadding, right: halfIntervalSpacing + horizontalPadding)
        self.imageEdgeInsets = .init(top: 0, left: -halfIntervalSpacing, bottom: 0, right: halfIntervalSpacing)
        self.titleEdgeInsets = .init(top: 0, left: halfIntervalSpacing, bottom: 0, right: -halfIntervalSpacing)
        
        self.titleLabel?.font = DealiFont.b2Bold.font

        self.setTitle("테스트버튼", for: .normal)
        self.setTitle("하이라이트", for: .highlighted)
        self.setTitle("비활성화", for: .disabled)

        
        self.backgroundColor = DColor.primary01
        self.setAppearance(for: self.status)
    }

    public override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = DColor.primary02
            } else {
                backgroundColor = self.isEnabled ? DColor.primary01 : DColor.bg04
            }
            super.isHighlighted = newValue
           
        }
    }
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            self.isUserInteractionEnabled = isEnabled
            
            if newValue == false {
                backgroundColor = DColor.bg04
            }
            
            self.setTitle("비활성화", for: .normal)
            super.isEnabled = newValue
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setAppearance(for status: DealiButtonStatus) {

    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonPreview: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Default")
            UIViewPreview {
                let button = ButtonMediumFilled()
                return button
                
            }
            
            Text("Hover & Pressed")
            UIViewPreview {
                let button = ButtonMediumFilled()
                button.isHighlighted = true
                return button
                
            }
            
            Text("Disabled")
            UIViewPreview {
                let button = ButtonMediumFilled()
                button.isEnabled = false
                return button
            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ButtonMediumFilled")
    }
}
#endif

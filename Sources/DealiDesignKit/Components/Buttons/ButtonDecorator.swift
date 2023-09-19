//
//  ButtonDecorator.swift
//  
//
//  Created by JohyeonYoon on 2023/09/18.
//

import UIKit

public protocol CustomView where Self: DealiButton {
    var defaultBackgroundColor: UIColor? { get set }
    var pressedBackgroundColor: UIColor? { get set }
    var disabledBackgroundColor: UIColor? { get set }
    
    var defaultTextColor: UIColor? { get set }
    var pressedTextColor: UIColor? { get set }
    var disabledTextColor: UIColor? { get set }

    func setView()
}

public extension CustomView {
     func setView() {
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        self.setBackgroundColor(defaultBackgroundColor ?? .clear, for: .normal)
        self.setBackgroundColor(pressedBackgroundColor ?? .clear, for: .highlighted)
        self.setBackgroundColor(disabledBackgroundColor ?? .clear, for: .disabled)
        
        self.setTitleColor(defaultTextColor, for: .normal)
        self.setTitleColor(pressedTextColor, for: .highlighted)
        self.setTitleColor(disabledTextColor, for: .disabled)
    }
}

public class BaseButton: DealiButton, CustomView {
    public var defaultTextColor: UIColor?
    public var pressedTextColor: UIColor?
    public var disabledTextColor: UIColor?
    public var defaultBackgroundColor: UIColor?
    public var pressedBackgroundColor: UIColor?
    public var disabledBackgroundColor: UIColor?
    
    public override func setAppearance() {
        self.setView()
    }
}

public protocol ButtonDecorator: CustomView {
    var decoratedButton: CustomView { get set }
        
    init(decoratedButton: CustomView)
}

public class FilledPrimary01Decorator: DealiButton, ButtonDecorator {
    
    public var defaultTextColor: UIColor?  = FilledPrimary01State.default.textColor
    public var pressedTextColor: UIColor? = FilledPrimary01State.hoverAndPressed.textColor
    public var disabledTextColor: UIColor? = FilledPrimary01State.disabled.textColor
    
    public var defaultBackgroundColor: UIColor? = FilledPrimary01State.default.backgroundColor
    public var pressedBackgroundColor: UIColor? = FilledPrimary01State.hoverAndPressed.backgroundColor
    
    public var disabledBackgroundColor: UIColor? = FilledPrimary01State.disabled.backgroundColor
    public var decoratedButton: CustomView
    
    public required init(decoratedButton: CustomView) {
        self.decoratedButton = decoratedButton
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setAppearance() {
        self.setView()
      
    }
}

public class LargeDecorator: DealiButton, ButtonDecorator {
    public var defaultTextColor: UIColor?
    public var pressedTextColor: UIColor?
    public var disabledTextColor: UIColor?
    public var disabledBackgroundColor: UIColor?
    public var defaultBackgroundColor: UIColor?
    public var pressedBackgroundColor: UIColor?
    
    public var decoratedButton: CustomView
    
    let font = UIFont.b1sb15
    let padding =  DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
    
    public required init(decoratedButton: CustomView) {
        self.decoratedButton = decoratedButton
        self.defaultBackgroundColor = self.decoratedButton.defaultBackgroundColor
        self.disabledBackgroundColor = self.decoratedButton.disabledBackgroundColor
        self.pressedBackgroundColor = self.decoratedButton.pressedBackgroundColor
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setAppearance() {
        self.titleLabel?.font = self.font
        
        let padding = self.padding
        let horizontalPadding = padding.horizontal
        let verticalPadding = padding.vertical

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        self.setView()

    }
}



//
//  File.swift
//  
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

public class MyButton: DealiButton {
    public var attribute: ButtonAttribute
    
    public init(attribute: ButtonAttribute) {
        self.attribute = attribute
        
        super.init()
    }
    
    override func setAppearance() {
        self.setView(attribute: self.attribute)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(attribute: ButtonAttribute) {
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        self.setBackgroundColor(attribute.defaultBackgroundColor ?? .clear, for: .normal)
        self.setBackgroundColor(attribute.disabledBackgroundColor ?? .clear, for: .disabled)
        
        self.setTitleColor(attribute.defaultTextColor, for: .normal)
        self.setTitleColor(attribute.disabledTextColor, for: .disabled)
        
        self.titleLabel?.font = attribute.font
        
        let padding = attribute.padding
        let horizontalPadding = padding?.horizontal ?? 0
        let verticalPadding = padding?.vertical ?? 0

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

public struct ButtonAttribute {
    public var defaultTextColor: UIColor?
    public var disabledTextColor: UIColor?
    public var defaultBackgroundColor: UIColor?
    public var disabledBackgroundColor: UIColor?
    
    public var font: UIFont?
    public var padding: DealiButtonPadding?
}



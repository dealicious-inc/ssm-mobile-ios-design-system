//
//  LargeConfig.swift
//  
//
//  Created by JohyeonYoon on 2023/09/18.
//

import UIKit

public struct FiiledLargeConfig<State: ButtonState>: ButtonConfigurable {
    public var font: UIFont?
    public var padding: DealiButtonPadding
    
    public init() {
        self.font = UIFont.b1sb15
        self.padding =  DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
    }
}

public struct TextLargeConfig<State: ButtonState>: ButtonConfigurable {
    public var font: UIFont?
    public var padding: DealiButtonPadding
    
    public init() {
        self.font = UIFont.b1sb15
        self.padding =  DealiButtonPadding(horizontal: 16.0, vertical: 15.0)
    }
}

//
//  File.swift
//  
//
//  Created by hoji on 2023/11/02.
//

import Foundation
import UIKit

public protocol DeailTextInputConfigureProtocol {
    var keyboardType: UIKeyboardType { get }
    var textContentType: UITextContentType? { get }
    var isSecureTextEntry: Bool { get }
}

extension DeailTextInputConfigureProtocol {
    var textContentType: UITextContentType? {
        return nil
    }
    
    var isSecureTextEntry: Bool {
        return false
    }
}

struct DeailTextInputTextConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .default
    
    
}

struct DeailTextInputNumberConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .numberPad
    
}

struct DeailTextInputEmailConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .emailAddress
    
}

struct DeailTextInputUrlConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .URL
    
}

struct DeailTextInputPhoneConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .numberPad
    
}

struct DeailTextInputPriceConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .numberPad
    
}

struct DeailTextInputPasswordConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .asciiCapable
    var textContentType: UITextContentType? = .oneTimeCode
    var isSecureTextEntry: Bool = true
}


extension DealiTextInput_v2 {
    public static func text() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputTextConfig())
        return textInput
    }
    
    public static func email() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputEmailConfig())
        return textInput
    }
    
    public static func number() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputNumberConfig())
        return textInput
    }
    
    public static func phone() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputPhoneConfig())
        return textInput
    }
    
    public static func price() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputPriceConfig())
        return textInput
    }
    
    public static func url() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputUrlConfig())
        return textInput
    }
    
    public static func password() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(configure: DeailTextInputPasswordConfig())
        return textInput
    }
    
}

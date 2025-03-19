//
//  File.swift
//  
//
//  Created by hoji on 2023/11/02.
//

import UIKit

public protocol DeailTextInputConfigureProtocol {
    var keyboardType: UIKeyboardType { get }
    var textContentType: UITextContentType? { get }
    var isSecureTextEntry: Bool { get }
    var textInputFormat: ETextInputTextFormatType { get }
}

public extension DeailTextInputConfigureProtocol {
    var textContentType: UITextContentType? {
        return nil
    }
    
    var isSecureTextEntry: Bool {
        return false
    }
}

struct DeailTextInputTextConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .default
    var textInputFormat: ETextInputTextFormatType = .normal
    
}

struct DeailTextInputNumberConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .numberPad
    var textInputFormat: ETextInputTextFormatType = .number
}

struct DeailTextInputEmailConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .emailAddress
    var textInputFormat: ETextInputTextFormatType = .email
}

struct DeailTextInputUrlConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .URL
    var textInputFormat: ETextInputTextFormatType = .url
}

struct DeailTextInputPhoneConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .numberPad
    var textInputFormat: ETextInputTextFormatType = .phone
}

struct DeailTextInputPriceConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .numberPad
    var textInputFormat: ETextInputTextFormatType = .price
}

struct DeailTextInputPasswordConfig: DeailTextInputConfigureProtocol {
    
    var keyboardType: UIKeyboardType = .asciiCapable
    var textContentType: UITextContentType? = .oneTimeCode
    var isSecureTextEntry: Bool = true
    var textInputFormat: ETextInputTextFormatType = .password
}


extension DealiTextInput {
    public static func text() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputTextConfig())
        return textInput
    }
    
    public static func email() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputEmailConfig())
        return textInput
    }
    
    public static func number() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputNumberConfig())
        return textInput
    }
    
    public static func phone() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputPhoneConfig())
        return textInput
    }
    
    public static func price() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputPriceConfig())
        return textInput
    }
    
    public static func url() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputUrlConfig())
        return textInput
    }
    
    public static func password() -> DealiTextInput {
        let textInput = DealiTextInput()
        textInput.configure(configure: DeailTextInputPasswordConfig())
        return textInput
    }
    
}

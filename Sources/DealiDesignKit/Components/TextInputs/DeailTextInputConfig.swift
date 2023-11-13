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
    var textInputFormat: ETextInputTextFormatType { get }
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


public extension DealiTextInput_v2 {
    static func text() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputTextConfig())
        return textInput
    }
    
    static func email() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputEmailConfig())
        return textInput
    }
    
    static func number() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputNumberConfig())
        return textInput
    }
    
    static func phone() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputPhoneConfig())
        return textInput
    }
    
    static func price() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputPriceConfig())
        return textInput
    }
    
    static func url() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputUrlConfig())
        return textInput
    }
    
    static func password() -> DealiTextInput_v2 {
        let textInput = DealiTextInput_v2()
        textInput.configure(with: DeailTextInputPasswordConfig())
        return textInput
    }
    
}

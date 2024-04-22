//
//  DealiCharaterOptions.swift
//
//
//  Created by JohyeonYoon on 4/22/24.
//

import Foundation

public struct DealiCharaterOptions: OptionSet, CaseIterable, Hashable {
    public static var allCases: [DealiCharaterOptions] = [.alphabet, .numeric, .korean, .japanese, .specialCharacter]
    
    public var rawValue: Int
    public var errorMsg: String?
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static var alphabet = DealiCharaterOptions(rawValue: 1<<0)
    public static let numeric = DealiCharaterOptions(rawValue: 1<<1)
    public static let korean = DealiCharaterOptions(rawValue: 1<<2)
    public static let japanese = DealiCharaterOptions(rawValue: 1<<3)
    public static let specialCharacter = DealiCharaterOptions(rawValue: 1<<4)
    
    typealias ErrorMessage = [DealiCharaterOptions: [CharacterSet: String]]
    var errorMessage: ErrorMessage = [:]
}

public extension DealiCharaterOptions {
    
    mutating func setErrorMessage(for option: DealiCharaterOptions, errorMessage: [CharacterSet: String]) {
        self.errorMessage[option] = errorMessage
    }
    
    func errorMessage(for options: DealiCharaterOptions, characterSet: CharacterSet) -> String? {
        var combinedErrorMessage: String = ""
        for option in DealiCharaterOptions.allCases {
            if options.contains(option), let message = errorMessage[option]?[characterSet] {
                combinedErrorMessage.append(message + "\n")
            }
        }
        return combinedErrorMessage.isEmpty ? nil : combinedErrorMessage
    }
}

public extension DealiCharaterOptions {

    var characterSet: CharacterSet {
        var set = CharacterSet()
        
        if self.contains(.alphabet) {
            set.formUnion(CharacterSet.alphabet)
        }
        if self.contains(.numeric) {
            set.formUnion(CharacterSet.decimalDigits)
        }
        if self.contains(.korean) {
            set.formUnion(CharacterSet.korean)
        }
        if self.contains(.japanese) {
            set.formUnion(CharacterSet.japanese)
        }
        if self.contains(.specialCharacter) {
            set.formUnion(CharacterSet.specialCharacter)
        }
        
        return set
    }
    
    var description: String {
        switch self {
        case .alphabet:
            return "알파벳"
        case .numeric:
            return "숫자"
        case .korean:
            return "한글"
        case .japanese:
            return "가나"
        case .specialCharacter:
            return "특수문자"
        default:
            return ""
        }
    }
}

public extension CharacterSet {
    func dealiCharacterOption() -> DealiCharaterOptions? {
        for option in DealiCharaterOptions.allCases {
            if self.isSubset(of: option.characterSet) {
                return option
            }
        }
        
        return nil
    }
}

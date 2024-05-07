//
//  DealiCharaterOptions.swift
//
//
//  Created by JohyeonYoon on 4/22/24.
//

import Foundation

public struct DealiCharacterOptions: OptionSet, CaseIterable, Hashable {
    public static var allCases: [DealiCharaterOptions] = [.alphabet, .numeric, .korean, .japanese, .specialCharacter]
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static var alphabet = DealiCharaterOptions(rawValue: 1<<0)
    public static let numeric = DealiCharaterOptions(rawValue: 1<<1)
    public static let korean = DealiCharaterOptions(rawValue: 1<<2)
    public static let japanese = DealiCharaterOptions(rawValue: 1<<3)
    public static let specialCharacter = DealiCharaterOptions(rawValue: 1<<4)
    
    typealias ErrorMessage = [DealiCharaterOptions: String]
    var errorMsgDict: ErrorMessage = [:]
}

public extension DealiCharaterOptions {
    
    mutating func setErrorMessage(for option: DealiCharaterOptions, errorMessage: String) {
        self.errorMsgDict[option] = errorMessage
    }
    
    func errorMessage(for condition: DealiCharaterOptions, errorCharacterSet: CharacterSet) -> String? {
        for option in DealiCharaterOptions.allCases {
            if errorCharacterSet.isSubset(of: option.characterSet), let message = self.errorMsgDict[option] {
                return message
            }
        }
        return nil
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

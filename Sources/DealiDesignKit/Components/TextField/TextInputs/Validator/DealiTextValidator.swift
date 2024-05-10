//
//  DealiTextValidator.swift
//
//
//  Created by 윤조현 on 2024/04/25.
//

import Foundation

public struct TextValidator {
    
    public enum Condition: Hashable {
        case length(min: Int = 0, max: Int)
        case allow(DealiCharacterOptions)
        case restrict(DealiCharacterOptions)
    }
    
    public var condition: Condition
  
    public private(set) var errorMessage: String?
    
    public mutating func setErrorMessage(for currentText: String) {
        if case let .restrict(option) = condition {
            let currentCharacterSet = CharacterSet(charactersIn: currentText)
            let restrictedSet = option.characterSet.intersection(currentCharacterSet)

            self.errorMessage = option.errorMessage(for: option, errorCharacterSet: restrictedSet)
        }
    }
    
    public init(condition: TextValidator.Condition) {
        self.condition = condition
    }
}

public extension String {
    
    func isValid(for validator: TextValidator) -> Bool {
        switch validator.condition {
        case let .length(_, maxLength):
            return self.count <= maxLength
        case let .allow(option):
            let currentCharacterSet = CharacterSet(charactersIn: self)
            let notAllowedSet = currentCharacterSet.subtracting(option.characterSet)
            return notAllowedSet.isEmpty
            
        case let .restrict(option):
            let currentCharacterSet = CharacterSet(charactersIn: self)
            let restrictedSet = currentCharacterSet.intersection(option.characterSet)
            return restrictedSet.isEmpty
        }
    }
    
    func filteredText(for validator: TextValidator) -> String {
                
        var filteredText: String {
            switch validator.condition {
            case let .length(_, maxLength):
                return String(self.prefix(maxLength))
                
            case let .allow(option):
                return self.unicodeScalars
                    .filter { option.characterSet.contains($0) }
                    .map(String.init)
                    .joined()
                
            case let .restrict(option):
                return self.unicodeScalars
                    .filter { !option.characterSet.contains($0) }
                    .map(String.init)
                    .joined()
            }
        }
        return filteredText
    }
}

public extension Optional where Wrapped == String {
    /// 글자수 넘으면 앞에서 자르도록 옵셔널 스트링 처리
    func truncated(to length: Int) -> String? {
        guard let unwrapped = self else { return nil }
        guard unwrapped.count > length else { return unwrapped }
        return String(unwrapped.prefix(length))
    }
}

public extension CharacterSet {
    static let alphabet = CharacterSet(charactersIn: "a"..."z")
        .union(CharacterSet(charactersIn: "A"..."Z"))
    
    static let korean = CharacterSet(charactersIn: ("ㄱ"..."ㅎ"))
        .union(CharacterSet(charactersIn: "ㅏ"..."ㅣ"))
        .union(CharacterSet(charactersIn: ("가"..."힣")))
        .union(CharacterSet(charactersIn: ("[ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]")))
    
    static let japanese = CharacterSet(charactersIn: "ぁ"..."ゔ")
        .union(CharacterSet(charactersIn: "゠"..."ヲ"))
        .union(CharacterSet(charactersIn: "⺀"..."⿏"))
        .union(CharacterSet(charactersIn: "一"..."龯"))
    
    static let specialCharacter = CharacterSet(charactersIn: " -/:;()₩$&@„«»””“\".,?!`'‘‘’[]{}#%^*+=_\\|~<>€£¥•§₽…¿¡–—‰。、！？")
}

public extension Character {
    private var isSimpleEmoji: Bool {
        guard let firstScalar = self.unicodeScalars.first else {
            return false
        }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    private var isCombinedIntoEmoji: Bool {
        self.unicodeScalars.count > 1 && self.unicodeScalars.first?.properties.isEmoji ?? false
    }
    
    var isEmoji: Bool { self.isSimpleEmoji || self.isCombinedIntoEmoji }
}

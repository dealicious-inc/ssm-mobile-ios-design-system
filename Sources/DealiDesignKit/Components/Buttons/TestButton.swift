//
//  File.swift
//  
//
//  Created by 윤조현 on 2023/09/14.
//

import UIKit


public class TestButton<Config: ButtonConfigurable>: DealiButton {
    
    typealias State = Config.State
    
    public init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setAppearance() {
        self.setBackgroundColor(State.default.backgroundColor, for: .normal)
        self.setBackgroundColor(State.hoverAndPressed.backgroundColor, for: .highlighted)
        self.setBackgroundColor(State.disabled.backgroundColor, for: .disabled)
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        self.setTitleColor(State.default.textColor, for: .normal)
        self.setTitleColor(State.hoverAndPressed.textColor, for: .highlighted)
        self.setTitleColor(State.disabled.textColor, for: .disabled)
        self.titleLabel?.font = Config().font
        self.setPadding()
    }
    
    func setPadding() {
        let padding = Config().padding
        let horizontalPadding = padding.horizontal
        let verticalPadding = padding.vertical

        let internalSpacing = padding.internalSpacing

        self.contentEdgeInsets = .init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        if let leftIconImage = self.leftIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: -internalSpacing, bottom: 0.0, right: internalSpacing)

            self.setImage(leftIconImage.withTintColor(State.default.textColor), for: .normal)
            self.setImage(leftIconImage.withTintColor(State.hoverAndPressed.textColor), for: .highlighted)
            self.setImage(leftIconImage.withTintColor(State.disabled.textColor), for: .disabled)
            self.semanticContentAttribute = .forceLeftToRight
        } else if let rightIconImage = self.rightIconImage {
            self.imageEdgeInsets = .init(top: 0.0, left: internalSpacing, bottom: 0.0, right: -internalSpacing)

            self.setImage(rightIconImage.withTintColor(State.default.textColor), for: .normal)
            self.setImage(rightIconImage.withTintColor(State.hoverAndPressed.textColor), for: .highlighted)
            self.setImage(rightIconImage.withTintColor(State.disabled.textColor), for: .disabled)
            self.semanticContentAttribute = .forceRightToLeft
        }
    }
}

 public protocol ViewConfigurable {
    var font: UIFont? { get }
    var padding: DealiButtonPadding { get }
     
     init()
}

public protocol ButtonConfigurable: ViewConfigurable {
    associatedtype State: ButtonState
}

/*
 버튼 상태에 따른 속성값 저장
 */
public protocol ButtonState {
    static var `default`: Self { get }
    static var hoverAndPressed: Self { get }
    static var disabled: Self { get }
    static var loading: Self { get }
    
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var borderColor: CGColor { get }
}

public struct FiiledLargeConfig<State: ButtonState>: ButtonConfigurable {
        
    public init() {
        self.font = UIFont.b1sb15
        self.padding =  DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
    }
    public var font: UIFont? = UIFont.b1sb15
    public var padding: DealiButtonPadding = DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
}

public enum FilledPrimary01State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary01
        case .hoverAndPressed:
            return DealiColor.primary02
        case .disabled:
            return DealiColor.g40
            
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary04
        case .hoverAndPressed:
            return DealiColor.primary04
        case .disabled:
            return DealiColor.primary04
        }
    }
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}


public enum FilledPrimary02State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.b40
        case .hoverAndPressed:
            return DealiColor.b70
        case .disabled:
            return DealiColor.b20
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary04
        case .hoverAndPressed:
            return DealiColor.primary04
        case .disabled:
            return DealiColor.w50
        }
    }
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}


// MARK: - Large Buttons
final public class btnFilledLargePrimary01: TestButton<FiiledLargeConfig<FilledPrimary01State>> {
        
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final public class btnFilledLargePrimary02: TestButton<FiiledLargeConfig<FilledPrimary02State>> {
        
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final public class btnFilledTonalLargePrimary01: DealiButton {
    
    public init() {
        super.init()
        self.style = .large(style: .tonal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final public class btnOutlineLargePrimary01: DealiButton {
    
    public init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final public class btnTextLargePrimary01: DealiButton {
    
    public init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Medium Buttons

// MARK: - Small Buttons

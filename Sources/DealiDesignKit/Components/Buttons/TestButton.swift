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
        
        if self.style.hasBorder {
            self.layer.borderColor = State.default.borderColor
            self.layer.borderWidth = 1.0
        } else {
            self.layer.borderWidth = 0.0
        }
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

final public class btnFilledTonalLargePrimary01: TestButton<FiiledLargeConfig<FilledTonalPrimary01State>> {
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargePrimary02: TestButton<FiiledLargeConfig<FilledTonalPrimary02State>> {
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargeSecondary01: TestButton<FiiledLargeConfig<FilledTonalSecondary01State>> {
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargeSecondary02: TestButton<FiiledLargeConfig<FilledTonalSecondary02State>> {
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargeSecondary03: TestButton<FiiledLargeConfig<FilledTonalSecondary03State>> {
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



final public class btnOutlineLargePrimary01: TestButton<FiiledLargeConfig<OutlinePrimary01State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargePrimary02: TestButton<FiiledLargeConfig<OutlinePrimary02State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary01: TestButton<FiiledLargeConfig<OutlineSecondary01State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary02: TestButton<FiiledLargeConfig<OutlineSecondary02State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary03: TestButton<FiiledLargeConfig<OutlineSecondary03State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary04: TestButton<FiiledLargeConfig<OutlineSecondary04State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .outlined)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargePrimary01: TestButton<TextLargeConfig<TextPrimary01State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargePrimary02: TestButton<TextLargeConfig<TextPrimary02State>> {

    public override init() {
        super.init()
        self.style = .large(style: .text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary01: TestButton<TextLargeConfig<TextSecondary01State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary02: TestButton<TextLargeConfig<TextSecondary02State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary03: TestButton<TextLargeConfig<TextSecondary03State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary04: TestButton<TextLargeConfig<TextSecondary04State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary05: TestButton<TextLargeConfig<TextSecondary05State>> {
    
    public override init() {
        super.init()
        self.style = .large(style: .text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Medium Buttons

// MARK: - Small Buttons
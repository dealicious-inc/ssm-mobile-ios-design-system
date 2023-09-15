//
//  File.swift
//  
//
//  Created by 윤조현 on 2023/09/13.
//

import UIKit


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

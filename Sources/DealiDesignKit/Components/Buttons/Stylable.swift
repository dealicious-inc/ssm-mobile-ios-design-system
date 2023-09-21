//
//  File.swift
//  
//
//  Created by JohyeonYoon on 2023/09/19.
//

import UIKit

// 테스트중. 안 보셔도 됩니다.
public protocol Stylable {
    
}

extension Stylable where Self: UIButton {
    @discardableResult
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) -> Self {
        self.setBackgroundColor(color, for: state)
        return self
    }
}

extension UIButton: Stylable {
    
}

public class TestButton2: DealiButton {
    public init() {
        
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

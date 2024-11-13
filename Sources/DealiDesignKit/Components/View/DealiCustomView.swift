//
//  DealiCustomView.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 11/13/24.
//

import UIKit

protocol DealiCustomViewProtocol: AnyObject {
    func calculateInstrinsicSize() -> CGSize
}

open class DealiCustomView: UIView, DealiCustomViewProtocol {
    
    open func calculateInstrinsicSize() -> CGSize {
        return .zero
    }
    
    override open var intrinsicContentSize: CGSize {
        return self.calculateInstrinsicSize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

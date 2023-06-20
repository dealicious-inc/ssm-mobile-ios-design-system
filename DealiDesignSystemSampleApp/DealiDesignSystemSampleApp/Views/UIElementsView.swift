//
//  UIElementsView.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 2023/06/22.
//

import UIKit
import DealiDesignKit
import FlexLayout

final class UIElementsView: UIView {
    
    private let flexContainer = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let checkbox = Checkbox()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.addSubview(self.checkbox)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.checkbox.pin.top(12.0).left(12.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  UIControlManager.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit

public class UIControlManager {
    private var exclusiveControls: [UIControl] = []
    private var inclusiveControls: [UIControl] = []
    
    public init() { }

    // MARK: exclusive selection 관리용(ex-RadioButton)
    public func addExclusiveControl(_ control: UIControl) {
        self.exclusiveControls.append(control)
        control.addTarget(self, action: #selector(controlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func controlValueChanged(_ sender: UIControl) {
        for control in exclusiveControls {
            if control != sender {
                control.isSelected = false
            }
        }
    }

    
    // MARK: inclusive selection 관리용(ex-CheckBox)
    public func selectAll() {
        for control in inclusiveControls {
            control.isSelected = true
        }
    }

    public func deselectAll() {
        for control in inclusiveControls {
            control.isSelected = false
        }
    }
}

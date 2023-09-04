//
//  UIControlManager.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit

public class UIControlManager {
    /// 그룹 내 하나만 선택할 수 있는 UIControl 그룹 관리용
    private var exclusiveControls: [UIControl] = []
    /// 그룹 내 여러 개 선택할 수 있는 UIControl 그룹 관리용
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
    
    // MARK: exclusive selection
    public func select(control: UIControl, shouldDeselectOthers: Bool = true) {
        for esControl in exclusiveControls {
            if esControl == control {
                esControl.isSelected = true
            } else if shouldDeselectOthers == true {
                esControl.isSelected = false
            }
        }
    }

    // MARK: selected exclusive 
    public var selectedControls: [UIControl] {
        return self.exclusiveControls.filter({ $0.isSelected == true })
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

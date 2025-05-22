//
//  DealiChip.swift
//  ssm-mobile-ios-design-system
//
//  Created by 윤조현 on 11/7/24.
//

import UIKit

public enum DealiChipStatus: CaseIterable {
    case normal
    case selected
    case disabled
    
    mutating func toggle() {
        guard self != .disabled else { return }
        self = self == .selected ? .normal : .selected
    }
}

public class DealiChip: UIControl {
    
    public var status: DealiChipStatus {
        get {
            guard self.isEnabled else { return .disabled }
            return self.isSelected ? .selected : .normal
            
        } set {
            self.setState(for: newValue)
            self.isSelected = newValue == .selected
            self.isEnabled = newValue != .disabled
            
            switch newValue {
            case .normal:
                self.isSelected = false
                self.isEnabled = true
            case .selected:
                self.isSelected = true
                self.isEnabled = true
            case .disabled:
                self.isSelected = false
                self.isEnabled = false
            }
        }
    }
    
    override public var isEnabled: Bool {
        get {
            return super.isEnabled
        } set {
            super.isEnabled = newValue
            self.setState(for: self.status)
            
        }
    }
    
    override public var isSelected: Bool {
        get {
            return super.isSelected
        } set {
            super.isSelected = newValue
            self.setState(for: self.status)

        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setState(for: self.status)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
    }
    
    func setState(for status: DealiChipStatus) {
        self.updateUI(for: status)
        
    }
    
    func updateUI(for status: DealiChipStatus) {
        
    }

}

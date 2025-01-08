//
//  SystemButton.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/6/24.
//

import UIKit

public enum DealiButtonStatus {
    case normal
    case highlighted
    case disabled
}

public class SystemButton: UIButton {
    
    public var status: DealiButtonStatus {
        get {
            guard self.isEnabled else { return .disabled }
            return self.isHighlighted ? .highlighted : .normal
            
        } set {
            self.setState(for: newValue)
            self.isHighlighted = newValue == .highlighted
            self.isEnabled = newValue != .disabled
            
            switch newValue {
            case .normal:
                self.isHighlighted = false
                self.isEnabled = true
            case .highlighted:
                self.isHighlighted = true
                self.isEnabled = true
            case .disabled:
                self.isHighlighted = false
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
    
    override public var isHighlighted: Bool {
        get {
            return super.isHighlighted
        } set {
            super.isHighlighted = newValue
            self.setState(for: self.status)
            
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setState(for: self.status)
    }
    
    private let highlightView = UIView()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(self.highlightView)
        self.highlightView.then {
            $0.alpha = 0.0
            $0.backgroundColor = .b2
        }.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    func setState(for status: DealiButtonStatus) {
        self.updateUI(for: status)
        
    }
    
    func updateUI(for status: DealiButtonStatus) {
        self.highlightView.alpha = status == .highlighted ? 1.0 : 0.0

        
    }

}

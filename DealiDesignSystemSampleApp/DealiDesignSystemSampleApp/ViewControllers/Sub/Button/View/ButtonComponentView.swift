//
//  ButtonComponentView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 10/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import DealiDesignKit

final class ButtonComponentView: UIView {

    private let titleLabel = UILabel()
    private var buttonArray: [[ClickableComponentButton]]
    
    enum ButtonState: CaseIterable {
        case disabled
        case normal
    }
    
    enum ButtonLayout: CaseIterable {
        static var allCases: [ButtonComponentView.ButtonLayout] = [
            .singleText,
            .textWithIcon(where: [.left]),
            .textWithIcon(where: [.right])
        ]
        
        case singleText
        case textWithIcon(where: [IconLocation])
        
        enum IconLocation: CaseIterable {
            case left
            case right
        }
    }
   
    init(button: ClickableComponentButton) {
        self.buttonArray = ButtonLayout.allCases.map { _ in return ButtonState.allCases.map { _ in return button }}
        
        super.init(frame: .zero)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.text = self.buttonArray.first?.first?.title
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
                
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 20.0
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            $0.left.right.bottom.equalToSuperview()
        }
        
        for (i, _) in ButtonLayout.allCases.enumerated() {
            let stateStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.spacing = 10.0
                $0.alignment = .center
            }
            
            for (j, state) in ButtonState.allCases.enumerated() {
                let button = self.buttonArray[i][j]
                let withStateButton = button.setStatus(state: state)
                stateStackView.addArrangedSubview(withStateButton)
                
            }
            
            stackView.addArrangedSubview(stateStackView)

        }
    }

    private func setStatusButtonView(button: ClickableComponentButton, status: ButtonState) -> UIStackView {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 20
            $0.alignment = .center
        }
        
        for state in ButtonState.allCases {
            let stateButton = button.setStatus(state: state)
            stackView.addArrangedSubview(stateButton)
        }
        let normalButton = button
        stackView.addArrangedSubview(normalButton)

        return stackView
    }
}

fileprivate extension ClickableComponentButton {
    func setStatus(state: ButtonComponentView.ButtonState) -> Self {
        switch state {
        case .normal:
            return self.then { $0.isEnabled = true }
        case .disabled:
            return self.then { $0.isEnabled = false }
        }
    }
}

//
//  SwiftUIBaseViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/17/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift

import DealiDesignKit

final class SwiftUIBaseViewController: UIViewController {
    private let contentStackView = UIStackView()
    private var componentButtonArray: [ClickableComponentButton] = []
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .primary04
        
        self.title = "SwiftUI Base Components"
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
        self.addComponentsButtons()
        self.setComponentBtnsStorerdByTitle()
    }
    
    private func setComponentBtnsStorerdByTitle() {
        let sortedButtons = self.componentButtonArray.sorted { (button1, button2) -> Bool in
            let title1 = button1.title ?? ""
            let title2 = button2.title ?? ""
            return title1 < title2
        }
        
        sortedButtons.forEach { self.contentStackView.addArrangedSubview($0) }
    }
    
    private func addComponents(title: String, actionSelector: Selector) {
        let accordionComponents = DealiControl.btnOutlineLarge03()
        self.componentButtonArray.append(accordionComponents)
        accordionComponents.do {
            $0.title = title
            $0.addTarget(self, action: actionSelector, for: .touchUpInside)
        }
    }
    
    private func addComponentsButtons() {
        self.addComponents(title: "Alert", actionSelector: #selector(alertButtonPressed))
        self.addComponents(title: "Button", actionSelector: #selector(ButtonsButtonPressed))
        self.addComponents(title: "SearchInput", actionSelector: #selector(searchInputButtonPressed))
        self.addComponents(title: "Checkbox", actionSelector: #selector(checkboxButtonPressed))
        self.addComponents(title: "ErrorView", actionSelector: #selector(errorViewButtonPressed))
        self.addComponents(title: "Toast", actionSelector: #selector(toastButtonPressed))
        self.addComponents(title: "ToolTip", actionSelector: #selector(TollTipButtonPressed))
    }
}

// MARK: - Button Actions
extension SwiftUIBaseViewController {
    @objc func alertButtonPressed() {
        self.pushViewController(AlertTestViewController(isSwiftUI: true))
    }
    
    @objc func ButtonsButtonPressed() {
        self.pushViewController(ButtonViewController(isSwiftUI: true))
    }
    
    @objc func searchInputButtonPressed() {
        self.pushViewController(SearchInputViewController(isSwiftUI: true))
    }
    
    @objc func checkboxButtonPressed() {
        self.pushViewController(CheckComponentViewController(isSwiftUI: true))
    }
    
    @objc func errorViewButtonPressed() {
        self.pushViewController(EmptyViewController(isSwiftUI: true))
    }
    
    @objc func toastButtonPressed() {
        self.pushViewController(ToastViewController())
    }
    
    @objc func TollTipButtonPressed() {
        self.pushViewController(ToolTipViewController(isSwiftUI: true))
    }
}

public extension View {
    ///SwiftUI View를 UIKit View로 변환합니다.
    func UIKit() -> UIView {
        let view: UIView = UIHostingController(rootView: self).view
        view.backgroundColor = .clear
        return view
    }
}

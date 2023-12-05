//
//  MainViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/17.
//

import UIKit
import RxSwift

import DealiDesignKit

final class MainViewController: UIViewController {

    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = DealiColor.primary04
        
        self.navigationItem.backButtonTitle = "Home"
        self.title = "iOS Design System Sample App"
        
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
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
        let bottomSheetPopupButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(bottomSheetPopupButton)
        bottomSheetPopupButton.do {
            $0.title = "BottomSheetPopup"
            $0.addTarget(self, action: #selector(bottomSheetPopupButtonPressed), for: .touchUpInside)
        }
        
        let alertButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(alertButton)
        alertButton.do {
            $0.title = "Alert"
            $0.addTarget(self, action: #selector(alertButtonPressed), for: .touchUpInside)
        }
        
        let radioButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(radioButton)
        radioButton.do {
            $0.title = "RadioButton"
            $0.addTarget(self, action: #selector(radioButtonPressed), for: .touchUpInside)
        }
        
        let buttonComponentsButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(buttonComponentsButton)
        buttonComponentsButton.do {
            $0.title = "Button Components"
            $0.addTarget(self, action: #selector(buttonComponentButtonPressed), for: .touchUpInside)
        }
        
        let chipComponentsButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(chipComponentsButton)
        chipComponentsButton.do {
            $0.title = "Chip Components"
            $0.addTarget(self, action: #selector(chipButtonPressed), for: .touchUpInside)
        }
        
        let switchComponentButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(switchComponentButton)
        switchComponentButton.do {
            $0.title = "Toggle/Switch"
            $0.addTarget(self, action: #selector(toggleButtonPressed), for: .touchUpInside)
        }
        
        let sliderBarComponentButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(sliderBarComponentButton)
        sliderBarComponentButton.do {
            $0.title = "SliderBar"
            $0.addTarget(self, action: #selector(sliderBarButtonPressed), for: .touchUpInside)
        }
        
        let textInputComponentsButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(textInputComponentsButton)
        textInputComponentsButton.do {
            $0.title = "TextInput Components"
            $0.addTarget(self, action: #selector(textInputButtonPressed), for: .touchUpInside)
        }
        
        let searchInputComponentsButton = DealiControl.btnOutlineLargeSecondary01()
        contentStackView.addArrangedSubview(searchInputComponentsButton)
        searchInputComponentsButton.do {
            $0.title = "SearchInput Components"
            $0.addTarget(self, action: #selector(searchInputButtonPressed), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

// MARK: - Button Actions
extension MainViewController {
    @objc func fontButtonPressed() {
        self.navigationController?.pushViewController(TypographyViewController(), animated: true)
    }
    
    @objc func buttonComponentButtonPressed() {
        self.navigationController?.pushViewController(ButtonViewController(), animated: true)
    }
    
    @objc func colorButtonPressed() {
        self.navigationController?.pushViewController(ColorViewController(), animated: true)
    }
    
    @objc func bottomSheetPopupButtonPressed() {
        self.navigationController?.pushViewController(BottomSheetPopupTestViewController(), animated: true)
    }
    
    @objc func alertButtonPressed() {
        self.navigationController?.pushViewController(AlertTestViewController(), animated: true)
    }
    
    @objc func radioButtonPressed() {
        self.navigationController?.pushViewController(RadioButtonViewController(), animated: true)
    }

    @objc func chipButtonPressed() {
        self.navigationController?.pushViewController(ChipViewController(), animated: true)
    }
    
    @objc func textInputButtonPressed() {
        self.navigationController?.pushViewController(TextInputViewController(), animated: true)
    }
    
    @objc func searchInputButtonPressed() {
        self.navigationController?.pushViewController(SearchInputViewController(), animated: true)
    }

    @objc func toggleButtonPressed() {
        self.navigationController?.pushViewController(SwitchViewController(), animated: true)
    }
    
    @objc func sliderBarButtonPressed() {
        self.navigationController?.pushViewController(SliderBarViewController(), animated: true)
    }
}

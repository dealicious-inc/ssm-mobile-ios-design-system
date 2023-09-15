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
        
        let alertButton = DealiButton()
        self.view.addSubview(alertButton)
        alertButton.then {
            $0.style = .medium(style: .filled)
            $0.title = "Alert"
            $0.addTarget(self, action: #selector(alertButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        let radioButton = DealiButton()
        self.view.addSubview(radioButton)
        radioButton.then {
            $0.style = .medium(style: .filled)
            $0.title = "RadioButton"
            $0.addTarget(self, action: #selector(radioButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.equalTo(alertButton.snp.bottom).offset(20.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        let buttonComponentsButton = DealiButton()
        self.view.addSubview(buttonComponentsButton)
        buttonComponentsButton.then {
            $0.style = .medium(style: .filled)
            $0.title = "Button Components"
            $0.addTarget(self, action: #selector(buttonComponentButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.equalTo(radioButton.snp.bottom).offset(20.0)
            $0.left.right.equalToSuperview().inset(20.0)
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
    
    @objc func alertButtonPressed() {
        self.navigationController?.pushViewController(AlertTestViewController(), animated: true)
    }
    
    @objc func radioButtonPressed() {
        self.navigationController?.pushViewController(RadioButtonViewController(), animated: true)
    }

}

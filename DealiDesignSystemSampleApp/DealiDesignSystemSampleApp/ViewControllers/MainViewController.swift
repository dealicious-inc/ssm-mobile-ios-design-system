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
    
    @objc func colorButtonPressed() {
        self.navigationController?.pushViewController(ColorViewController(), animated: true)
    }
    
    @objc func alertButtonPressed() {
        self.navigationController?.pushViewController(AlertTestViewController(), animated: true)
    }

}

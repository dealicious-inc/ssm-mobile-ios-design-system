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

    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
        
        self.navigationItem.backButtonTitle = "Home"
        self.title = "iOS Design System Sample App"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.fontButton.addTarget(self, action: #selector(fontButtonPressed), for: .touchUpInside)
        self.mainView.colorButton.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
        self.mainView.uiElementButton.addTarget(self, action: #selector(uiElementsButtonPressed), for: .touchUpInside)
        
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
    
    @objc func uiElementsButtonPressed() {
        self.navigationController?.pushViewController(UIElementsViewController(), animated: true)
    }
}

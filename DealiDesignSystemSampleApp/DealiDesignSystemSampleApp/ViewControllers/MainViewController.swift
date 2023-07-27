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
        
        self.view.backgroundColor = DealiColor.primary01
        
        self.navigationItem.backButtonTitle = "Home"
        self.title = "iOS Design System Sample App"
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

}

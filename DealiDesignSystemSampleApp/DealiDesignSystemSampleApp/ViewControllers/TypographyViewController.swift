//
//  TypographyViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit

final class TypographyViewController: UIViewController {
    let typographyView = TypographyView()
    
    override func loadView() {
        self.view = typographyView
        
        self.title = "Typography"
    }
}

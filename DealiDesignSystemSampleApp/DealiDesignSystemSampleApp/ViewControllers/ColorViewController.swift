//
//  ColorViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Nam Jun Lee on 2023/05/19.
//

import UIKit

final class ColorViewController: UIViewController {
    let colorView = ColorView()
    
    override func loadView() {
        self.view = colorView
        
        self.title = "Color"
    }
}

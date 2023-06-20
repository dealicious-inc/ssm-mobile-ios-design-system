//
//  UIElementsViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 2023/06/22.
//

import UIKit
import FlexLayout

final class UIElementsViewController: UIViewController {
    let uiElementsView = UIElementsView()
    
    override func loadView() {
        self.view = uiElementsView
        self.title = "UI Elements"
    }
    
}

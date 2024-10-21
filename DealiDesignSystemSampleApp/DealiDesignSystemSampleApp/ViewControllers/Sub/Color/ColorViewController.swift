//
//  ColorViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Nam Jun Lee on 2023/05/19.
//

import UIKit
import SwiftUI

/**
 설명: 색상관련 VC
 */
final class ColorViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        self.title = "Color"
        
        let colorView = ColorView()
        let hostingController = UIHostingController(rootView: colorView)
        
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        
        hostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hostingController.didMove(toParent: self)

    }
}

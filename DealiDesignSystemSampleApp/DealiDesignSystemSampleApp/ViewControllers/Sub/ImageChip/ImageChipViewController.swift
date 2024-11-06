//
//  ImageChipViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 11/6/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class ImageChipViewController: UIViewController {
    
    private let imageChip = ImageChip(config: ChipsOutlineConfig.large, color: ChipsOutlineColor.primary01)
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = DealiColor.primary04
        
        self.view.addSubview(imageChip)
        imageChip.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

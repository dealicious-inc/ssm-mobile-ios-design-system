//
//  TabbarChildViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/04/01.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit

class TabbarChildViewController: DealiScrollSegmentTabBarChildViewController {
    
    var viewControllerLog: String = ""
    
    override var isVisible: Bool {
        didSet {
            super.isVisible = isVisible
            if isVisible == true {
                print("\(viewControllerLog) isVisible")
                if self.isInitView == false {
                    self.isInitView = true
                    print("\(viewControllerLog) init")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

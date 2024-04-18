//
//  DealiScrollSegmentTabBarChildViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2024/04/01.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DealiScrollSegmentTabBarChildViewController: UIViewController {

    var isAttachedAsChild: Bool = true

    var isVisible: Bool = false { // 현재 페이지가 보여지고 있다면 true
        didSet {
            if isVisible == true {
                
            }
        }
    }
    
    var isInitView: Bool = false // 최초 뷰 로딩이 되었는지 여부
    /// isVisible가 true이고 isInitView가 true일때 데이터 로드를 위한 rx
//    var visibleView: PublishRelay<EDealiDataLoadType> = PublishRelay()
    
    var screenName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

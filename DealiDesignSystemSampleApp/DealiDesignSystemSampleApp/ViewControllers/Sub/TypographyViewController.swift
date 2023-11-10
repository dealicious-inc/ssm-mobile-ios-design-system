//
//  TypographyViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit
import RxSwift
import RxCocoa

/**
 설명: 폰트 관련
 */
final class TypographyViewController: UIViewController {
    let typographyView = TypographyView()
    
    private var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = typographyView
        
        self.title = "Typography"
    }

}

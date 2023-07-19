//
//  TypographyViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit
import RxSwift
import RxCocoa

final class TypographyViewController: UIViewController {
    let typographyView = TypographyView()
    
    private var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = typographyView
        
        self.title = "Typography"
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.typographyView
//            .fontViewArray
//            .forEach { fontView in
//                fontView.button.rx.tap
//                    .bind { [weak fontView] in
//                        guard let fontView else { return }
//                        
//                        fontView.flex.markDirty()
//                        
//                        if fontView.isOpened {
//                            fontView.label.flex.height(0)
//                        } else {
//                            fontView.label.flex.height(nil)
//                        }
//                        
//                        self.typographyView.setNeedsLayout()
//                        
//                        UIView.animate(withDuration: 0.25) {
//                            self.typographyView.layoutIfNeeded()
//                        }
//                        
//                        fontView.isOpened.toggle()
//                    }
//                    .disposed(by: self.disposeBag)
//            }
//    }
}

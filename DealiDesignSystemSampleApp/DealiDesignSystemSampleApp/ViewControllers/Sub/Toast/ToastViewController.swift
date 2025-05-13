//
//  ToastViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 5/13/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift

final class ToastViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let button = DealiControl.btnFilledLarge03()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button.rx.tap
            .bind(with: self) { owner, _ in
                DLToast.show(message: "테스트 메시지", embeddedIn: owner.view)
            }
            .disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .primary04
        self.setUI()
    }
}

private extension ToastViewController {
    func setUI() {
        
        self.view.addSubview(self.button)
        self.button.then {
            $0.title = "토스트 노출"
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}

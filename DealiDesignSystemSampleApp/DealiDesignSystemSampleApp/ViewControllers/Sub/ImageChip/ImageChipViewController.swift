//
//  ImageChipViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 11/6/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift

final class ImageChipViewController: UIViewController {
    
    private let imageChip = ImageChip()
    private let selectedImageChip = ImageChip()
    private let disabledImageChip = ImageChip()
    
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = DealiColor.primary04
        
        
        let stackView = UIStackView()
        self.view.addSubview(stackView)
        stackView.then {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fill
            $0.isUserInteractionEnabled = true
        }.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
            $0.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide).inset(16.0)
            $0.height.equalTo(46.0)
        }
        
        stackView.addArrangedSubview(imageChip)
        imageChip.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        stackView.addArrangedSubview(selectedImageChip)
        selectedImageChip.status = .selected
        
        
        stackView.addArrangedSubview(disabledImageChip)
        disabledImageChip.status = .disabled
        
        stackView.addArrangedSubview(UIView())

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageChip.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                owner.imageChip.isSelected.toggle()
                
            }
            .disposed(by: self.disposeBag)

    }

}

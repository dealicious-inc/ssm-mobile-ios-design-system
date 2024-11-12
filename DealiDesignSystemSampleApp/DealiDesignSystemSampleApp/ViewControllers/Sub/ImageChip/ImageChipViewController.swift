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
    
    private let imageChip = DealiControl.imgChipLarge01()
    private let selectedImageChip = DealiControl.imgChipLarge01()
    private let disabledImageChip = DealiControl.imgChipLarge01()
    
    private let mediumImageChip = DealiControl.imgChipMedium01()
    private let mediumSelectedImageChip = DealiControl.imgChipMedium01()
    private let mediumDisabledImageChip = DealiControl.imgChipMedium01()
    
    private let smallImageChip = DealiControl.imgChipSmall01()
    private let smallSelectedImageChip = DealiControl.imgChipSmall01()
    private let smallDisabledImageChip = DealiControl.imgChipSmall01()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = DealiColor.primary04
        
        let stackView = UIStackView()
        self.view.addSubview(stackView)
        stackView.then {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
            $0.isUserInteractionEnabled = true
        }.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide).inset(16.0)
        }
        
        
        stackView.addArrangedSubview(imageChip)
        imageChip.rightImage = UIImage.dealiIcon(named: "ic_arrow_right")
        imageChip.imageURL = URL(string: "https://images.unsplash.com/photo-1461988320302-91bde64fc8e4?ixid=2yJhcHBfaWQiOjEyMDd9")
        stackView.addArrangedSubview(selectedImageChip)
        selectedImageChip.status = .selected
        
        stackView.addArrangedSubview(disabledImageChip)
        disabledImageChip.status = .disabled
        
        stackView.addArrangedSubview(mediumImageChip)
        stackView.addArrangedSubview(mediumSelectedImageChip)
        mediumSelectedImageChip.status = .selected
        
        stackView.addArrangedSubview(mediumDisabledImageChip)
        mediumDisabledImageChip.status = .disabled
        
        
        stackView.addArrangedSubview(smallImageChip)
        stackView.addArrangedSubview(smallSelectedImageChip)
        smallSelectedImageChip.status = .selected
        
        stackView.addArrangedSubview(smallDisabledImageChip)
        smallDisabledImageChip.status = .disabled
        
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

        self.mediumImageChip.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                owner.mediumImageChip.isSelected.toggle()
                
            }
            .disposed(by: self.disposeBag)
        
        self.smallImageChip.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                owner.smallImageChip.isSelected.toggle()
                
            }
            .disposed(by: self.disposeBag)


    }

}

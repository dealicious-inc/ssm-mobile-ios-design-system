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
        
        self.view.backgroundColor = UIColor.primary04
        
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
        imageChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D")
        imageChip.customView = CustomTestView()
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
        smallImageChip.customView = CustomTestView()
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


final class CustomTestView: DealiCustomView {
    override func calculateInstrinsicSize() -> CGSize {
        var size = self.titleLabel.intrinsicContentSize
        let width = size.width + 2 + 16
        size.width = width
        return size
    }
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_speechbubble_filled")?.withTintColor(UIColor.primary01)
        }.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2sb14
            $0.textColor = UIColor.primary01
            $0.attributedText = NSMutableAttributedString(string: "5").font($0.font).color(UIColor.primary01).alignment(.left).setLineHeight()
        }.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(2)
            $0.top.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

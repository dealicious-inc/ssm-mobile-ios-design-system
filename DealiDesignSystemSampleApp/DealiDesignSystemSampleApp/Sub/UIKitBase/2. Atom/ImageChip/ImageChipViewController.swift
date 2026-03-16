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
import SwiftUI

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
    
    private let outlineSquareImageChip = DealiControl.chipOutlineSquareImageLarge01()
    private let outlineSquareImageDisabledChip = DealiControl.chipOutlineSquareImageLarge01()
    private let outlineSquareImageWithXChip = DealiControl.chipOutlineSquareImageLarge01()
    private let outlineSquareImageMediumChip = DealiControl.chipOutlineSquareImageMedium01()
    private let outlineSquareImageMediumDisabledChip = DealiControl.chipOutlineSquareImageMedium01()
    private let outlineSquareImageTruncateChip = DealiControl.chipOutlineSquareImageLarge01()
    private let outlineSquareImageMediumTruncateChip = DealiControl.chipOutlineSquareImageMedium01()
    
    private let disposeBag = DisposeBag()
    private let detachBag = AnyDetachBag()
    private let isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.primary04
        self.setUI()
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
        
        self.outlineSquareImageTruncateChip.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                owner.outlineSquareImageTruncateChip.isSelected.toggle()
            }
            .disposed(by: self.disposeBag)
        
        self.outlineSquareImageMediumTruncateChip.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                owner.outlineSquareImageMediumTruncateChip.isSelected.toggle()
            }
            .disposed(by: self.disposeBag)
    }
}

private extension ImageChipViewController {
    func setUI() {
        let contentStackView = self.contentStackView()
        self.view.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
            $0.isUserInteractionEnabled = true
        }.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide).inset(16.0)
        }
    }
    
    func contentStackView() -> UIStackView {
        if self.isSwiftUI {
            return self.swiftUIView()
        } else {
            return self.uiKitView()
        }
    }
    
    func uiKitView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addArrangedSubview(imageChip)
        imageChip.rightImage = UIImage.dealiIcon(named: "ic_arrow_right")
        imageChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D")
        imageChip.slotView = CustomTestView()
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
        smallImageChip.slotView = CustomTestView()
        stackView.addArrangedSubview(smallSelectedImageChip)
        smallSelectedImageChip.status = .selected
        
        stackView.addArrangedSubview(smallDisabledImageChip)
        smallDisabledImageChip.status = .disabled
        
        let outlineSquareTitleLabel = UILabel()
        outlineSquareTitleLabel.text = "chipOutlineSquareImageLarge01"
        outlineSquareTitleLabel.font = .b2sb14
        outlineSquareTitleLabel.textColor = .g80
        stackView.addArrangedSubview(outlineSquareTitleLabel)
        
        stackView.addArrangedSubview(outlineSquareImageChip)
        outlineSquareImageChip.title = "Outline Square"
        outlineSquareImageChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        
        stackView.addArrangedSubview(outlineSquareImageDisabledChip)
        outlineSquareImageDisabledChip.title = "Disabled"
        outlineSquareImageDisabledChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        outlineSquareImageDisabledChip.status = .disabled
        
        stackView.addArrangedSubview(outlineSquareImageWithXChip)
        outlineSquareImageWithXChip.title = "제거 가능(X 탭 시 제거)"
        outlineSquareImageWithXChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        outlineSquareImageWithXChip.rightImage = UIImage.dealiIcon(named: "ic_x_s")
        outlineSquareImageWithXChip.onRightIconTap = { [weak outlineSquareImageWithXChip] in
            guard let chip = outlineSquareImageWithXChip, let stackView = chip.superview as? UIStackView else { return }
            stackView.removeArrangedSubview(chip)
            chip.removeFromSuperview()
        }
        
        let outlineSquareMediumTitleLabel = UILabel()
        outlineSquareMediumTitleLabel.text = "chipOutlineSquareImageMedium01"
        outlineSquareMediumTitleLabel.font = .b2sb14
        outlineSquareMediumTitleLabel.textColor = .g80
        stackView.addArrangedSubview(outlineSquareMediumTitleLabel)
        
        stackView.addArrangedSubview(outlineSquareImageMediumChip)
        outlineSquareImageMediumChip.title = "Outline Square Medium"
        outlineSquareImageMediumChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        
        stackView.addArrangedSubview(outlineSquareImageMediumDisabledChip)
        outlineSquareImageMediumDisabledChip.title = "Disabled"
        outlineSquareImageMediumDisabledChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        outlineSquareImageMediumDisabledChip.status = .disabled
        
        let truncateTitleLabel = UILabel()
        truncateTitleLabel.text = "width 강제 지정 시 말줄임"
        truncateTitleLabel.font = .b2sb14
        truncateTitleLabel.textColor = .g80
        stackView.addArrangedSubview(truncateTitleLabel)
        
        let longText = "이것은 아주 긴 텍스트가 들어갔을 때 말줄임 테스트입니다"
        stackView.addArrangedSubview(outlineSquareImageTruncateChip)
        outlineSquareImageTruncateChip.title = longText
        outlineSquareImageTruncateChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        outlineSquareImageTruncateChip.snp.makeConstraints { $0.width.equalTo(200) }
        
        stackView.addArrangedSubview(outlineSquareImageMediumTruncateChip)
        outlineSquareImageMediumTruncateChip.title = longText
        outlineSquareImageMediumTruncateChip.imageURL = URL(string: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60")
        outlineSquareImageMediumTruncateChip.snp.makeConstraints { $0.width.equalTo(160) }
        
        stackView.addArrangedSubview(UIView())
        return stackView
    }
    
    func swiftUIView() -> UIStackView {
        let stackView = UIStackView()
        
        let viewModel = DealiImageChipViewModel(urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D", text: "이미지칩")
        let result = DealiImageChip(
            viewModel: viewModel,
            action: {
            debugPrint("이미지칩 선택", viewModel.isSelected)
        }, content: {
            HStack(spacing: 2.0) {
                Image.dealiIcon(named: "ic_speechbubble_filled")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color(.primary01))
                    .frame(width: 16, height: 16)
                
                Text("5")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.primary01))
            }
        }, preset: .imgChipLarge01)
        
            .toUIView(embeddedIn: self)
            .detached(by: self.detachBag)
        
        stackView.addArrangedSubview(result.view)
        
        
        let viewModel2 = DealiImageChipViewModel(urlString: nil, text: "이미지칩", status: .disabled)
        let result2 = DealiImageChip(
            viewModel: viewModel2,
            content: {
                EmptyView()
            }, preset: .imgChipMedium01
        )
            .toUIView(embeddedIn: self)
            .detached(by: self.detachBag)
        
        stackView.addArrangedSubview(result2.view)
        
        let outlineSquareViewModel = DealiImageChipViewModel(
            urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60",
            text: "Outline Square"
        )
        let outlineSquareResult = DealiImageChip(
            viewModel: outlineSquareViewModel,
            action: { debugPrint("chipOutlineSquareImageLarge01 탭") },
            content: { EmptyView() },
            preset: .imgOutlineSquareLarge01
        )
        .toUIView(embeddedIn: self)
        .detached(by: self.detachBag)
        stackView.addArrangedSubview(outlineSquareResult.view)
        
        let outlineSquareMediumViewModel = DealiImageChipViewModel(
            urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60",
            text: "Outline Square Medium"
        )
        let outlineSquareMediumResult = DealiImageChip(
            viewModel: outlineSquareMediumViewModel,
            action: { debugPrint("chipOutlineSquareImageMedium01 탭") },
            content: { EmptyView() },
            preset: .imgOutlineSquareMedium01
        )
        .toUIView(embeddedIn: self)
        .detached(by: self.detachBag)
        stackView.addArrangedSubview(outlineSquareMediumResult.view)
        
        let outlineSquareWithXViewModel = DealiImageChipViewModel(
            urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60",
            text: "제거 가능",
            iconName: "ic_x_s"
        )
        let outlineSquareWithXResult = DealiImageChip(
            viewModel: outlineSquareWithXViewModel,
            action: { debugPrint("chipOutlineSquareImageLarge01 (X 버튼) 탭") },
            content: { EmptyView() },
            preset: .imgOutlineSquareLarge01
        )
        .toUIView(embeddedIn: self)
        .detached(by: self.detachBag)
        stackView.addArrangedSubview(outlineSquareWithXResult.view)
        
        stackView.addArrangedSubview(UIView())
        
        return stackView
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

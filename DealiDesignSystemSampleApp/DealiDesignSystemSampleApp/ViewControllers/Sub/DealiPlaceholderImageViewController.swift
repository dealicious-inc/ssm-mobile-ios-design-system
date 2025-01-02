//
//  PlaceholderImageViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 12/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class PlaceholderImageViewController: UIViewController {

    private let changeIamgeViewSizeButton = DealiControl.btnOutlineLarge01()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "DealiPlaceholderImageView Component"
        self.view.backgroundColor = .white
    }

    override func loadView() {
        super.loadView()
        
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing =  16.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
         
        let rectanglePlaceholderImageView01 = DealiPlaceholderImageView()
        contentStackView.addArrangedSubview(rectanglePlaceholderImageView01)
        rectanglePlaceholderImageView01.then {
            $0.imageStyle = .goods
            $0.backgroundStyle = .dark
            $0.viewShape = .rectangle
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        
        let rectanglePlaceholderImageView02ContainerView = UIView()
        contentStackView.addArrangedSubview(rectanglePlaceholderImageView02ContainerView)
        rectanglePlaceholderImageView02ContainerView.then {
            $0.backgroundColor = .g30
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
            $0.height.equalTo(100.0)
        }
        
        let rectanglePlaceholderImageView02 = DealiPlaceholderImageView()
        rectanglePlaceholderImageView02ContainerView.addSubview(rectanglePlaceholderImageView02)
        rectanglePlaceholderImageView02.then {
            $0.imageStyle = .store
            $0.backgroundStyle = .ligth
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10.0)
        }
        
        let circlePlaceholderImageView01 = DealiPlaceholderImageView()
        contentStackView.addArrangedSubview(circlePlaceholderImageView01)
        circlePlaceholderImageView01.then {
            $0.imageStyle = .goods
            $0.backgroundStyle = .dark
            $0.viewShape = .circle
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 100.0, height: 100.0))
        }
        
        let circlePlaceholderImageView02ContainerView = UIView()
        contentStackView.addArrangedSubview(circlePlaceholderImageView02ContainerView)
        circlePlaceholderImageView02ContainerView.then {
            $0.backgroundColor = .g30
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
            $0.height.equalTo(150.0)
        }
        
        let circlePlaceholderImageView02 = DealiPlaceholderImageView()
        circlePlaceholderImageView02ContainerView.addSubview(circlePlaceholderImageView02)
        circlePlaceholderImageView02.then {
            $0.imageStyle = .store
            $0.backgroundStyle = .ligth
            $0.viewShape = .circle
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(25.0)
            $0.width.equalTo(100.0)
        }
        
        contentStackView.addArrangedSubview(self.changeIamgeViewSizeButton)
        self.changeIamgeViewSizeButton.then {
            $0.title = "ImageView Size 변경"
            $0.isSelected = false
            $0.addTarget(self, action: #selector(changeIamgeViewSizeButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }
}


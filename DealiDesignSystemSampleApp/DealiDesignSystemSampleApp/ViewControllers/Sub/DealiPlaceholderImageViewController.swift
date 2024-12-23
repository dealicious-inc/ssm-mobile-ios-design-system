//
//  DealiPlaceholderImageViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 12/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class DealiPlaceholderImageViewController: UIViewController {

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
         
        let placeholderImageView = DealiPlaceholderImageView()
        contentStackView.addArrangedSubview(placeholderImageView)
        placeholderImageView.then {
            $0.configure(emptyType: .goods, colorType: .gray)
//            $0.backgroundColor = .gray
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
    }
}

//
//  BottomSheetTestViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 7/16/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class BottomSheetTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "BottomSheetTest"
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
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        let bottomSheetScrollView = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetScrollView)
        bottomSheetScrollView.then {
            $0.title = "ScrollView BottomSheet"
            $0.addTarget(self, action: #selector(bottomSheetScrollViewPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bottomSheetCollectionView = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetCollectionView)
        bottomSheetCollectionView.then {
            $0.title = "CollectionView BottomSheet"
            $0.addTarget(self, action: #selector(bottomSheetCollectionViewPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bottomSheetView = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetView)
        bottomSheetView.then {
            $0.title = "View BottomSheet"
            $0.addTarget(self, action: #selector(bottomSheetViewPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}

extension BottomSheetTestViewController {
    @objc func bottomSheetScrollViewPressed() {
        debugPrint("bottomSheetScrollViewPressed")
        
        let viewController = ScrollViewBottomSheetViewController()
        self.present(viewController, animated: false)
    }
    
    @objc func bottomSheetCollectionViewPressed() {
        debugPrint("bottomSheetCollectionViewPressed")
        
    }
    
    @objc func bottomSheetViewPressed() {
        debugPrint("bottomSheetViewPressed")
        let viewController = ViewBottomSheetViewController()
        self.present(viewController, animated: false)
    }
    
}

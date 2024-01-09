//
//  BottomSheetPopupTestViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2023/11/21.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class BottomSheetPopupTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "BottomSheetPopup"
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
        
        let bottomSheetPopupButton01 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetPopupButton01)
        bottomSheetPopupButton01.then {
            $0.title = "2버튼 팝업"
            $0.addTarget(self, action: #selector(bottomSheetPopupButton01Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bottomSheetPopupButton02 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetPopupButton02)
        bottomSheetPopupButton02.then {
            $0.title = "1버튼 팝업"
            $0.addTarget(self, action: #selector(bottomSheetPopupButton02Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bottomSheetPopupButton03 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetPopupButton03)
        bottomSheetPopupButton03.then {
            $0.title = "custom 팝업"
            $0.addTarget(self, action: #selector(bottomSheetPopupButton03Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}

extension BottomSheetPopupTestViewController {
    @objc func bottomSheetPopupButton01Pressed() {
        print("bottomSheetPopupButton01Pressed")
        DealiBottomSheetPopup.show(title: "기본 Popup",
                                   message: "기본적인 팝업\n취소, 확인버튼\n타이틀, 메세지가 있는 팝업",
                                   cancelButtonTitle: "취소",
                                   confirmButtonTitle: "확인",
                                   popupPresentingViewController: self,
                                   cancelAction: nil,
                                   confirmAction: nil)
    }
    
    @objc func bottomSheetPopupButton02Pressed() {
        print("bottomSheetPopupButton02Pressed")
        DealiBottomSheetPopup.showConfirm(title: "확인 버튼 Popup",
                                          message: "확인버튼만 있는\n테스트\n팝업 입니다.",
                                          confirmButtonTitle: "확인",
                                          popupPresentingViewController: self,
                                          confirmAction: nil)

    }
    
    @objc func bottomSheetPopupButton03Pressed() {
        print("bottomSheetPopupButton03Pressed")
        
        let customView = UIView()
        customView.do {
            $0.backgroundColor = DealiColor.g05
        }
        
        let colorImageView = UIImageView()
        customView.addSubview(colorImageView)
        colorImageView.then {
            $0.backgroundColor = DealiColor.secondary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 50.0
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100.0, height: 100.0))
        }
        
        DealiBottomSheetPopup.show(insertCustomView: customView,
                                   cancelButtonTitle: "취소",
                                   confirmButtonTitle: "확인",
                                   popupPresentingViewController: self,
                                   cancelAction: nil,
                                   confirmAction: nil)
    }
}

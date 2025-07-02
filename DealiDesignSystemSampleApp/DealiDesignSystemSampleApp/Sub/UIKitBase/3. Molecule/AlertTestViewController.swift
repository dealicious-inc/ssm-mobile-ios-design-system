//
//  AlertTestViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2023/08/14.
//

import UIKit
import DealiDesignKit
import SwiftUI

class AlertTestViewController: UIViewController {
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Alert"
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
        
        let alertButton01 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(alertButton01)
        alertButton01.then {
            $0.title = "2버튼 팝업"
            $0.addTarget(self, action: #selector(alertButton01Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let alertButton02 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(alertButton02)
        alertButton02.then {
            $0.title = "1버튼 팝업"
            $0.addTarget(self, action: #selector(alertButton02Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let alertButton03 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(alertButton03)
        alertButton03.then {
            $0.title = "check box 팝업"
            $0.addTarget(self, action: #selector(alertButton03Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
}

extension AlertTestViewController {
    @objc func alertButton01Pressed() {
        debugPrint("alertButton01Pressed")
        if isSwiftUI {
            let confirmButton = AlertButton(title: "확인",
                                                  action: { print("확인 클릭") })
            let cancelButton = AlertButton(title: "취소",
                                                  action: { print("취소 클릭") })
            let viewModel = AlertViewModel(message: "2버튼 Alert",
                                           confirm: confirmButton,
                                          cancel: cancelButton)
            AlertView(viewModel: viewModel)
            .show(self)
            return
        }
        
        DealiAlert.show(message: "Alert 테스트중",
                        cancelButtonTitle: "취소",
                        confirmButtonTitle: "확인",
                        alertPresentingViewController: self,
                        cancelAction: nil, confirmAction: nil)
    }
    
    @objc func alertButton02Pressed() {
        debugPrint("alertButton02Pressed")
        if isSwiftUI {
            AlertView(title: "1버튼 Alert",
                      message: "1버튼 Alert 테스트",
                      confirm: .init(title: "확인"))
            .show(self)
            return
        }
        
        DealiAlert.showConfirm(title: "1버튼 Alert",
                               message: "확인버튼만 있는 팝업입니다.",
                               confirmButtonTitle: "확인",
                               alertPresentingViewController: self) {
            
        }
    }
    
    @objc func alertButton03Pressed() {
        debugPrint("alertButton03Pressed")
        
        
        if isSwiftUI {
            AlertView(title: "2버튼 체크박스 Alert",
                      message: "2버튼 체크박스 테스트",
                      checkbox: CheckboxView(label: "기본 상태", viewModel: .init()),
                      confirm: .init(title: "확인"),
                      cancel: .init(title: "취소"))
            .show(self)
            
            return
        }
        
        DealiAlert.showCheckBox(title: "Title입니다.",
                                message: "체크박스 팝업 테스트중",
                                checkButtonTitle: "장바구니 다시담기",
                                cancelButtonTitle: "취소",
                                confirmButtonTitle: "확인",
                                alertPresentingViewController: self,
                                cancelAction: nil) { [weak self] isCheckSelected in
            guard let _ = self else { return }
            debugPrint("체크박스 상태 : \(isCheckSelected)")
        }
    }
}

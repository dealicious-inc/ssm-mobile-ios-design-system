//
//  AlertTestViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2023/08/14.
//

import UIKit
import DealiDesignKit

class AlertTestViewController: UIViewController {

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
        
        let alertButton01 = DealiButton()
        contentStackView.addArrangedSubview(alertButton01)
        alertButton01.then {
            $0.style = .large(style: .filled)
            $0.title = "alert01"
            $0.addTarget(self, action: #selector(alertButton01Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
}

extension AlertTestViewController {
    @objc func alertButton01Pressed() {
        print("alertButton01Pressed")

        DealiAlert.show(message: "Alert 테스트중",
                        cancelButtonTitle: "취소",
                        confirmButtonTitle: "확인",
                        alertPresentingViewController: self,
                        cancelAction: nil, confirmAction: nil)
    }
}

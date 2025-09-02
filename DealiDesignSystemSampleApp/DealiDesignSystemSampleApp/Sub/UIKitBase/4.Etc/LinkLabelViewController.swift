//
//  LinkLabelViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 5/28/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

final class LinkLabelViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let oneLinkLabel = UILabel()
    private let multiLineOneLinkLabel = UILabel()
    private let multiLinkLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Link Label"
        self.view.backgroundColor = .primary04

        self.subscribe()
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
        
        contentStackView.addArrangedSubview(self.oneLinkLabel)
        self.oneLinkLabel.then {
            $0.attributedText = NSMutableAttributedString(string: "주문 완료 시, 사장님의 개인정보를 제3자(도매)에게 제공합니다.")
                .font(.b1r15)
                .color(.g70)
                .alignment(.left)
                .applyLinkStyle(for: TextStyleAttributes(text: "제3자(도매)", font: .b1sb15, color: .g70))
                .setLineHeight()
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }

        contentStackView.addArrangedSubview(self.multiLineOneLinkLabel)
        self.multiLineOneLinkLabel.then {
            $0.attributedText = NSMutableAttributedString(string: "1. 개인정보 수집근거 : 개인정보보호법 제15조 제1항 제4호\n2. 수집하는 항목 : 받는사람, 주소, 대표전화\n3. 수집목적 : 구매한 상품 배송\n4. 보유 및 이용 기간 : 배송지 삭제 또는 회원 탈퇴 시까지 (단, 관련 법에 의해 필요한 경우 법에 명시된 기간까지 보유)")
                .font(.b1r15)
                .color(.g50)
                .alignment(.left)
                .applyLinkStyle(for: TextStyleAttributes(text: "관련 법에 의해", font: .b1sb15))
                .setLineHeight()
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.multiLinkLabel)
        self.multiLinkLabel.then {
            $0.attributedText = NSMutableAttributedString(string: "1. 개인정보 수집근거 : 개인정보보호법 제15조 제1항 제4호\n2. 수집하는 항목\n- 사입사 방문시 : 사입사 연락처\n- 택배배송 요청시 : 받는사람, 배송지 주소, 수령인 연락처\n- 계좌이체 결제시 : 입금자명\n3. 수집하는 목적 : 상품 구매 및 배송\n4. 보유기간 : 주문방법 정보 삭제 또는 회원 탈퇴 시까지 (단, 관련 법에 의해 필요한 경우 법에 명시된 기간까지 보유)")
                .font(.b1r15)
                .color(.g100)
                .alignment(.left)
                .applyMultipleLinkStyle(for: [TextStyleAttributes(text: "사입사 방문시", font: .b1sb15, color: .g70),
                                              TextStyleAttributes(text: "택배배송 요청시", font: .b1sb15),
                                              TextStyleAttributes(text: "계좌이체 결제시", font: .b1sb15, color: .g80)])
                .setLineHeight()
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    private func subscribe() {
        self.oneLinkLabel.rx.tapGesture().when(.recognized).bind(with: self) { owner, gesture in
            let location = gesture.location(in: owner.oneLinkLabel)
            if let linkText = owner.oneLinkLabel.tappedLinkText(at: location) {
                print("oneLinkLabel linkText = \(linkText)")
            }
        }.disposed(by: self.disposeBag)
        
        self.multiLineOneLinkLabel.rx.tapGesture().when(.recognized).bind(with: self) { owner, gesture in
            let location = gesture.location(in: owner.multiLineOneLinkLabel)
            if let linkText = owner.multiLineOneLinkLabel.tappedLinkText(at: location) {
                print("multiLineOneLinkLabel linkText = \(linkText)")
            }
        }.disposed(by: self.disposeBag)
        
        self.multiLinkLabel.rx.tapGesture().when(.recognized).bind(with: self) { owner, gesture in
            let location = gesture.location(in: owner.multiLinkLabel)
            if let linkText = owner.multiLinkLabel.tappedLinkText(at: location) {
                print("multiLinkLabel linkText = \(linkText)")
            }
        }.disposed(by: self.disposeBag)
    }

}

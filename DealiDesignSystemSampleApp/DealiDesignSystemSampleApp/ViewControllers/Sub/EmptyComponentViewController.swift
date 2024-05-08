//
//  EmptyComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 5/8/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class EmptyComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar"
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
            $0.spacing =  30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
        
        let messageEmpty = DealiEmptyView()
        contentStackView.addArrangedSubview(messageEmpty)
        messageEmpty.then {
            $0.topMargin = 0.0
            $0.setEmpty(message: "등록된 상품이 없어요.")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconMessageEmpty = DealiEmptyView()
        contentStackView.addArrangedSubview(iconMessageEmpty)
        iconMessageEmpty.then {
            $0.topMargin = 0.0
            $0.setEmpty(imageType: .info, message: "등록된 상품이 없어요.")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconMessageButtonEmpty = DealiEmptyView()
        contentStackView.addArrangedSubview(iconMessageButtonEmpty)
        iconMessageButtonEmpty.then {
            $0.topMargin = 0.0
            $0.setEmpty(imageType: .info, message: "등록된 상품이 없어요.", actionButtonTitle: "재시도")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let refreshIconTitleMessageEmpty = DealiEmptyView()
        contentStackView.addArrangedSubview(refreshIconTitleMessageEmpty)
        refreshIconTitleMessageEmpty.then {
            $0.topMargin = 0.0
            $0.setEmpty(imageType: .refresh, title: "타이틀이 들어가는 영역이예요.", message: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let refreshIconTitleMessageButtonEmpty = DealiEmptyView()
        contentStackView.addArrangedSubview(refreshIconTitleMessageButtonEmpty)
        refreshIconTitleMessageButtonEmpty.then {
            $0.topMargin = 0.0
            $0.setEmpty(imageType: .refresh, title: "타이틀이 들어가는 영역이예요.", message: "데이터를 불러오지 못했어요.\n네트워크 확인 후 새로고침 버튼을 눌러주세요.", actionButtonTitle: "재시도")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
    }

}

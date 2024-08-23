//
//  DataNoticeComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Lee Chang Ho on 8/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class DataNoticeComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Data Notice"
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
        
        let onlyBulletDataNoticeItemViewUIModel = DealiDataNoticeItemViewUIModel(contentStringArray: ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"])
        
        let onlyBulletDataNoticeItemView = DealiDataNoticeItemView()
        contentStackView.addArrangedSubview(onlyBulletDataNoticeItemView)
        onlyBulletDataNoticeItemView.then {
            $0.configure(uiModel: onlyBulletDataNoticeItemViewUIModel)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let onlyNumberDataNoticeItemViewUIModel = DealiDataNoticeItemViewUIModel(contentType: .number, contentStringArray: ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"])
        
        let onlyNumberDataNoticeItemView = DealiDataNoticeItemView()
        contentStackView.addArrangedSubview(onlyNumberDataNoticeItemView)
        onlyNumberDataNoticeItemView.then {
            $0.configure(uiModel: onlyNumberDataNoticeItemViewUIModel)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let rTitleBulletDataNoticeItemViewUIModel = DealiDataNoticeItemViewUIModel(titleType: .regular(title: "타이들"), contentStringArray: ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"])
        
        let rTitleBulletDataNoticeItemView = DealiDataNoticeItemView()
        contentStackView.addArrangedSubview(rTitleBulletDataNoticeItemView)
        rTitleBulletDataNoticeItemView.then {
            $0.configure(uiModel: rTitleBulletDataNoticeItemViewUIModel)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let rTitleNumberDataNoticeItemViewUIModel = DealiDataNoticeItemViewUIModel(titleType: .regular(title: "타이들"), contentType: .number, contentStringArray: ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"])
        
        let rTitleNumberDataNoticeItemView = DealiDataNoticeItemView()
        contentStackView.addArrangedSubview(rTitleNumberDataNoticeItemView)
        rTitleNumberDataNoticeItemView.then {
            $0.configure(uiModel: rTitleNumberDataNoticeItemViewUIModel)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let bTitleBulletDataNoticeItemViewUIModel = DealiDataNoticeItemViewUIModel(titleType: .bold(title: "타이들"), contentStringArray: ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"])
        
        let bTitleBulletDataNoticeItemView = DealiDataNoticeItemView()
        contentStackView.addArrangedSubview(bTitleBulletDataNoticeItemView)
        bTitleBulletDataNoticeItemView.then {
            $0.configure(uiModel: bTitleBulletDataNoticeItemViewUIModel)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let bTitleNumberDataNoticeItemViewUIModel = DealiDataNoticeItemViewUIModel(titleType: .bold(title: "타이들"), contentType: .number, contentStringArray: ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                                                                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"])
        
        let bTitleNumberDataNoticeItemView = DealiDataNoticeItemView()
        contentStackView.addArrangedSubview(bTitleNumberDataNoticeItemView)
        bTitleNumberDataNoticeItemView.then {
            $0.configure(uiModel: bTitleNumberDataNoticeItemViewUIModel)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
    }

}

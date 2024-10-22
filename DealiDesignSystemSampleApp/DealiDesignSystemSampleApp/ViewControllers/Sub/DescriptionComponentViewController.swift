//
//  DescriptionComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Lee Chang Ho on 8/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class DescriptionComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Description Component"
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
         
        let testContentStringArray = ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"]
        
        
        let onlyBulletDescriptionItemView = DealiDescriptionItem()
        contentStackView.addArrangedSubview(onlyBulletDescriptionItemView)
        onlyBulletDescriptionItemView.then {
            $0.configure(model: DealiDescriptionItemModel(style: .bullet, descriptionStringArray: testContentStringArray))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let onlyNumberDescriptionItemView = DealiDescriptionItem()
        contentStackView.addArrangedSubview(onlyNumberDescriptionItemView)
        onlyNumberDescriptionItemView.then {
            $0.configure(model: DealiDescriptionItemModel(style: .numbering, descriptionStringArray: testContentStringArray))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let titleBulletDescriptionItemView = DealiDescriptionItem()
        contentStackView.addArrangedSubview(titleBulletDescriptionItemView)
        titleBulletDescriptionItemView.then {
            $0.configure(model: DealiDescriptionItemModel(style: .bullet, descriptionStringArray: testContentStringArray, title: "타이틀"))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let titleNumberDescriptionItemView = DealiDescriptionItem()
        contentStackView.addArrangedSubview(titleNumberDescriptionItemView)
        titleNumberDescriptionItemView.then {
            $0.configure(model: DealiDescriptionItemModel(style: .numbering, descriptionStringArray: testContentStringArray, title: "타이틀"))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
    }

}

//
//  LabeledTextComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Lee Chang Ho on 8/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class LabeledTextComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Labeled Text Component"
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
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
        }
         
        let labeledTextModelArray = [DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: "ic_plus_ad_forward"),
                                     DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: "ic_plus_ad_forward"),
                                     DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: "ic_repeat"),
                                     DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: "ic_plus_ad_forward"),
                                     DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: "ic_repeat")]
        
        
        let bulletLabeledTextItemView_01 = DealiLabeledText.labeledTextBullet01()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_01)
        bulletLabeledTextItemView_01.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextBullet01"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_01_title = DealiLabeledText.labeledTextBullet01()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_01_title)
        bulletLabeledTextItemView_01_title.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_02 = DealiLabeledText.labeledTextBullet02()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_02)
        bulletLabeledTextItemView_02.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.titleImageName = "ic_info"
            $0.title = "labeledTextBullet02"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_02_title = DealiLabeledText.labeledTextBullet02()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_02_title)
        bulletLabeledTextItemView_02_title.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_01 = DealiLabeledText.labeledTextNumber01()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_01)
        numberLabeledTextItemView_01.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextNumber01"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_01_title = DealiLabeledText.labeledTextNumber01()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_01_title)
        numberLabeledTextItemView_01_title.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_02 = DealiLabeledText.labeledTextNumber02()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_02)
        numberLabeledTextItemView_02.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextNumber02"
            $0.titleImageName = "ic_info"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_02_title = DealiLabeledText.labeledTextNumber02()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_02_title)
        numberLabeledTextItemView_02_title.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_01 = DealiLabeledText.labeledTextIcon01()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_01)
        iconLabeledTextItemView_01.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextIcon01"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_01_title = DealiLabeledText.labeledTextIcon01()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_01_title)
        iconLabeledTextItemView_01_title.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_02 = DealiLabeledText.labeledTextIcon02()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_02)
        iconLabeledTextItemView_02.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextIcon02"
            $0.titleImageName = "ic_info"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_02_title = DealiLabeledText.labeledTextIcon02()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_02_title)
        iconLabeledTextItemView_02_title.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}

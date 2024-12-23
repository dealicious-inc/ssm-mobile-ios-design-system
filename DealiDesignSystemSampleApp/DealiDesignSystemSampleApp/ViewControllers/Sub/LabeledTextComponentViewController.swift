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
        
        let labeledTextAttrivutedModelArray = [DealiLabeledTextModel(attributedMessage: NSMutableAttributedString(string: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")
            .font(.b3r13)
            .color(.g100)
            .alignment(.left)
            .updateMultipleAttributes(for: ["가나다", "카타파"],
                                      fontArray: [.b3sb13, .b3sb13],
                                      colorArray: [.primary01, .secondary01])
                .setLineHeight(), iconName: "ic_plus_ad_forward"),
                                               DealiLabeledTextModel(attributedMessage: NSMutableAttributedString(string: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")
                                                   .font(.b3r13)
                                                   .color(.g100)
                                                   .alignment(.left)
                                                   .updateMultipleAttributes(for: ["가나다라마바사아", "자차카타파하내용"],
                                                                             fontArray: [.b3sb13, .b3sb13],
                                                                             colorArray: [.primary01, .secondary01])
                                                       .setLineHeight(), iconName: "ic_plus_ad_forward"),
                                               DealiLabeledTextModel(attributedMessage: NSMutableAttributedString(string: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")
                                                   .font(.b3r13)
                                                   .color(.g100)
                                                   .alignment(.left)
                                                   .updateMultipleAttributes(for: ["가나다라마바", "아자차카타파하내용"],
                                                                             fontArray: [.b3sb13, .b3sb13],
                                                                             colorArray: [.primary01, .secondary01])
                                                       .setLineHeight(), iconName: "ic_repeat"),
                                               DealiLabeledTextModel(attributedMessage: NSMutableAttributedString(string: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")
                                                   .font(.b3r13)
                                                   .color(.g100)
                                                   .alignment(.left)
                                                   .updateMultipleAttributes(for: ["바사아", "하내용"],
                                                                             fontArray: [.b3sb13, .b3sb13],
                                                                             colorArray: [.primary01, .secondary01])
                                                       .setLineHeight(), iconName: "ic_plus_ad_forward"),
                                               DealiLabeledTextModel(attributedMessage: NSMutableAttributedString(string: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하")
                                                   .font(.b3r13)
                                                   .color(.g100)
                                                   .alignment(.left)
                                                   .updateMultipleAttributes(for: ["마바사아", "카타파하내용"],
                                                                             fontArray: [.b3sb13, .b3sb13],
                                                                             colorArray: [.primary01, .secondary01])
                                                       .setLineHeight(), iconName: "ic_repeat")]
        
        var customLabeledText01ModelArray: [DealiLabeledTextModel] = []
        var customLabeledText02ModelArray: [DealiLabeledTextModel] = []
        for (index, model) in labeledTextModelArray.enumerated() {
            var c01Model = model
            var c02Model = model
            
            let tag01 = DealiTag()
            tag01.text = "태그\(index)"
            c01Model.labeledCustomView = tag01
            
            let tag02 = DealiTag()
            tag02.text = "태그\(index)"
            c02Model.labeledCustomView = tag02
            if index % 3 == 0 {
                tag01.type = .tagFilledSmall01
                tag02.type = .tagFilledSmall01
            } else if index % 3 == 1 {
                tag01.type = .tagOutlineSmall02
                tag02.type = .tagOutlineSmall02
            } else {
                tag01.type = .tagOutlineSmall04
                tag02.type = .tagOutlineSmall04
            }
            
            customLabeledText01ModelArray.append(c01Model)
            customLabeledText02ModelArray.append(c02Model)
        }
        
        
        let bulletLabeledTextItemView_01_title = DealiLabeledText.labeledTextBullet01()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_01_title)
        bulletLabeledTextItemView_01_title.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextBullet01"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_01 = DealiLabeledText.labeledTextBullet01()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_01)
        bulletLabeledTextItemView_01.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_01_custom = DealiLabeledText.labeledTextBullet01()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_01_custom)
        bulletLabeledTextItemView_01_custom.then {
            $0.configure(modelArray: labeledTextAttrivutedModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_02_title = DealiLabeledText.labeledTextBullet02()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_02_title)
        bulletLabeledTextItemView_02_title.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.titleImageName = "ic_info"
            $0.title = "labeledTextBullet02"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let bulletLabeledTextItemView_02 = DealiLabeledText.labeledTextBullet02()
        contentStackView.addArrangedSubview(bulletLabeledTextItemView_02)
        bulletLabeledTextItemView_02.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_01_title = DealiLabeledText.labeledTextNumber01()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_01_title)
        numberLabeledTextItemView_01_title.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextNumber01"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_01 = DealiLabeledText.labeledTextNumber01()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_01)
        numberLabeledTextItemView_01.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_01_custom = DealiLabeledText.labeledTextNumber01()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_01_custom)
        numberLabeledTextItemView_01_custom.then {
            $0.configure(modelArray: labeledTextAttrivutedModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_02_title = DealiLabeledText.labeledTextNumber02()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_02_title)
        numberLabeledTextItemView_02_title.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextNumber02"
            $0.titleImageName = "ic_info"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberLabeledTextItemView_02 = DealiLabeledText.labeledTextNumber02()
        contentStackView.addArrangedSubview(numberLabeledTextItemView_02)
        numberLabeledTextItemView_02.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_01_title = DealiLabeledText.labeledTextIcon01()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_01_title)
        iconLabeledTextItemView_01_title.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextIcon01"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_01 = DealiLabeledText.labeledTextIcon01()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_01)
        iconLabeledTextItemView_01.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_01_custom = DealiLabeledText.labeledTextNumber01()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_01_custom)
        iconLabeledTextItemView_01_custom.then {
            $0.configure(modelArray: labeledTextAttrivutedModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_02_title = DealiLabeledText.labeledTextIcon02()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_02_title)
        iconLabeledTextItemView_02_title.then {
            $0.configure(modelArray: labeledTextModelArray)
            $0.title = "labeledTextIcon02"
            $0.titleImageName = "ic_info"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconLabeledTextItemView_02 = DealiLabeledText.labeledTextIcon02()
        contentStackView.addArrangedSubview(iconLabeledTextItemView_02)
        iconLabeledTextItemView_02.then {
            $0.configure(modelArray: labeledTextModelArray)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let customLabeledTextItemView_01_title = DealiLabeledText.labeledTextCustom01()
        contentStackView.addArrangedSubview(customLabeledTextItemView_01_title)
        customLabeledTextItemView_01_title.then {
            $0.configure(modelArray: customLabeledText01ModelArray)
            $0.title = "labeledTextCustom"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let customLabeledTextItemView_02_title = DealiLabeledText.labeledTextCustom02()
        contentStackView.addArrangedSubview(customLabeledTextItemView_02_title)
        customLabeledTextItemView_02_title.then {
            $0.configure(modelArray: customLabeledText02ModelArray)
            $0.title = "labeledTextCustom02"
            $0.titleImageName = "ic_info"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}

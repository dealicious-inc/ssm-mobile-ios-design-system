//
//  AccordionComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 10/21/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class AccordionComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Accordion Component"
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
            $0.bottom.left.right.equalToSuperview().inset(16.0)
        }
         
        let accordionView01 = DealiAccordionView()
        contentStackView.addArrangedSubview(accordionView01)
        accordionView01.then {
            $0.title = "아코디언 01"
            $0.accordionItemViewArray = self.createAccordionTestViewArray(count: 1)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionView02 = DealiAccordionView()
        contentStackView.addArrangedSubview(accordionView02)
        accordionView02.then {
            $0.title = "아코디언 02"
            $0.accordionItemSpacing = 12.0
            $0.accordionItemViewArray = self.createAccordionTestViewArray(count: 7)
            $0.showAccordion(isOpen: true, animation: false)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionView03 = DealiAccordionView()
        contentStackView.addArrangedSubview(accordionView03)
        accordionView03.then {
            $0.title = "아코디언 03"
            $0.accordionItemViewArray = self.createAccordionTestViewArray(count: 5)
            $0.accordionItemSpacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextBullet01 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextBullet01)
        accordionWithLabeledTextBullet01.then {
            $0.title = "LabeledText Accordion Bullet01"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextBullet01, count: 4)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextBullet02 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextBullet02)
        accordionWithLabeledTextBullet02.then {
            $0.title = "LabeledText Accordion Bullet02"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextBullet02, count: 5)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextNumber01 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextNumber01)
        accordionWithLabeledTextNumber01.then {
            $0.title = "LabeledText Accordion Number01"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextNumber01, count: 6)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextNumber02 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextNumber02)
        accordionWithLabeledTextNumber02.then {
            $0.title = "LabeledText Accordion Number02"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextNumber02, count: 7)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextIcon01 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextIcon01)
        accordionWithLabeledTextIcon01.then {
            $0.title = "LabeledText Accordion Icon01"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextIcon01, count: 6)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextIcon02 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextIcon02)
        accordionWithLabeledTextIcon02.then {
            $0.title = "LabeledText Accordion Icon02"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextNumber02, count: 5)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextTotal = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextTotal)
        accordionWithLabeledTextTotal.then {
            $0.title = "LabeledText Accordion Total"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(labeledPreset: .labeledTextBullet01, title: "Bullet01", count: 1),
                                                 self.createLabeledTextItemModel(labeledPreset: .labeledTextBullet02, title: "Bullet02", titleImageName: "ic_info", count: 2),
                                                 self.createLabeledTextItemModel(labeledPreset: .labeledTextNumber01, title: "Number01", count: 3),
                                                 self.createLabeledTextItemModel(labeledPreset: .labeledTextNumber02, title: "Number02", titleImageName: "ic_info", count: 4),
                                                 self.createLabeledTextItemModel(labeledPreset: .labeledTextIcon01, title: "Icon01", count: 3),
                                                 self.createLabeledTextItemModel(labeledPreset: .labeledTextIcon02, title: "Icon02", titleImageName: "ic_info", count: 2)]
            $0.accordionItemSpacing = 50.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

    private func createAccordionTestViewArray(count: Int) -> [UIView] {
        var accordionTestViewArray: [UIView] = []
        for _ in 0..<count {
            let accordionTestView = UIView()
            accordionTestView.then {
                $0.backgroundColor = self.getRandomColor()
            }.snp.makeConstraints {
                $0.height.equalTo(200.0)
            }
            accordionTestViewArray.append(accordionTestView)
        }
        
        return accordionTestViewArray
    }
    
    private func createLabeledTextItemModel(labeledPreset: DealiLabeledTextPreset, title: String? = nil, titleImageName: String? = nil, count: Int) -> DealiAccordionLabeledTextModel {
        var labeledModelArray: [DealiLabeledTextModel] = []
        for index in 0..<count {
            labeledModelArray.append(DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: ((index % 2 == 0) ? "ic_plus_ad_forward" : "ic_repeat"), numberString: "\(index + 1)."))
        }
        
        return DealiAccordionLabeledTextModel(labeledPreset: labeledPreset, labeledModelArray: labeledModelArray, labeledTitle: title, labeledTitleImageName: titleImageName)
    }
    
    private func getRandomColor() -> UIColor {
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

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
    
    private func getRandomColor() -> UIColor {
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

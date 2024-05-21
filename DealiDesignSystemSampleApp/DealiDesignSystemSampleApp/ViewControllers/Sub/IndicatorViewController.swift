//
//  IndicatorViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 4/17/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class IndicatorViewController: UIViewController {
    
    private let dotsIndicator = DealiIndicator.dots()
    private let dotsWIndicator = DealiIndicator.dotsw()
    
    private let numberIndicator1 = DealiIndicator.number1()
    private let numberIndicator2 = DealiIndicator.number2()
    private let numberIndicator3 = DealiIndicator.number3()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Indicator"
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
            $0.spacing = 50.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        
        contentStackView.addArrangedSubview(self.dotsIndicator)
        self.dotsIndicator.then {
            $0.numberOfPages = 5
            $0.backgroundColor = .yellow
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        
        contentStackView.addArrangedSubview(self.dotsWIndicator)
        self.dotsWIndicator.then {
            $0.numberOfPages = 5
            $0.backgroundColor = .green
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.numberIndicator1)
        self.numberIndicator1.then {
            $0.numberOfPages = 12345
            $0.backgroundColor = .gray
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.numberIndicator2)
        self.numberIndicator2.then {
            $0.numberOfPages = 5
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.numberIndicator3)
        self.numberIndicator3.then {
            $0.numberOfPages = 1234
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }

}

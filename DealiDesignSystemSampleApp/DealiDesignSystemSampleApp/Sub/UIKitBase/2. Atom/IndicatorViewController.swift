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
    private let numberIndicator4 = DealiIndicator.number4()

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
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
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

        // dots 두 개를 함께 조작해 페이지 이동과 점 수 변경 뒤 선택 점 위치를 확인한다
        let dotsControlStackView = UIStackView()
        contentStackView.addArrangedSubview(dotsControlStackView)
        dotsControlStackView.then {
            $0.axis = .horizontal
            $0.spacing = 12.0
        }
        [("이전", -1), ("다음", 1)].forEach { title, step in
            let button = UIButton(type: .system)
            dotsControlStackView.addArrangedSubview(button)
            button.setTitle(title, for: .normal)
            button.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.dotsIndicator.currentPage += step
                self.dotsWIndicator.currentPage += step
            }, for: .touchUpInside)
        }
        [("점 3개", 3), ("점 5개", 5), ("점 0개", 0)].forEach { title, count in
            let button = UIButton(type: .system)
            dotsControlStackView.addArrangedSubview(button)
            button.setTitle(title, for: .normal)
            button.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.dotsIndicator.numberOfPages = count
                self.dotsWIndicator.numberOfPages = count
            }, for: .touchUpInside)
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
        
        contentStackView.addArrangedSubview(self.numberIndicator4)
        self.numberIndicator4.then {
            $0.numberOfPages = 6
            $0.pageChangedHandler = { page in
                print("number4 page changed: \(page + 1)")
            }
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }

}

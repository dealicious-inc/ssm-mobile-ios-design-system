//
//  SliderBarViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2023/11/14.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift
import RxRelay

class SliderBarViewController: UIViewController {
    
    let sliderBar = DealiSliderBar()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemGray
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .darkGray
        }.snp.makeConstraints {
            $0.height.equalTo(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.center.equalToSuperview()
        }
        
        contentView.addSubview(self.sliderBar)
        self.sliderBar.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        let sliderBarWithIndicator = DealiSliderBarWithRangeIndicatorView()
        self.view.addSubview(sliderBarWithIndicator)
        sliderBarWithIndicator.then {
            $0.rangeIndicatorArray = ["1만원", "2만원", "3만원", "5만원", "15만원", "25만원" ]
        }.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "sliderBar"
        
        self.sliderBar.maxValue
            .asDriver()
            .drive { value in
                debugPrint("maxValue: \(value)")
            }
            .disposed(by: self.disposeBag)
        
        
        self.sliderBar.minValue
            .asDriver()
            .drive { value in
                debugPrint("minValue: \(value)")
            }
            .disposed(by: self.disposeBag)
    }
}

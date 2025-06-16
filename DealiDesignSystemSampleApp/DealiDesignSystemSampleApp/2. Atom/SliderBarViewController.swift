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
    let sliderBarWithIndicator = DealiSliderBarWithRangeIndicatorView()

    let testButton = DealiControl.btnTextSmall03()
    let test2Button = DealiControl.btnTextSmall03()

    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemGray
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .white
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
        
        self.view.addSubview(sliderBarWithIndicator)
        sliderBarWithIndicator.then {
            $0.rangeIndicatorArray = ["1만원", "3만원", "5만원", "15만원", "25만원"]
        }.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(30.0)
            $0.left.right.equalToSuperview().inset(50.0)
        }
        
        
        self.view.addSubview(testButton)
        testButton.then {
            $0.title = "0.5 로 옮기기"
        }.snp.makeConstraints {
            $0.top.equalTo(self.sliderBarWithIndicator.snp.bottom).offset(40.0)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(test2Button)
        test2Button.then {
            $0.title = "0.0 로 옮기기"
        }.snp.makeConstraints {
            $0.top.equalTo(self.testButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "sliderBar"
        
//        self.sliderBar.maxValue
//            .asDriver()
//            .drive { value in
//                debugPrint("maxValue: \(value)")
//            }
//            .disposed(by: self.disposeBag)
//        
//        
//        self.sliderBar.minValue
//            .asDriver()
//            .drive { value in
//                debugPrint("minValue: \(value)")
//            }
//            .disposed(by: self.disposeBag)
        
        self.sliderBarWithIndicator.sliderBar.minValue
            .asDriver()
            .drive { value in
                debugPrint("minValue: \(value)")
            }
            .disposed(by: self.disposeBag)
        
        self.sliderBarWithIndicator.sliderBar.minThumbGestureEnded
            .asDriver(onErrorJustReturn: 0)
            .drive { value in
                debugPrint("minThumbView 놨음. 값: \(value)")
            }
            .disposed(by: self.disposeBag)

        
        self.sliderBarWithIndicator.sliderBar.maxThumbGestureEnded
            .asDriver(onErrorJustReturn: 0)
            .drive { value in
                debugPrint("maxThumbView 놨음 값: \(value)")
            }
            .disposed(by: self.disposeBag)
        
        self.sliderBarWithIndicator.sliderBar.maxValue
            .asDriver()
            .drive { value in
                debugPrint("maxValue: \(value)")
            }
            .disposed(by: self.disposeBag)
        
        self.testButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.sliderBar.moveLeftThumb(at: 0.5)
            }
            .disposed(by: self.disposeBag)
        
        self.test2Button.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.sliderBar.moveLeftThumb(at: 0.0)
            }
            .disposed(by: self.disposeBag)
        
    }
}

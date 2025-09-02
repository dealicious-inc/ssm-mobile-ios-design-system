//
//  CheckComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 4/24/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

class CheckComponentViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Check"
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
            $0.spacing = 40.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
        
        let checkBoxStackView = UIStackView()
        contentStackView.addArrangedSubview(checkBoxStackView)
        checkBoxStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
        }
        
        let checkBoxWithTextStackView = UIStackView()
        contentStackView.addArrangedSubview(checkBoxWithTextStackView)
        checkBoxWithTextStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
        }
        
        let checkCircleStackView = UIStackView()
        contentStackView.addArrangedSubview(checkCircleStackView)
        checkCircleStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
        }
        
        let checkCircleWithTextStackView = UIStackView()
        contentStackView.addArrangedSubview(checkCircleWithTextStackView)
        checkCircleWithTextStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
        }
        
        let checkLineStackView = UIStackView()
        contentStackView.addArrangedSubview(checkLineStackView)
        checkLineStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
        }
        
        let checkLineWithTextStackView = UIStackView()
        contentStackView.addArrangedSubview(checkLineWithTextStackView)
        checkLineWithTextStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24.0)
        }
        
        for i in 0..<4 {
            let checkBox = DealiCheckbox()
            checkBoxStackView.addArrangedSubview(checkBox)
            checkBox.then {
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = false
                    $0.isEnabled = false
                case 3:
                    $0.isSelected = true
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 24, height: 24))
            }
            
            let checkBoxWithText = DealiCheckboxWithText()
            checkBoxWithTextStackView.addArrangedSubview(checkBoxWithText)
            checkBoxWithText.do {
                $0.text = "Text"
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = false
                    $0.isEnabled = false
                case 3:
                    $0.isSelected = true
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }
            
            let checkCircle = DealiCheckcircle()
            checkCircleStackView.addArrangedSubview(checkCircle)
            checkCircle.then {
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = true
                    $0.isAd = true
                case 3:
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 24, height: 24))
            }
            
            let checkCircleWithText = DealiCheckcircleWithText()
            checkCircleWithTextStackView.addArrangedSubview(checkCircleWithText)
            checkCircleWithText.do {
                $0.text = "Text"
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = true
                    $0.isAd = true
                case 3:
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }
            
            let checkLine = DealiCheckline()
            checkLineStackView.addArrangedSubview(checkLine)
            checkLine.then {
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = true
                    $0.isAd = true
                case 3:
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 24, height: 24))
            }
            
            let checkLineWithText = DealiChecklineWithText()
            checkLineWithTextStackView.addArrangedSubview(checkLineWithText)
            checkLineWithText.do {
                $0.text = "Text"
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = true
                    $0.isAd = true
                case 3:
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }
        }
        
    }
}

//
//  CheckComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 4/24/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import DealiDesignKit
import Combine

class CheckComponentViewController: UIViewController {
    
    private let isSwiftUI: Bool
    private let testViewModel = CheckboxViewModel(isSelected: true)
    private var cancellables = Set<AnyCancellable>()
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Check"
        self.view.backgroundColor = .white
        
        self.testViewModel.$isSelected
            .sink { isSelected in
                debugPrint("isSelected: \(isSelected)")
            }.store(in: &cancellables)
        
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
        
        if self.isSwiftUI {
            let swiftUIView = self.swiftUIView()
            contentView.addSubview(swiftUIView)
            
            swiftUIView.snp.makeConstraints {
                $0.top.horizontalEdges.equalToSuperview().offset(30)
                $0.bottom.equalToSuperview()
            }
        } else {
            let uiView = self.uiView()
            contentView.addSubview(uiView)
            
            uiView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(10)
                
                $0.bottom.left.right.equalToSuperview()
            }
        }
    }
}

private extension CheckComponentViewController {
    func uiView() -> UIStackView {
        let contentStackView = UIStackView()
        contentStackView.do {
            $0.axis = .vertical
            $0.spacing = 40.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }
        
        let checkboxRowStackView = self.makeRowStackView()
        let checkboxWithTextRowStackView = self.makeRowStackView()
        let checkcircleRowStackView = self.makeRowStackView()
        let checkcircleWithTextRowStackView = self.makeRowStackView()
        let checklineRowStackView = self.makeRowStackView()
        let checklineWithTextRowStackView = self.makeRowStackView()
        
        contentStackView.addArrangedSubview(checkboxRowStackView)
        contentStackView.addArrangedSubview(checkboxWithTextRowStackView)
        contentStackView.addArrangedSubview(checkcircleRowStackView)
        contentStackView.addArrangedSubview(checkcircleWithTextRowStackView)
        contentStackView.addArrangedSubview(checklineRowStackView)
        contentStackView.addArrangedSubview(checklineWithTextRowStackView)
        
        for i in 0..<4 {
            let checkboxContainerView = self.makeComponentContainerView()
            checkboxRowStackView.addArrangedSubview(checkboxContainerView)
            
            let checkbox = DealiCheckbox()
            checkboxContainerView.addSubview(checkbox)
            checkbox.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            }
            
            switch i {
            case 1:
                checkbox.isSelected = true
            case 2:
                checkbox.isEnabled = false
            case 3:
                checkbox.isSelected = true
                checkbox.isEnabled = false
            default:
                checkbox.isSelected = false
            }
            
            let checkboxWithText = DealiCheckboxWithText()
            checkboxWithTextRowStackView.addArrangedSubview(checkboxWithText)
            checkboxWithText.do {
                $0.text = "Text"
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isEnabled = false
                case 3:
                    $0.isSelected = true
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }
            
            let checkcircleContainerView = self.makeComponentContainerView()
            checkcircleRowStackView.addArrangedSubview(checkcircleContainerView)
            
            let checkcircle = DealiCheckcircle()
            checkcircleContainerView.addSubview(checkcircle)
            checkcircle.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            }
            
            switch i {
            case 1:
                checkcircle.isSelected = true
            case 2:
                checkcircle.isSelected = true
                checkcircle.isAd = true
            case 3:
                checkcircle.isEnabled = false
            default:
                checkcircle.isSelected = false
            }
            
            let checkcircleWithText = DealiCheckcircleWithText()
            checkcircleWithTextRowStackView.addArrangedSubview(checkcircleWithText)
            checkcircleWithText.do {
                $0.text = "Text"
                switch i {
                case 1:
                    $0.isSelected = true
                case 2:
                    $0.isSelected = true
                    $0.isAd = true
                case 3:
                    $0.isSelected = true
                    $0.isEnabled = false
                default:
                    $0.isSelected = false
                }
            }
            
            let checklineContainerView = self.makeComponentContainerView()
            checklineRowStackView.addArrangedSubview(checklineContainerView)
            
            let checkline = DealiCheckline()
            checklineContainerView.addSubview(checkline)
            checkline.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            }
            
            switch i {
            case 1:
                checkline.isSelected = true
            case 2:
                checkline.isSelected = true
                checkline.isAd = true
            case 3:
                checkline.isEnabled = false
            default:
                checkline.isSelected = false
            }
            
            let checklineWithText = DealiChecklineWithText()
            checklineWithTextRowStackView.addArrangedSubview(checklineWithText)
            checklineWithText.do {
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
        
        return contentStackView
    }
    
    func swiftUIView() -> UIStackView {
        let contentStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 30.0
            $0.alignment = .leading
            $0.distribution = .equalSpacing
        }
        
        let defaultCheckbox = CheckboxView(label: "기본 상태", viewModel: .init())
        
        contentStackView.addArrangedSubview(defaultCheckbox.UIKit())
        
        let selectedCheckbox = CheckboxView(label: "선택 상태", viewModel: self.testViewModel) 
        contentStackView.addArrangedSubview(selectedCheckbox.UIKit())
        
        let disabledDefaultCheckbox = CheckboxView(label: "비활성 비선택 상태", viewModel: .init(isEnabled: false))
        contentStackView.addArrangedSubview(disabledDefaultCheckbox.UIKit())
        
        let disabledSelectedCheckbox = CheckboxView(label: "비활성 선택 상태", viewModel: .init(isSelected: true, isEnabled: false))
        contentStackView.addArrangedSubview(disabledSelectedCheckbox.UIKit())
        
        let emptyCheckbox = CheckboxView(label: nil, viewModel: .init())
        contentStackView.addArrangedSubview(emptyCheckbox.UIKit())
        
        return contentStackView
    }
    
    
}

private extension CheckComponentViewController {
    
    func makeRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12.0
            $0.alignment = .top
            $0.distribution = .fill
        }
        return rowStackView
    }
    
    func makeComponentContainerView() -> UIView {
        let containerView = UIView()
        containerView.snp.makeConstraints {
            $0.height.equalTo(32.0)
        }
        return containerView
    }
}

//
//  DropdownViewController.swift
//  
//
//  Created by 윤조현 on 2024/07/09.
//

import UIKit
import RxSwift
import DealiDesignKit
import SwiftUI

final class DropdownViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let disposeBag = DisposeBag()
    
    private var test = false
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.setup()
    }
}

private extension DropdownViewController {
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
        if self.isSwiftUI {
            self.setSwiftUI()
        } else {
            self.setUIKit()
        }
    }
    
    func setUIKit() {
        let arrowOpenDropdown = DealiDropdown().then {
            $0.arrowType = .open
            $0.contentText = "옵션별 단가 선택 Lorem Ipsum is simply dummy text of the printing and typesetting industry"
            $0.title = "화살표 open"
            $0.isMandatory = true
            $0.helperText = "helperText: Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            $0.iconImage = UIImage.dealiIcon(named: "ic_check")
        }
        
        arrowOpenDropdown.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self) { owner, _ in
                debugPrint("dropdownTapped")
                owner.test.toggle()
                arrowOpenDropdown.isSelecting.accept(owner.test)
            }
            .disposed(by: self.disposeBag)
        
        let arrowRightDropdown = DealiDropdown().then {
            $0.arrowType = .right
            $0.contentText = "옵션별 단가 선택"
            $0.title = "화살표 right"
        }
        
        let disalbedArrowOpenDropdown = DealiDropdown().then {
            $0.arrowType = .open
            $0.contentText = "옵션별 단가 선택"
            $0.title = "화살표 open & disabled"
            $0.status = .disabled
        }
        
        let disabledArrowRightDropdown = DealiDropdown().then {
            $0.arrowType = .right
            $0.contentText = "옵션별 단가 선택"
            $0.title = "화살표 right & disabled"
            $0.status = .disabled

        }
        
        contentStackView.addArrangedSubview(arrowOpenDropdown)
        contentStackView.addArrangedSubview(arrowRightDropdown)
        contentStackView.addArrangedSubview(disalbedArrowOpenDropdown)
        contentStackView.addArrangedSubview(disabledArrowRightDropdown)
    }
    
    func setSwiftUI() {
        let arrowOpenViewModel = DropdownViewModel(
            title: "화살표 open",
            isMandatory: true,
            contentText: "옵션별 단가 선택 Lorem Ipsum is simply dummy text of the printing and typesetting industry".byCharWrapping,
            helperText: "helperText: Lorem Ipsum is simply dummy text of the printing and typesetting industry.".byCharWrapping,
            icon: DealiIcon.ic_check.swiftUIImage,
            arrowType: .open
        )
        arrowOpenViewModel.onTapped = {
            debugPrint("dropdownTapped")
        }
        
        let arrowRightViewModel = DropdownViewModel(
            title: "화살표 right",
            contentText: "옵션별 단가 선택",
            arrowType: .right
        )
        
        let multipleLineViewModel = DropdownViewModel(
            title: "여러줄 dropdown content 노출",
            contentText: "옵션별 단가 선택 Lorem Ipsum is simply dummy text of the printing and typesetting industry옵션별 단가 선택 Lorem Ipsum is simply dummy text of the printing and typesetting industry".byCharWrapping,
            contentTextLineLimit: 2,
            arrowType: .right
        )
        
        let disabledArrowOpenViewModel = DropdownViewModel(
            status: .disabled,
            title: "화살표 open & disabled",
            contentText: "옵션별 단가 선택",
            arrowType: .open
        )
        
        let disabledArrowRightViewModel = DropdownViewModel(
            status: .disabled,
            title: "화살표 right & disabled",
            contentText: "옵션별 단가 선택",
            arrowType: .right
        )
        
        let numericRightViewModel = DropdownViewModel(
            title: "숫자",
            contentText: "33",
            arrowType: .open,
            sizeType: .numeric
        )
        
        let arrowOpenDropdown = DropdownView(viewModel: arrowOpenViewModel)
            .UIKit()
        let arrowRightDropdown = DropdownView(viewModel: arrowRightViewModel)
            .UIKit()
        let multipleLineDropdown = DropdownView(viewModel: multipleLineViewModel)
            .UIKit()
        let disalbedArrowOpenDropdown = DropdownView(viewModel: disabledArrowOpenViewModel)
            .UIKit()
        let disabledArrowRightDropdown = DropdownView(viewModel: disabledArrowRightViewModel)
            .UIKit()
        let numericDropdown = DropdownView(viewModel: numericRightViewModel)
            .frame(width: 82)
            .UIKit()

        contentStackView.addArrangedSubview(arrowOpenDropdown)
        contentStackView.addArrangedSubview(arrowRightDropdown)
        contentStackView.addArrangedSubview(multipleLineDropdown)
        contentStackView.addArrangedSubview(disalbedArrowOpenDropdown)
        contentStackView.addArrangedSubview(disabledArrowRightDropdown)
        contentStackView.addArrangedSubview(numericDropdown)
    }
}

//
//  DropdownViewController.swift
//  
//
//  Created by 윤조현 on 2024/07/09.
//

import UIKit
import RxSwift
import DealiDesignKit

final class DropdownViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let disposeBag = DisposeBag()
    
    private var test = false

    
    let arrowOpenDropdown = DealiDropdown().then {
        $0.arrowType = .open
        $0.contentText = "옵션별 단가 선택 Lorem Ipsum is simply dummy text of the printing and typesetting industry"
        $0.title = "화살표 open"
        $0.isMandatory = true
        $0.helperText = "helperText: Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        $0.iconImage = UIImage.dealiIcon(named: "ic_check")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrowOpenDropdown.rx.tapGesture()
            .when(.recognized)
            .subscribe(with: self) { owner, _ in
                debugPrint("dropdownTapped")
                owner.test.toggle()
                owner.arrowOpenDropdown.isSelecting.accept(owner.test)
            }
            .disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        self.setUI()
    }
}

private extension DropdownViewController {
    func setUI() {
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
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
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
        
        contentStackView.addArrangedSubview(self.arrowOpenDropdown)
        contentStackView.addArrangedSubview(arrowRightDropdown)
        contentStackView.addArrangedSubview(disalbedArrowOpenDropdown)
        contentStackView.addArrangedSubview(disabledArrowRightDropdown)
        
    }
}

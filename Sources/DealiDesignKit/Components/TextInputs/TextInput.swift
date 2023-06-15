//
//  TextInput.swift
//  
//
//  Created by 윤조현 on 2023/06/15.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

/// 한 줄 텍스트필드
public class TextInput: UIView {
    
    // 필요한 정보
    
    // 1. 상태: - 포커스인 정상, 포커스인 에러, 포커스 아웃 노말, 포커스 아웃 에러
    // 1.1. 포커스 인, 아웃 - 뷰 내에서 처리 가능
    // 1.2. 정상, 에러 - 로직이 들어간다. -> 이건 나가는 text 상태를 보내기만 하자. 에러를 밖에서 받으면 보여주는 처리해주기
    
    // 2. 오른쪽 악세서리 뷰 타입 - 글자수, x 버튼, 없음,
    
    private let disposeBag = DisposeBag()
    
    public struct RX {
        public var isFocused: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    }
    
    public let rx = RX()
    
    let textField = UITextField()
    let inputStackView = UIStackView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.subscribeRx()
        
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = DColor.line04.cgColor
        self.layer.masksToBounds = true
        
        self.addSubview(self.inputStackView)
        self.inputStackView.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview().inset(13.0)
        }
        
        self.inputStackView.addArrangedSubview(self.textField)
        self.textField.do {
            $0.font = DealiFont.b2Bold.font
        }
    }
    
    func subscribeRx() {
        self.textField.rx.controlEvent(.editingDidBegin)
            .map { true }
            .bind(to: self.rx.isFocused)
            .disposed(by: self.disposeBag)
        
        let editingDidEnd = self.textField.rx.controlEvent(.editingDidEnd)
        let editingDidEndOnExit = self.textField.rx.controlEvent(.editingDidEndOnExit)

        Observable.of(editingDidEnd, editingDidEndOnExit).merge()
            .map { false }
            .bind(to: self.rx.isFocused)
            .disposed(by: self.disposeBag)
        
        self.rx.isFocused
            .asDriver()
            .drive { [weak self] isFocused in
                guard let self else { return }
                
                if isFocused {
                    self.layer.borderColor = DColor.line01.cgColor
                } else {
                    self.layer.borderColor = DColor.line04.cgColor

                }
            }
            .disposed(by: self.disposeBag)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

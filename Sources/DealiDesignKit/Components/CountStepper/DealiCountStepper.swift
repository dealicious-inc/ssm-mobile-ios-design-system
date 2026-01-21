//
//  DealiCountStepper.swift
//  DealiDesignKit
//
//  Created by 이창호 on 7/7/25.
//

import UIKit
import RxSwift
import RxCocoa

public class DealiCountStepper: UIView {
    private var disposeBag = DisposeBag()
    
    private let minusButton = SystemButton()
    private let plusButton = SystemButton()
    private let countTextField = UITextField()
    
    private let closeButton = DealiControl.btnTextSmall04()
    
    /// 최소 값
    public var minQuantity: Int = 0
    /// 최대 값
    public var maxQuantity: Int = 999
    public var keyboardAccessoryCloseButtonTitle: String = "닫기" {
        didSet {
            self.closeButton.title = self.keyboardAccessoryCloseButtonTitle
        }
    }
    
    public var currentCount: Int = 0 {
        didSet {
            self.countTextField.text = "\(self.currentCount)"
            self.countTextField.textColor = (self.isEnabled && self.currentCount >= self.minQuantity ? UIColor.g100 : UIColor.g60)
            
            self.minusButton.isEnabled = self.isEnabled && (self.currentCount > self.minQuantity)
            self.plusButton.isEnabled = self.isEnabled && (self.currentCount < self.maxQuantity)
        }
    }
    
    public var changeCountAction: PublishRelay<Int> = .init()
    
    public var isEnabled: Bool = true {
        didSet {
            self.minusButton.isEnabled = self.isEnabled && (self.currentCount > self.minQuantity)
            self.plusButton.isEnabled = self.isEnabled && (self.currentCount < self.maxQuantity)
            self.countTextField.textColor = (self.isEnabled && self.currentCount > 0) ? UIColor.g100 : UIColor.g60
            self.isUserInteractionEnabled = self.isEnabled
        }
    }
    
    public var acceptCountWhenEditingDidEnd: Bool = false
    
    public var delay: Int = 0
    private var pendingChangeRelayWorkItem: DispatchWorkItem?
    
    /// textField empty 상태일 때 default 값 설정
    public var defaultCountWhenEmpty: Int = 0
    
    /// 범위가 벗어났을 때 변경하지 않을지 여부
    public var shouldChangeCharactersWhenOutOfRange: Bool = true
    
    private func changeOptionCount(count: Int, shouldDelay: Bool = false) {
        currentCount = count
        
        guard shouldDelay, delay > 0 else {
            changeCountAction.accept(count)
            return
        }
        
        pendingChangeRelayWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.changeCountAction.accept(self.currentCount)
        }
        
        pendingChangeRelayWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay), execute: workItem)
    }
    
    public init () {
        super.init(frame: .zero)
        
        self.do {
            $0.setCornerRadius(6.0, borderWidth: 1.0, borderColor: .g40)
            $0.backgroundColor = .g40
        }
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 1.0
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.minusButton)
        self.minusButton.then {
            $0.backgroundColor = .primary04
            $0.setImage(DealiIcon.ic_minus.image.resize(CGSize(width: 24.0, height: 24.0)).withTintColor(.g100), for: .normal)
            $0.setImage(DealiIcon.ic_minus.image.resize(CGSize(width: 24.0, height: 24.0)).withTintColor(.g40), for: .disabled)
            $0.isEnabled = (self.currentCount > self.minQuantity)
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 30.0, height: 30.0))
        }
        
        let keyboardAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44.0))
        keyboardAccessoryView.do {
            $0.backgroundColor = .g20
        }
        
        keyboardAccessoryView.addSubview(self.closeButton)
        self.closeButton.then {
            $0.title = "닫기"
        }.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.countTextField)
        self.countTextField.then { [unowned self] in
            $0.textAlignment = .center
            $0.text = "0"
            $0.textColor = UIColor.g100
            $0.font = .sh3r16
            $0.keyboardType = .numberPad
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.delegate = self
            $0.inputAccessoryView = keyboardAccessoryView
            $0.backgroundColor = .primary04
        }.snp.makeConstraints {
            $0.width.equalTo(40.0)
            $0.top.bottom.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.plusButton)
        self.plusButton.then {
            $0.backgroundColor = .primary04
            $0.setImage(DealiIcon.ic_plus.image.resize(CGSize(width: 24.0, height: 24.0)).withTintColor(.g100), for: .normal)
            $0.setImage(DealiIcon.ic_plus.image.resize(CGSize(width: 24.0, height: 24.0)).withTintColor(.g40), for: .disabled)
            $0.isEnabled = (self.currentCount < self.maxQuantity)
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 30.0, height: 30.0))
        }
        
        self.subscribeRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBorder(isEditing: Bool) {
        self.setCornerRadius(6.0, borderWidth: 1.0, borderColor: isEditing ? .g100 : .g40)
    }
    
    private func subscribeRx() {
        self.disposeBag = DisposeBag()
        
        self.minusButton.rx.tap.asSignal().emit(with: self) { owner, _ in
            if owner.currentCount > owner.minQuantity {
                owner.changeOptionCount(count: (owner.currentCount - 1), shouldDelay: true)
            }
        }.disposed(by: self.disposeBag)
        
        self.plusButton.rx.tap.asSignal().emit(with: self) { owner, _ in
            if owner.currentCount < owner.maxQuantity {
                owner.changeOptionCount(count: (owner.currentCount + 1), shouldDelay: true)
            }
            
        }.disposed(by: self.disposeBag)
        
        self.countTextField.rx.controlEvent(.editingChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                if !self.acceptCountWhenEditingDidEnd {
                    if let text = self.countTextField.text, !text.isEmpty {
                        self.changeOptionCount(count: Int((self.countTextField.text ?? "0")) ?? 0)
                    } else {
                        self.changeOptionCount(count: self.defaultCountWhenEmpty)
                    }
                }
            }).disposed(by: self.disposeBag)
        
        self.countTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.setBorder(isEditing: true)
            }).disposed(by: self.disposeBag)
        
        
        Observable.merge(
            self.countTextField.rx.controlEvent(.editingDidEndOnExit).asObservable(),
            self.countTextField.rx.controlEvent(.editingDidEnd).asObservable()
        )
        .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            self.setBorder(isEditing: false)
            if self.acceptCountWhenEditingDidEnd {
                if let text = self.countTextField.text, !text.isEmpty {
                    self.changeOptionCount(count: Int((self.countTextField.text ?? "0")) ?? 0)
                } else {
                    self.changeOptionCount(count: self.defaultCountWhenEmpty)
                }
            }
        }).disposed(by: self.disposeBag)
        
        self.closeButton.rx.tap.asSignal().emit(with: self) { owner, _ in
            owner.endEditing(true)
            owner.setBorder(isEditing: false)
        }.disposed(by: self.disposeBag)
    }
    
}

extension DealiCountStepper: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard self.shouldChangeCharactersWhenOutOfRange else {
            return true
        }
        
        let text: NSString = textField.text! as NSString
        let strings = text.replacingCharacters(in: range, with: string)
        
        let quantity = Int(strings) ?? 0
        
        if quantity < self.minQuantity {
            self.changeOptionCount(count: self.minQuantity)
            
            return false
        } else if quantity > self.maxQuantity {
            self.changeOptionCount(count: self.maxQuantity)
            
            return false
        }
        
        return true
    }
}

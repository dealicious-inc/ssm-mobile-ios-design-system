//
//  Created by johyeonyoon on 2023/06/16.
//  Copyright © 2015 Dealicious Inc. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

/// 한 줄 텍스트필드
public final class DealiTextInput: UIView {
    
    // 필요한 정보
    
    // 1. 상태: - 포커스인 정상, 포커스인 에러, 포커스 아웃 노말, 포커스 아웃 에러
    // 1.1. 포커스 인, 아웃 - 뷰 내에서 처리
    // 1.2. 정상, 에러 - 로직이 들어간다. -> 이건 나가는 text 상태를 보내기만 하자. 에러를 밖에서 받으면 보여주는 처리해주기
    
    // 2. 오른쪽 악세서리 뷰 타입 - 글자수, 체크, x 버튼, 없음,
    // 2.1. 항상 있어야 하는 경우 - 이건 시간 나타내는 뷰만 해당
    // 2.2. 포커스아웃 & 에러 상황에서만 뜨는 경우 - 붉은 x, 경고 아이콘
    // 2.3. 포커스아웃 & 정상 상황에서만 뜨는 경우 - 체크 아이콘
    
    private let disposeBag = DisposeBag()
    
    public struct RX {
        public var isFocused: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        public var isError: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    }

    public let reactive = RX()

    public var placeholder: String? {
        didSet {
            guard let placeholder else { return }
            let attributes: [NSAttributedString.Key: Any] = [
                .font: DealiFont.b2Regular.systemFont,
                .foregroundColor: DealiColor.text03
            ]
            self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
    public var text: String? {
        get {
            self.textField.text
        } set {
            self.textField.text = newValue
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 46.0)
    }

    
    public enum ErrorAccessoryViewType {
        /// 붉은 X 아이콘
        case xIcon
        /// caution 아이콘
        case errorIcon
        /// 나중을 위한 커스텀타입
        case custom
        /// 없음 (기본값)
        case none
    }
    
    public var errorViewType: ErrorAccessoryViewType = .none {
        didSet {
            self.errorView.subviews.forEach {
                $0.removeFromSuperview()
            }
            
            self.errorView.addSubview(errorView(for: self.errorViewType))
        }
    }
    
    var textField = UITextField()
    private let inputStackView = UIStackView()
    private let deleteButton = UIButton()
    private let errorView = UIView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.subscribeRx()
        
        self.layer.cornerRadius = 6.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = DealiColor.line04.cgColor
        self.layer.masksToBounds = true
        
        self.addSubview(self.inputStackView)
        self.inputStackView.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.0)
            $0.right.equalToSuperview().inset(2.0)
            $0.centerY.equalToSuperview()
        }
        
        self.inputStackView.addArrangedSubview(self.textField)
        self.textField.do {
            $0.font = .b2sb14
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }
        
        self.inputStackView.addArrangedSubview(self.deleteButton)
        self.inputStackView.setCustomSpacing(-2.0, after: self.textField)
        self.deleteButton.then {
            $0.setImage(UIImage(named: "ic_x_16_ver01", in: Bundle.module, compatibleWith: nil), for: .normal)
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 44.0, height: 44.0))
        }
        
        self.inputStackView.addArrangedSubview(self.errorView)
        self.errorView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        self.errorView.addSubview(errorView(for: self.errorViewType))
    }
    
    private func errorView(for errorViewType: ErrorAccessoryViewType) -> UIView {
        
        let imageView = UIImageView()
        
        switch errorViewType {
            
        default: break
            
        }
        
        imageView.then {
            $0.image = UIImage(named: "ic_error_filled_24_ver01", in: Bundle.module, compatibleWith: nil)
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        return imageView
    }
    
    func setNormalAppearance(isFocused: Bool) {
        if isFocused {
            self.layer.borderColor = DealiColor.line01.cgColor
            self.deleteButton.isHidden = false
        } else {
            self.layer.borderColor = DealiColor.line04.cgColor
            self.deleteButton.isHidden = true
        }
        
    }
    
    func subscribeRx() {
        let editingDidBegin = self.textField.rx.controlEvent(.editingDidBegin).map { true }
        let editingDidEnd = self.textField.rx.controlEvent(.editingDidEnd).map { false }
        let editingDidEndOnExit = self.textField.rx.controlEvent(.editingDidEndOnExit).map { false }

        Observable.of(editingDidBegin, editingDidEnd, editingDidEndOnExit).merge()
            .bind(to: self.reactive.isFocused)
            .disposed(by: self.disposeBag)

        self.reactive.isFocused
            .asDriver()
            .drive { [weak self] isFocused in
                guard let self else { return }
                
                self.setNormalAppearance(isFocused: isFocused)
            }
            .disposed(by: self.disposeBag)
        
        self.reactive.isError
            .asDriver()
            .distinctUntilChanged()
            .drive { [weak self] isError in
                guard let self else { return }
                self.errorView.isHidden = !isError
                
                if isError {
                    self.layer.borderColor = DealiColor.error.cgColor
                } else {
                    self.setNormalAppearance(isFocused: self.reactive.isFocused.value)
                }
            }
            .disposed(by: self.disposeBag)
        
        self.deleteButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.textField.text = nil
                self.textField.sendActions(for: .valueChanged)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()

        return self.textField.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DealiTextInput: UITextInputTraits {
    
    public var returnKeyType: UIReturnKeyType {
        get {
            self.textField.returnKeyType
        } set {
            self.textField.returnKeyType = newValue
        }
    }
    
    public var isSecureTextEntry: Bool {
        get {
            self.textField.isSecureTextEntry
        } set {
            self.textField.isSecureTextEntry = newValue
        }
    }

}

public extension Reactive where Base: DealiTextInput {
    var inputText: ControlProperty<String?> {
        return base.textField.rx.text
    }
    
    func controlEvent(_ controlEvents: UIControl.Event) -> ControlEvent<()> {
        return base.textField.rx.controlEvent(controlEvents)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TextInputPreview: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                Text("DealiTextInput Test")
                    .font(.system(size: 30.0, weight: .bold))
                
                UIViewPreview {
                    let textInput = DealiTextInput().then {
                        $0.placeholder = "테스트"}

                    return textInput
                
                }
                
                UIViewPreview {
                    let textInput = DealiTextInput()
                    textInput.placeholder = "비밀번호"
                    textInput.isSecureTextEntry = true
                    return textInput
                }
                
            }
            .padding(.vertical, 50.0)
            .padding(.horizontal, 20.0)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

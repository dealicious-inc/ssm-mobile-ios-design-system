//
//  RadioButtonWithText.swift
//  
//
//  Created by 윤조현 on 2023/06/28.
//

import UIKit
import RxSwift
import RxGesture

/// 디자인시스템 RadioButton + Text 적용
///
/// 두 가지 방법으로 사용가능
/// 1. 초기화 시에 `title`과  `status`  정의
/// ```swift
/// let myView = RadioButtonWithText(title: testString, status: .normal(isSelected: true))
/// ```
/// 2. 초기화 이후 `style`과  `title` 속성 설정
///```swift
/// let myView = RadioButtonWithText()
/// myView.title = testString
/// myView.status = .disabled
/// ```
public final class RadioButtonWithText: UIView {
    
    public var status: RadioButtonStatus {
        get {
            self.radioButton.status
        } set {
            self.radioButton.status = newValue
            self.setAppearance(for: newValue)
        }
    }
    
    public var title: String? {
        get {
            self.titleLabel.text
        } set {
            self.titleLabel.text = newValue
            self.titleLabel.sizeToFit()
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public var isSelected: Bool {
        switch self.status {
        case .normal(let isSelected):
            return isSelected
        case .disabled:
            return false
        }
    }
    
    private let disposeBag = DisposeBag()
    private let titleLabel = UILabel()
    private let radioButton = RadioButton()
    
    public override var intrinsicContentSize: CGSize {
        let width = self.titleLabel.frame.width + 24.0 + 8.0
        let height = self.titleLabel.frame.height
        return CGSize(width: width, height: max(24.0, height))
    }
    
    public convenience init(title: String, status: RadioButtonStatus = .normal(isSelected: false)) {
        self.init(frame: .zero)
        
        self.title = title
        self.status = status
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.radioButton)
        self.radioButton.isUserInteractionEnabled = false
        self.radioButton.snp.makeConstraints {
            $0.top.bottom.left.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.font = DealiFont.b3Regulr.systemFont
            $0.text = self.title
        }.snp.makeConstraints {
            $0.left.equalTo(self.radioButton.snp.right).offset(8.0)
            $0.centerY.equalToSuperview()
        }
        
        self.setAppearance(for: self.status)
        self.subscribeRx()
    }
    
    private func subscribeRx() {
        self.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.status.changeStatus()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setAppearance(for status: StatusToggable) {
        self.titleLabel.textColor = status.textColor
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct RadioButtonWithTextPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"
    static var disableState: CheckboxStatus = .disabled

    static var previews: some View {
        VStack(alignment: .leading) {

            Text("RadioButtonWithText")
            UIViewPreview {
                let radioButtonWithText = RadioButtonWithText(title: testString, status: .normal(isSelected: true))
                return radioButtonWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let radioButtonWithText = RadioButtonWithText()
                radioButtonWithText.title = testString
                return radioButtonWithText
            }
            .padding(.bottom, 10.0)

            UIViewPreview {
                let radioButtonWithText = RadioButtonWithText()
                radioButtonWithText.title = testString
                radioButtonWithText.status = .disabled
                return radioButtonWithText
            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

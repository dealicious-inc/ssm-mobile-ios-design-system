//
//  SwiftUIView.swift
//  
//
//  Created by JohyeonYoon on 2023/06/22.
//

import UIKit
import RxSwift
import Then
import SnapKit

/**
 설명: UI Elements - Checkbox + Text
 */
public final class CheckboxWithText: UIView {
    
    var status: CheckboxStatus {
        get {
            self.checkbox.status
        } set {
            self.checkbox.status = newValue
            self.setAppearance(for: newValue)
        }
    }
    
    public var isSelected: Bool {
        get {
            return self.status.isSelected
        } set {
            self.status.isSelected = newValue
            self.setAppearance(for: self.status)
        }
    }
    
    public var isEnable: Bool {
        get {
            return self.status.isEnable
        } set {
            self.status.isEnable = newValue
            self.setAppearance(for: self.status)
        }
    }
    
    public var title: String? {
        get {
            self.titleLabel.text
        } set {
            self.titleLabel.text = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public var font: UIFont? {
        get {
            self.titleLabel.font
        } set {
            self.titleLabel.font = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    
    private let disposeBag = DisposeBag()
    private let titleLabel = UILabel()
    private let checkbox = Checkbox()
    
    public override var intrinsicContentSize: CGSize {
        self.titleLabel.sizeToFit()
        
        let width = self.titleLabel.frame.width + 24.0 + 8.0
        let height = self.titleLabel.frame.height
        return CGSize(width: width, height: max(24.0, height))
    }
    
    public convenience init(title: String, status: CheckboxStatus = .init()) {
        self.init(frame: .zero)
        
        self.title = title
        self.status = status
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.checkbox)
        self.checkbox.isUserInteractionEnabled = false
        self.checkbox.snp.makeConstraints {
            $0.top.bottom.left.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.font = .b2r14
            $0.text = self.title
        }.snp.makeConstraints {
            $0.left.equalTo(self.checkbox.snp.right).offset(8.0)
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
    
    private func setAppearance(for status: CheckboxStatus) {
        self.titleLabel.textColor = status.textColor
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CheckboxWithTextPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"

    static var previews: some View {
        VStack(alignment: .leading) {
            Text("체크박스 + 텍스트")
            UIViewPreview {
                let checkboxWithText = CheckboxWithText(title: testString, status: .init())
                return checkboxWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                checkboxWithText.isSelected = true
                return checkboxWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                checkboxWithText.isEnable = false
                return checkboxWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                checkboxWithText.isEnable = false
                checkboxWithText.isSelected = true

                return checkboxWithText
            }
            .padding(.bottom, 10.0)

        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

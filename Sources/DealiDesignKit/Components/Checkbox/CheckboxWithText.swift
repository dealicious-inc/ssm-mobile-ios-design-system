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
    
    public var status: CheckboxStatus {
        get {
            self.checkbox.status
        } set {
            self.checkbox.status = newValue
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
    private let checkbox = Checkbox()
    
    public override var intrinsicContentSize: CGSize {
        let width = self.titleLabel.frame.width + 24.0 + 8.0
        let height = self.titleLabel.frame.height
        return CGSize(width: width, height: max(24.0, height))
    }
    
    public convenience init(title: String, status: CheckboxStatus = .normal(isSelected: false)) {
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
            $0.font = DealiFont.b3Regulr.font
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

struct CheckboxPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"
    static var disableState: CheckboxStatus = .disabled

    static var previews: some View {
        VStack(alignment: .leading) {
            Text("체크박스")

            HStack {
                UIViewPreview {
                    let checkbox = Checkbox()
                    return checkbox
                }

                UIViewPreview {
                    let checkbox = Checkbox()
                    checkbox.status = .normal(isSelected: true)
                    return checkbox
                }

                UIViewPreview {
                    let checkbox = Checkbox()
                    checkbox.status = .disabled
                    return checkbox
                }

            }

            Text("체크박스 + 텍스트")
            UIViewPreview {
                let checkboxWithText = CheckboxWithText(title: testString, status: .normal(isSelected: false))
                return checkboxWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                return checkboxWithText
            }
            .padding(.bottom, 10.0)

            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                checkboxWithText.status = .disabled
                return checkboxWithText
            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

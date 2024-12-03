//
//  Checkbox.swift
//
//
//  Created by 윤조현 on 2023/06/20.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxGesture
import RxCocoa

/**
 설명: Checkbox 상태관리용 객체
 */
public struct CheckboxStatus {
    public init(isEnable: Bool = true, isSelected: Bool = false) {
        self.isEnabled = isEnable
        self.isSelected = isSelected
    }
    
    var isEnabled: Bool = true
    var isSelected: Bool = false
    
    var imageName: String {
        switch self.isEnabled {
        case true:
            return self.isSelected ? "ic_checkbox_on" : "ic_checkbox_off"
        case false:
            return  self.isSelected ? "ic_checkbox_ondisable" : "ic_checkbox_disable"
        }
    }
    
    mutating func changeStatus() {
        guard self.isEnabled else { return }
        self.isSelected.toggle()
    }
    
    var textColor: UIColor {
        switch self.isEnabled {
        case true:
            return .g100
        case false:
            return .g50
        }
    }
}

/**
 설명: UI Elements - Checkbox
 */
public class DealiCheckbox: UIView {
    
    var status: CheckboxStatus = .init() {
        didSet {
            self.setAppearance(for: status)
        }
    }
    
    public let valueChanged: PublishRelay<Bool> = .init()
    
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    private let disposeBag = DisposeBag()
    private let imageView = UIImageView()
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 24.0 + self.contentInset.top + self.contentInset.bottom,
                      height: 24.0 + self.contentInset.left + self.contentInset.right)
    }
    
    public var isSelected: Bool {
        get {
            return self.status.isSelected
        } set {
            self.status.isSelected = newValue
            self.setAppearance(for: self.status)
        }
    }
    
    public var isEnabled: Bool {
        get {
            return self.status.isEnabled
        } set {
            self.status.isEnabled = newValue
            self.setAppearance(for: self.status)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.center.equalToSuperview()
        }
        
        self.setAppearance(for: self.status)
        self.subscribeRx()
    }
    
    func subscribeRx() {
        self.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.status.changeStatus()
                self.valueChanged.accept(self.isSelected)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setAppearance(for status: CheckboxStatus) {
        self.imageView.image = UIImage(named: status.imageName, in: Bundle.module, compatibleWith: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CheckboxPreview: PreviewProvider {
    
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("체크박스")
                .font(.headline)
            
            Group {
                Text("활성 + 미선택")
                UIViewPreview {
                    let checkbox = DealiCheckbox()
                    return checkbox
                }
                
                Text("활성 + 선택")
                UIViewPreview {
                    let checkbox = DealiCheckbox()
                    checkbox.isSelected = true
                    return checkbox
                }
                
                Text("비활성 + 미선택")
                UIViewPreview {
                    let checkbox = DealiCheckbox()
                    checkbox.isEnabled = false
                    return checkbox
                }
                
                Text("비활성 + 선택")
                UIViewPreview {
                    let checkbox = DealiCheckbox()
                    checkbox.isEnabled = false
                    checkbox.isSelected = true
                    return checkbox
                }
            }
            
            Group {
                Text("contentInset 준 경우")
                UIViewPreview {
                    let checkbox = DealiCheckbox()
                    checkbox.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
                    checkbox.backgroundColor = .yellow
                    return checkbox
                }
            }
        }
    }
}
#endif


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

protocol CheckboxStatusToggable {
    static func normal(isSelected: Bool) -> Self
    static func disabled(isSelected: Bool) -> Self
    
    mutating func changeStatus()
    var imageName: String { get }
    var textColor: UIColor { get }
    var isSelected: Bool { get set }
}

@frozen
public enum CheckboxStatus: Equatable, CheckboxStatusToggable {
    case normal(isSelected: Bool)
    case disabled(isSelected: Bool = false)
    
    mutating func changeStatus() {
        switch self {
        case .normal:
            self.isSelected.toggle()
        default:
            break
        }
    }
    
    var isSelected: Bool {
        get {
            switch self {
            case .normal(let isSelected):
                return isSelected
            case .disabled(let isSelected):
                return isSelected
            }
        }
        set {
            switch self {
            case .normal(_):
                self = .normal(isSelected: newValue)
            case .disabled(_):
                self = .disabled(isSelected: newValue)
            }
        }
    }
    
    var imageName: String {
        switch self {
        case .normal:
            return self.isSelected ? "ic_checkbox_on" : "ic_checkbox_off"
        case .disabled:
            return  self.isSelected ? "ic_checkbox_ondisable" : "ic_checkbox_disable"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .normal:
            return DealiColor.g100
        case .disabled:
            return DealiColor.g50
        }
    }
}

/**
 설명: UI Elements - Checkbox
 */
public class Checkbox: UIView {
    
    public var status: CheckboxStatus = .normal(isSelected: false) {
        didSet {
            self.setAppearance(for: status)
        }
    }
    
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
        return self.status.isSelected
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
            .debug("++++ 체크박스만")
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.status.changeStatus()
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
            
            Text("미선택 + 활성")
            UIViewPreview {
                let checkbox = Checkbox()
                return checkbox
            }
            
            Text("선택 + 활성")
            UIViewPreview {
                let checkbox = Checkbox()
                checkbox.status = .normal(isSelected: true)
                return checkbox
            }
            
            Text("미선택 + 비활성")
            UIViewPreview {
                let checkbox = Checkbox()
                checkbox.status = .disabled()
                return checkbox
            }
            
            Text("선택 + 비활성")
            UIViewPreview {
                let checkbox = Checkbox()
                checkbox.status = .disabled(isSelected: true)
                return checkbox
            }
            
            Text("contentInset 준 경우")
            UIViewPreview {
                let checkbox = Checkbox()
                checkbox.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
                checkbox.backgroundColor = .yellow
                return checkbox
            }
        }
    }
}
#endif


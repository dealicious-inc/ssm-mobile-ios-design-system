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

protocol StatusToggable {
    mutating func changeStatus()
    
    var imageName: String { get }
    var textColor: UIColor { get }
}

extension StatusToggable {
    mutating func changeStatus(_ status: some StatusToggable) {
        
    }
}

public enum CheckboxStatus: Equatable {
    case normal(isSelected: Bool)
    case disabled
    
    mutating func changeStatus() {
        switch self {
        case .normal(var isSelected):
            isSelected.toggle()
            self = .normal(isSelected: isSelected)
        default:
            break
        }
    }
    
    var imageName: String {
        switch self {
        case .normal(let isSelected):
            return isSelected ? "ic_checkbox_on_ver01" : "ic_checkbox_off_ver01"
        case .disabled:
            return "ic_checkbox_disabled_ver01"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .normal(_):
            return DealiColor.text01
        case .disabled:
            return DealiColor.text05
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
    
    private let disposeBag = DisposeBag()
    private let imageView = UIImageView()
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 24.0, height: 24.0)
    }
    
    public var isSelected: Bool {
        switch self.status {
        case .normal(let isSelected):
            return isSelected
        case .disabled:
            return false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        self.setAppearance(for: self.status)
        self.subscribeRx()
    }
    
    func subscribeRx() {
        self.imageView.rx.tapGestureOnTop()
            .when(.recognized)
            .debug("++++ 체크박스만")
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.status.changeStatus()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setAppearance(for status: CheckboxStatus) {
        self.imageView.image = UIImage(named: status.imageName, in: Bundle.module, compatibleWith: nil)?.withAlignmentRectInsets(UIEdgeInsets(top: -4.0, left: 0.0, bottom: -4.0, right: 0.0))
           
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

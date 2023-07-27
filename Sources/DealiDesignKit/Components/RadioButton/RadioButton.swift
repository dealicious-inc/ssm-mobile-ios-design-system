//
//  RadioButton.swift
//  
//
//  Created by 윤조현 on 2023/06/28.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxGesture
import RxCocoa

public enum RadioButtonStatus: Equatable, StatusToggable {
    case normal(isSelected: Bool)
    case disabled
    
    public mutating func changeStatus() {
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
            return isSelected ? "ic_Checkcircle_on_24" : "ic_Checkcircle_off_24"
        case .disabled:
            return "ic_Checkcircle_disabled_24"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .normal(let isSelected):
            return isSelected ? DealiColor.primary01 : DealiColor.text01
        case .disabled:
            return DealiColor.text05
        }
    }
}

/**
 설명: UI Elements - RadioButton
 */
public class RadioButton: UIView {
    
    public var status: RadioButtonStatus = .normal(isSelected: false) {
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
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.status.changeStatus()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setAppearance(for status: StatusToggable) {
        self.imageView.image = UIImage(named: status.imageName, in: Bundle.module, compatibleWith: nil)
           
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct RadioButtonPreview: PreviewProvider {
    static var previews: some View {
    
        VStack {
            UIViewPreview {
                RadioButton()
            }
            
            UIViewPreview {
                let radioButton = RadioButton()
                radioButton.status = .normal(isSelected: true)
                return radioButton
            }
            
            UIViewPreview {
                let radioButton = RadioButton()
                radioButton.status = .disabled
                return radioButton            }
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiButtonStyle")
    }
}
#endif


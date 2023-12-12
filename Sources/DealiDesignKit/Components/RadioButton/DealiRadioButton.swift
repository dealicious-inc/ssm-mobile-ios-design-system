//
//  DealiRadioButton.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit

/// 디자인시스템 RadioButton 적용
///
/// 선택, 미선택 시 보내는 `.valueChanged` 값을 받아서 변경 사항을 처리할 수 있습니다.
///
/// 활성, 비활성은 UIControl 의 속성인 `isEnabled` 를 사용합니다.
public class DealiRadioButton: UIControl {
    
    public override var isSelected: Bool {
        didSet {
            self.setupView()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.setupView()
            self.isUserInteractionEnabled = isEnabled
        }
    }
    
    private func setupView() {
        if self.isEnabled == false {
            self.imageView.isHidden = true
            self.circleView.isHidden = false
            circleView.do {
                $0.layer.borderColor = DealiColor.g30.cgColor
                $0.backgroundColor = DealiColor.g20
            }
        } else if self.isSelected {
            self.imageView.isHidden = false
            self.circleView.isHidden = true
            self.imageView.image = UIImage(named: "ic_Checkcircle_on_24", in: Bundle.module, compatibleWith: nil)
        } else {
            self.imageView.isHidden = true
            self.circleView.isHidden = false
            circleView.do {
                $0.layer.borderColor = DealiColor.g50.cgColor
                $0.backgroundColor = .white
            }
        }
    }
   
    private let imageView = UIImageView()
    private let circleView = UIView()
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 24.0, height: 24.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let containerView = UIView()
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        containerView.addSubview(self.circleView)
        self.circleView.then {
            $0.layer.borderColor = DealiColor.g50.cgColor
            $0.layer.borderWidth = 1.0
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 9.0
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 18.0, height: 18.0))
            $0.center.equalToSuperview()
        }
                
        containerView.addSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
            $0.isHidden = false
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        containerView.addGestureRecognizer(tap)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc private func handleTap() {
        self.isSelected.toggle()
        self.sendActions(for: .valueChanged)

    }
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DealiRadioButtonPreview: PreviewProvider {
    static var previews: some View {
    
        VStack {
            UIViewPreview {
                let radioButton = DealiRadioButton()
                return radioButton
            }
            
            UIViewPreview {
                let radioButton = DealiRadioButton()
                radioButton.isSelected = true
                return radioButton
            }
            
            // 프리뷰에는 반영이 안된다
            UIViewPreview {
                let radioButton = DealiRadioButton()
                radioButton.isEnabled = false
                return radioButton
            }
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiRadioButton")
    }
}
#endif



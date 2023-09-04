//
//  DealiRadioButtonWithText.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit

/// 디자인시스템 RadioButton + Text 적용
///
/// 선택, 미선택 시 보내는 `.valueChanged` 값을 받아서 변경 사항을 처리할 수 있습니다.
/// 
/// 활성, 비활성은 UIControl 의 속성인 `isEnabled` 를 사용합니다.
///
/// `text`에 String 값을 넣거나 `attributedText` 에 NSAttributedString 값을 넣어 사용합니다.
public class DealiRadioButtonWithText: UIControl {
    
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
    
    public var edgeInset: UIEdgeInsets = .zero {
        didSet {
            self.containerView.snp.updateConstraints {
                $0.edges.equalToSuperview().inset(self.edgeInset)
            }
        }
    }
    
    public var text: String? {
        get {
            self.titleLabel.text
        } set {
            self.titleLabel.text = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public var attributedText: NSAttributedString? {
        didSet {
            self.titleLabel.attributedText = attributedText
            self.invalidateIntrinsicContentSize()
        }
    }
    
    /// 선택 상태에 따른 글자 색 변경 여부. 기본값은 true
    public var isTextColorChangable: Bool = true
    
    private var textColor: UIColor {
        guard isTextColorChangable else { return DealiColor.text01 }
    
        if self.isEnabled == false {
            return DealiColor.text05
        } else if self.isSelected {
            return DealiColor.primary01
        } else {
            return DealiColor.text01
        }
    }
    
    private let containerView = UIView()
    
    public override var intrinsicContentSize: CGSize {
        self.titleLabel.sizeToFit()
        let width = self.titleLabel.frame.width + 24.0 + 8.0 + self.edgeInset.left + self.edgeInset.right
        let height = self.titleLabel.frame.height + self.edgeInset.top + self.edgeInset.bottom
        
        return CGSize(width: width, height: max(24.0, height))
    }
    
    private func setupView() {
        self.imageView.image = UIImage(named: self.imageName, in: Bundle.module, compatibleWith: nil)
        self.titleLabel.textColor = self.textColor
    }
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    private var imageName: String {
        if self.isEnabled == false {
            return "ic_Checkcircle_disabled_24"
        } else if self.isSelected {
            return "ic_Checkcircle_on_24"
        } else {
            return "ic_Checkcircle_off_24"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.edgeInset)
        }
        
        self.containerView.addSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        self.containerView.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .b3r13
            $0.lineBreakMode = .byCharWrapping
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(32.0)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.bottom.right.equalToSuperview()
        }
        
        self.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleTap() {
        self.isSelected.toggle()
        self.sendActions(for: .valueChanged)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DealiRadioButtonWithTextPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"
    
   
    static var disableState: CheckboxStatus = .disabled

    static var previews: some View {
        VStack(alignment: .leading) {

            Text("RadioButtonWithText")
            UIViewPreview {
                let radioButtonWithText = DealiRadioButtonWithText()
                radioButtonWithText.text = testString

                return radioButtonWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let radioButtonWithText = DealiRadioButtonWithText()
                radioButtonWithText.text = testString
                radioButtonWithText.isSelected = true
                return radioButtonWithText
            }
            .padding(.bottom, 10.0)

            UIViewPreview {
                let radioButtonWithText = DealiRadioButtonWithText()
                radioButtonWithText.text = testString
                radioButtonWithText.attributedText = .init()
                radioButtonWithText.isEnabled = false
                return radioButtonWithText
            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

//
//  TestButton.swift
//
//
//  Created by 윤조현 on 2023/10/17.
//

import UIKit

public class TestButton: UIButton {
    public var title: String? = "" {
        didSet {
            self.buttonTitleLabel.text = self.title
            self.setAppearance()
        }
    }
    
    public var leftIconImage: UIImage? {
        didSet {
            guard let leftIconImage else {
                self.leftView.isHidden = true
                return
            }
            
            self.leftView.isHidden = false
            self.leftView.image = leftIconImage.withTintColor(self.buttonTitleLabel.textColor)
            
            self.changeLayout()
            
        }
    }
    
    public var rightIconImage: UIImage? {
        didSet {
            guard let rightIconImage else {
                self.rightView.isHidden = true
                return
            }
            
            self.rightView.isHidden = false
            self.rightView.image = rightIconImage.withTintColor(self.buttonTitleLabel.textColor)
            
            self.changeLayout()
        }
    }
    
    func changeLayout() {
        if self.leftIconImage != nil {
            if self.rightIconImage == nil {
                self.contentStackView.snp.updateConstraints {
                    // 왼쪽으로 offset만큼 중심 이동
                    $0.centerX.equalToSuperview().offset(-self.size.attribute.padding.contentHorizontalOffset)
                }
                return
            }
        }
        
        if self.rightIconImage != nil {
            if self.leftIconImage == nil {
                self.contentStackView.snp.updateConstraints {
                    // 오른쪽으로 offset만큼 중심이동
                    $0.centerX.equalToSuperview().offset(self.size.attribute.padding.contentHorizontalOffset)
                }
                return
            }
        }
        
    }
    
    private let contentStackView = UIStackView()
    private let buttonTitleLabel = UILabel()
    
    private let leftView = UIImageView()
    private let rightView = UIImageView()
    
    var color: ButtonColorConfig
    var size: ButtonSizeConfig
        
    public init(color: ButtonColorConfig, size: ButtonSizeConfig, title: String? = "") {
        self.color = color
        self.size = size
        self.title = title
        
        super.init(frame: .zero)
        
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.spacing = self.size.attribute.padding.internalSpacing
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.leftView)
        self.leftView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        self.contentStackView.addArrangedSubview(self.buttonTitleLabel)
        self.buttonTitleLabel.do {
            $0.textAlignment = .center
        }
    
        self.contentStackView.addArrangedSubview(self.rightView)
        self.rightView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        self.setAppearance()
        
    }
    
    override public var intrinsicContentSize: CGSize {
        self.buttonTitleLabel.sizeToFit()
        var width: CGFloat = self.buttonTitleLabel.frame.width + self.size.attribute.padding.left +  self.size.attribute.padding.right
        
        if self.leftIconImage != nil {
            width += self.leftView.frame.width + self.size.attribute.padding.internalSpacing
        }
        
        if self.rightIconImage != nil {
            width += self.rightView.frame.width + self.size.attribute.padding.internalSpacing
        }
        
        return CGSize(width: width, height: self.size.attribute.padding.height)
    }
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            
            if newValue == false {
                self.layer.borderColor = self.color.attribute.disabledBorderColor.cgColor
                self.layer.borderWidth = 1.0

                self.buttonTitleLabel.textColor = self.color.attribute.disabledTextColor
                
                if let leftIconImage = self.leftIconImage {
                    self.leftView.image = leftIconImage.withTintColor(self.color.attribute.disabledTextColor)
                }
                
                if let rightIconImage = self.rightIconImage {
                    self.rightView.image = rightIconImage.withTintColor(self.color.attribute.disabledTextColor)
                }
            }
            
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            self.backgroundColor = isHighlighted ? DealiColor.b10 : self.color.attribute.defaultBackgroundColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension TestButton {
    func setAppearance() {
        self.buttonTitleLabel.text = self.title
        self.buttonTitleLabel.textColor = self.color.attribute.defaultTextColor
        self.buttonTitleLabel.font = self.size.attribute.font
        

        self.setBackgroundColor(self.color.attribute.defaultBackgroundColor, for: .normal)
        self.setBackgroundColor(self.color.attribute.disabledBackgroundColor, for: .disabled)

        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        self.layer.borderColor = self.color.attribute.defaultBorderColor.cgColor
        self.layer.borderWidth = 1.0
        
        self.invalidateIntrinsicContentSize()
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonPreview1: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                Text("DesignSystem Button Test")
                    .font(.system(size: 30.0, weight: .bold))
                
//                UIViewPreview {
//                    let button = TestButton(color: FilledColor.primary01, size: FilledSize.large)
//                    button.title = "일반"
//                    return button
//                }
//                
//                UIViewPreview {
//                    let button = TestButton(color: FilledColor.primary01, size: FilledSize.large)
//                    button.title = "pressed"
//                    button.isHighlighted = true
//                    return button
//                }
//                
//                UIViewPreview {
//                    let button =  TestButton(color: FilledColor.primary01, size: FilledSize.large)
//                    button.title = "disabled"
//                    button.isEnabled = false
//                    return button
//                }
//                
//                UIViewPreview {
//                    let button =  TestButton(color: FilledColor.primary01, size: FilledSize.large)
//                    button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
//                    button.rightIconImage = UIImage(named: "ic_arrow_right_16", in: Bundle.module, compatibleWith: nil)
//                    button.title = "양쪽에 아이콘 있는 경우"
//                    return button
//                }
//                
//                UIViewPreview {
//                    let button =  TestButton(color: FilledColor.primary01, size: FilledSize.large)
//                    button.leftIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
//                    button.title = "!한쪽에 아이콘 있는 경우"
//                    return button
//                }
//                
//                UIViewPreview {
//                    let button =  TestButton(color: FilledColor.primary01, size: FilledSize.large)
//                    button.rightIconImage = UIImage(named: "ic_arrow_left_16", in: Bundle.module, compatibleWith: nil)
//                    button.title = "한쪽에 아이콘 있는 경우"
//                    return button
//                }
                
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiButtonStyle")
    }
}
#endif

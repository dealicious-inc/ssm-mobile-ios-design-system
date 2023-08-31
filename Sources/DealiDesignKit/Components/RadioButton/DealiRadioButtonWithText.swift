//
//  DealiRadioButtonWithText.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit

public class DealiRadioButtonWithText: UIControl {
    
    public override var isSelected: Bool {
        didSet {
            self.setupView()
            self.sendActions(for: .valueChanged)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.setupView()
            self.isUserInteractionEnabled = isEnabled
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
    
    public override var intrinsicContentSize: CGSize {
        self.titleLabel.sizeToFit()

        let width = self.titleLabel.frame.width + 24.0 + 8.0
        let height = self.titleLabel.frame.height
        return CGSize(width: width, height: max(24.0, height))
    }
    
    private func setupView() {
        self.radioButton.isSelected = self.isSelected
        self.radioButton.isEnabled = self.isEnabled
        self.titleLabel.textColor = self.textColor
    }
    
    private let titleLabel = UILabel()
    private let radioButton = DealiRadioButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addSubview(self.radioButton)
        self.radioButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.font = .b3r13
            $0.text = self.text
        }.snp.makeConstraints {
            $0.left.equalTo(self.radioButton.snp.right).offset(8.0)
            $0.centerY.equalToSuperview()
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTap() {
        self.isSelected.toggle()
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
                radioButtonWithText.isEnabled = false
                return radioButtonWithText
            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

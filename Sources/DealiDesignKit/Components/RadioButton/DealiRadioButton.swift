//
//  DealiRadioButton.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit

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
        self.imageView.image = UIImage(named: self.imageName, in: Bundle.module, compatibleWith: nil)
    }
    
    
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
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 24.0, height: 24.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
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



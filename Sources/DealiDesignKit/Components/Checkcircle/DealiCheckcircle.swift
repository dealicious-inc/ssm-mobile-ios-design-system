//
//  DealiCheckcircle.swift
//
//
//  Created by 윤조현 on 2024/01/26.
//

import UIKit

/// 디자인시스템 Checkcircle 적용
///
/// 선택, 미선택 시 보내는 `.valueChanged` 값을 받아서 변경 사항을 처리할 수 있습니다.
///
/// 활성, 비활성은 UIControl 의 속성인 `isEnabled` 를 사용합니다.
public class DealiCheckcircle: UIControl {
    
    public override var isSelected: Bool {
        didSet {
            self.setupView()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.setupView()
        }
    }
    
    public var isAd: Bool = false {
        didSet {
            self.setupView()
        }
    }
    
    private var imageName: String {
        if self.isEnabled == false {
            return "ic_checkcircle_disable"
        } else if self.isSelected {
            return self.isAd ? "ic_checkcircle_onad" : "ic_checkcircle_on"
        } else {
            return "ic_checkcircle_off"
        }
    }
    
    private func setupView() {
        self.imageView.image = UIImage(named: self.imageName, in: Bundle.module, compatibleWith: nil)

    }
   
    private let imageView = UIImageView()

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
                
        containerView.addSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFit
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

struct DealiCheckcirclePreview: PreviewProvider {
    static var previews: some View {
    
        VStack {
            UIViewPreview {
                let checkCircle = DealiCheckcircle()
                return checkCircle
            }
            
            UIViewPreview {
                let checkCircle = DealiCheckcircle()
                checkCircle.isSelected = true
                checkCircle.isAd = false

                return checkCircle
            }
            
            UIViewPreview {
                let checkCircle = DealiCheckcircle()
                checkCircle.isAd = true
                checkCircle.isSelected = true

                return checkCircle
            }
            
            // 프리뷰에는 반영이 안된다
            UIViewPreview {
                let checkCircle = DealiCheckcircle()
                checkCircle.isEnabled = false
                return checkCircle
            }
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiCheckcircle")
    }
}
#endif



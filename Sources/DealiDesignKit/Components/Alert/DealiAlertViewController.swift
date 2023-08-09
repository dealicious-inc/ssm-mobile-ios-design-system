//
//  DealiAlert.swift
//  
//
//  Created by hoji on 2023/08/09.
//

import UIKit

final class DealiAlert: NSObject {
    
}

final class DealiAlertViewController: UIViewController {

    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let cancelButton = DealiButton()
    private let confirmButton = DealiButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = DealiColor.etc06
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10.0
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.0)
            $0.height.lessThanOrEqualTo(456.0)
        }
        
        let contentStackView = UIStackView()
        self.contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 24.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.left.bottom.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .sh1sb20
            $0.textColor = DealiColor.text01
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.text = "Temp Alert Title"
//            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.setCustomSpacing(20.0, after: self.titleLabel)
        
        contentStackView.addArrangedSubview(self.messageLabel)
        self.messageLabel.then {
            $0.font = .sh3r16
            $0.textColor = DealiColor.text03
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.text = "Temp Alert Message"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let buttonStackView = UIStackView()
        contentStackView.addArrangedSubview(buttonStackView)
        buttonStackView.then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        buttonStackView.addArrangedSubview(self.cancelButton)
        self.cancelButton.then {
            $0.style = .medium(style: .outlined)
            $0.title = "취소"
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        buttonStackView.addArrangedSubview(self.confirmButton)
        self.confirmButton.then {
            $0.style = .medium(style: .filled)
            $0.title = "확인"
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
    }

}

extension UIViewController {
    private struct UIViewControllerPreview: UIViewControllerRepresentable {
        let viewController: UIViewController

                func makeUIViewController(context: Context) -> UIViewController {
                    return viewController
                }

                func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
                }
    }
    
    func showPreview() -> some View {
        UIViewControllerPreview(viewController: self)
        }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct AlertPreview: PreviewProvider {
    static var previews: some View {
        DealiAlertViewController().showPreview()
    }
}
#endif


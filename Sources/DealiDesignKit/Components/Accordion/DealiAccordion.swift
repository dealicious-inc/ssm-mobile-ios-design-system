//
//  DealiAccordion.swift
//  
//
//  Created by 이창호 on 10/21/24.
//

import UIKit

public class DealiAccordion: UIView {
    
    private let openButton = UIButton()
    private let openButtonTitleLabel = UILabel()
    private let openButtonArrowImageView = UIImageView()
    private let dividerView = UIView()
    private let accordionContainerView = UIView()
    private let accordionItemStackView = UIStackView()

    public var title: String? {
        didSet {
            if let title = self.title {
                self.openButtonTitleLabel.attributedText = NSMutableAttributedString(string: title)
                    .font(.b2sb14)
                    .color(DealiColor.g100)
                    .alignment(.left)
                    .setLineHeight()
            }
        }
    }
    
    /// accordion View에 들어가는 View들 간의 간격
    public var accordionItemSpacing: CGFloat = 0.0 {
        didSet {
            self.accordionItemStackView.spacing = self.accordionItemSpacing
        }
    }
    
    /// accordion View에 들어가는 View array 항목
    public var accordionItemViewArray: [UIView] = [] {
        didSet {
            self.accordionItemStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            for view in self.accordionItemViewArray {
                self.accordionItemStackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.left.right.equalToSuperview()
                }
            }
        }
    }
    
    /// accordionView에 background color를 변경해야 할때 값 세팅
    public var accordionViewBackgroundColor: UIColor = DealiColor.g10 {
        didSet {
            self.backgroundColor = self.accordionViewBackgroundColor
            self.openButton.setBackgroundColor(self.accordionViewBackgroundColor, for: .normal)
        }
    }
    
    private var isOpen: Bool = false
    
    public init() {
        super.init(frame: .zero)
        
        self.do {
            $0.setCornerRadius(10.0, borderWidth: 0.0)
            $0.backgroundColor = self.accordionViewBackgroundColor
        }
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 0.0
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.openButton)
        self.openButton.then {
            $0.addTarget(self, action: #selector(openButtonPressed(_:)), for: .touchUpInside)
            $0.setBackgroundColor(self.accordionViewBackgroundColor, for: .normal)
            $0.setBackgroundColor(UIColor(rgb: 0x000000, alpha: 0.06), for: .highlighted)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let openButtonIconImageView = UIImageView()
        self.openButton.addSubview(openButtonIconImageView)
        openButtonIconImageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_notice")?.resize(CGSize(width: 16.0, height: 16.0))
        }.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        self.openButton.addSubview(self.openButtonArrowImageView)
        self.openButtonArrowImageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_arrow_open")?.resize(CGSize(width: 16.0, height: 16.0))
        }.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20.0)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        self.openButton.addSubview(self.openButtonTitleLabel)
        self.openButtonTitleLabel.then {
            $0.numberOfLines = 0
            $0.attributedText = NSMutableAttributedString(string: "타이틀")
                .font(.b2sb14)
                .color(DealiColor.g100)
                .alignment(.left)
                .setLineHeight()
        }.snp.makeConstraints {
            $0.left.equalTo(openButtonIconImageView.snp.right).offset(8.0)
            $0.right.equalTo(openButtonArrowImageView.snp.left).offset(-16.0)
            $0.top.bottom.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.dividerView)
        self.dividerView.then {
            $0.backgroundColor = DealiColor.g30
            $0.isHidden = true
            $0.alpha = 0.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.height.equalTo(1.0)
        }
        
        contentStackView.addArrangedSubview(self.accordionContainerView)
        self.accordionContainerView.then {
            $0.isHidden = true
            $0.alpha = 0.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.accordionContainerView.addSubview(self.accordionItemStackView)
        self.accordionItemStackView.then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.alignment = .center
            $0.spacing = 0.0
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.bringSubviewToFront(self.openButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func openButtonPressed(_ sender: UIButton) {
        self.isOpen = !self.isOpen
        self.showAccordion(isOpen: self.isOpen, animation: true)
    }
    
    /// 외부에서 해당 accordion view를 펼치거나 접을때 호출
    public func showAccordion(isOpen: Bool, animation:Bool = false) {
        self.isOpen = isOpen
        UIView.animate(withDuration: (animation == true ? 0.25 : 0.0)) { [weak self] in
            guard let self else { return }
            
            if isOpen {
                self.openButtonArrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                self.openButtonArrowImageView.transform = CGAffineTransform(rotationAngle: 0)
            }
            
            self.dividerView.isHidden = !isOpen
            self.dividerView.alpha = (isOpen ? 1.0 : 0.0)
            
            self.accordionContainerView.isHidden = !isOpen
            self.accordionContainerView.alpha = (isOpen ? 1.0 : 0.0)
        }
    }
}

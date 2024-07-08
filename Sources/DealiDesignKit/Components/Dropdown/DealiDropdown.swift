//
//  DealiDropdown.swift
//
//
//  Created by 윤조현 on 2024/07/08.
//

import UIKit
import RxSwift
import RxGesture

/**
 설명: 디자인시스템 Dropdown
 */
public class DealiDropdown: UIView {
    
    public var status: EDropdownStatus = .default {
        didSet {
            self.setUI(for: self.status)
        }
    }
    
    private func setUI(for status: EDropdownStatus) {
        switch status {
        case .default:
            self.dropdown.isUserInteractionEnabled = true
            self.dropdown.backgroundColor = DealiColor.primary04
            self.contentLabel.textColor = DealiColor.g100
            self.arrowIconImageView.image = self.arrowIconImageView.image?.withTintColor(DealiColor.g100)

        case .disabled:
            self.dropdown.isUserInteractionEnabled = false
            self.dropdown.backgroundColor = DealiColor.g10
            self.contentLabel.textColor = DealiColor.g50
            self.arrowIconImageView.image = self.arrowIconImageView.image?.withTintColor(DealiColor.g50)
        }
    }
    
    public enum EDropdownStatus {
        case `default`
        case disabled
    }
    
    public var arrowType: EDropDownArrayType = .right {
        didSet {
            switch self.arrowType {
            case .open:
                self.arrowIconImageView.image = UIImage.dealiIcon(named: "ic_arrow_open")
            case .right:
                self.arrowIconImageView.image = UIImage.dealiIcon(named: "ic_arrow_right")
            }
        }
    }
    
    public enum EDropDownArrayType {
        case open
        case right
    }
    
    public var title: String? {
        didSet {
            self.titleLabel.isHidden = (self.title?.isEmpty ?? true)
            self.titleLabel.text = self.title
        }
    }
    
    public var contentText: String? {
        didSet {
            self.contentLabel.text = self.contentText
        }
    }
    
    public lazy var tapGesture = self.dropdown.rx.tapGestureOnTop()
    
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let dropdown = UIStackView()
    private let arrowIconImageView = UIImageView()

    private let disposeBag = DisposeBag()
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setUpUI()
    }
    
    private func setUpUI() {
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.spacing = 4.0
            $0.axis = .vertical
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2r14
            $0.textColor = DealiColor.g100
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.height.equalTo(20.0)
        }
        
        contentStackView.addArrangedSubview(self.dropdown)
        self.dropdown.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
            $0.alignment = .center
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = .init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        }.snp.makeConstraints {
            $0.height.equalTo(46.0)
        }
        
        self.dropdown.addArrangedSubview(self.contentLabel)
        self.contentLabel.do {
            $0.textColor = DealiColor.g100
            $0.font = .b2r14
        }
        
        self.dropdown.addArrangedSubview(self.arrowIconImageView)
        self.arrowIconImageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_arrow_right")
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

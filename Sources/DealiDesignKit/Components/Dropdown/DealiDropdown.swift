//
//  DealiDropdown.swift
//
//
//  Created by 윤조현 on 2024/07/08.
//

import UIKit
import RxSwift
import RxGesture
import RxRelay

/**
 설명: 디자인시스템 Dropdown
 */
public class DealiDropdown: UIView {
    
    // MARK: - Public
    public var status: EDropdownStatus = .default {
        didSet {
            self.setUI(for: self.status)
        }
    }
    
    /// 필수입력값인지 나타내는 변수. 기본값은 false.
    public var isMandatory: Bool = false {
        didSet {
            self.requiredBadge.isHidden = !self.isMandatory
        }
    }
    
    public var isSelecting: PublishRelay<Bool> = .init()
    
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
            self.titleContentView.isHidden = (self.title?.isEmpty ?? true)
            self.titleLabel.text = self.title
        }
    }
    
    public var iconImage: UIImage? {
        didSet {
            self.iconImageView.isHidden = self.iconImage == nil
            guard iconImage != nil else { return }
            self.dropdown.setCustomSpacing(4.0, after: self.iconImageView)
            self.iconImageView.image = self.iconImage
        }
    }
    
    public var contentText: String? {
        didSet {
            self.contentLabel.text = self.contentText
        }
    }
    
    public var helperText: String? {
        didSet {
            guard let helperText else {
                self.helperTextLabel.isHidden = true
                return
            }
            
            self.helperTextLabel.isHidden = helperText.isEmpty
            
            let style = NSMutableParagraphStyle().then {
                $0.lineHeightMultiple = 1.12
                $0.alignment = .left
            }
               
            self.helperTextLabel.attributedText = NSAttributedString(string: helperText, attributes: [.font: UIFont.b4r12, .foregroundColor: UIColor.g70, .paragraphStyle: style])
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setUI()
        
        self.isSelecting
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, isSelecting in
                guard owner.arrowType == .open else { return }
                UIView.animate(withDuration: 0.2) {
                    if isSelecting {
                        owner.arrowIconImageView.transform = owner.arrowIconImageView.transform.rotated(by: .pi)
                    } else {
                        owner.arrowIconImageView.transform = .identity
                    }
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    public lazy var tapGesture = self.dropdown.rx.tapGestureOnTop()
    
    // MARK: - Private
    private func setUI(for status: EDropdownStatus) {
        switch status {
        case .default:
            self.dropdown.isUserInteractionEnabled = true
            self.dropdown.backgroundColor = .primary04
            self.contentLabel.textColor = .g100
            self.arrowIconImageView.image = self.arrowIconImageView.image?.withTintColor(.g100)

        case .disabled:
            self.dropdown.isUserInteractionEnabled = false
            self.dropdown.backgroundColor = .g10
            self.contentLabel.textColor = .g50
            self.arrowIconImageView.image = self.arrowIconImageView.image?.withTintColor(.g50)
        }
    }
    
    private let titleContentView = UIView()
    private let titleLabel = UILabel()
    /// 필수입력사항인지 나타내는 뱃지
    private let requiredBadge = UIView()
    private let dropdown = UIStackView()
    private let iconImageView = UIImageView()
    private let contentLabel = UILabel()
    private let arrowIconImageView = UIImageView()
    private let helperTextLabel = UILabel()

    private let disposeBag = DisposeBag()
    
    private func setUI() {
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.spacing = 4.0
            $0.axis = .vertical
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.titleContentView)
        self.titleContentView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.titleContentView.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2r14
            $0.textColor = .g100
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        self.titleContentView.addSubview(self.requiredBadge)
        self.requiredBadge.then {
            $0.backgroundColor = .primary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2.5
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 5.0, height: 5.0))
            $0.top.equalToSuperview().inset(4.0)
            $0.left.equalTo(self.titleLabel.snp.right).offset(4.0)
        }
        
        contentStackView.addArrangedSubview(self.dropdown)
        self.dropdown.then {
            $0.axis = .horizontal
            $0.spacing = 16.0
            $0.alignment = .center
            $0.layer.borderColor = UIColor.g20.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 6.0
            $0.layer.masksToBounds = true
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = .init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        }.snp.makeConstraints {
            $0.height.equalTo(46.0)
        }
        
        self.dropdown.addArrangedSubview(self.iconImageView)
        self.iconImageView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        self.dropdown.addArrangedSubview(self.contentLabel)
        self.contentLabel.do {
            $0.textColor = .g100
            $0.font = .b2r14
        }
        
        self.dropdown.addArrangedSubview(self.arrowIconImageView)
        self.arrowIconImageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_arrow_right")
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        contentStackView.addArrangedSubview(self.helperTextLabel)
        self.helperTextLabel.do {
            $0.isHidden = true
            $0.font = .b4r12
            $0.textColor = .g70
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

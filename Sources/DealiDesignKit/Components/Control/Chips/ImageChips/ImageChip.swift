//
//  ImageChip.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 11/5/24.
//

import UIKit

public class ImageChip: DealiChip {
    
    public override var intrinsicContentSize: CGSize {
        var width = self.configuration.leftPadding + self.configuration.imageSize.width + self.configuration.rightPadding + self.configuration.interItemSpacing + ceil(self.titleLabel.intrinsicContentSize.width)
        
        if self.rightImage != nil {
            width += self.configuration.contentSpacing
            width += self.configuration.rightIconImageSize.width
        }
        
        if self.slotContainerView.isHidden == false {
            self.slotView?.invalidateIntrinsicContentSize()
            width += self.configuration.contentSpacing
            width += self.slotView?.intrinsicContentSize.width ?? 0
        }
        
        return CGSize(width: width, height: self.configuration.height)
    }
    
    var configuration = ImageChipConfig(
        size: ImageChipSizeType.medium.size,
        style: ImageStyleType.basic.style
    )
    
    private let contentStackView = UIStackView()
    private let highlightView = UIView()
    
    public let imageView = UIImageView()
    private let placeholderImageView = UIImageView()
    private let titleLabel = UILabel()
    private let slotContainerView = UIView()
    private let rightIconImageView = UIImageView()
    
    public var imageURL: URL? {
        didSet {
            self.imageView.setImage(url: imageURL, size: self.configuration.imageSize) { image in
                self.placeholderImageView.isHidden = (image != nil)
            }
        }
    }
    
    public var placeholderImage: UIImage? = UIImage.dealiIcon(named: "ic_home_filled") {
        didSet {
            self.placeholderImageView.image = self.placeholderImage
            if self.placeholderImage == nil {
                self.placeholderImageView.isHidden = true
            }
        }
    }
    
    public var slotView: DealiCustomView? {
        didSet {
            self.slotContainerView.isHidden = (self.slotView == nil)
            guard let slotView = self.slotView else { return }
            self.slotContainerView.addSubview(slotView)
            slotView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    /// Slot 영역이 선택 상태일 때만 노출되는지 여부
    /// true일 경우 선택 상태에서만 노출, false일 경우 항상 노출
    public var showSlotWhenSelected: Bool = false
    
    public init() {
        super.init(frame: .zero)
    }
    
    init(configuration: ImageChipConfig) {
        self.configuration = configuration
        super.init(frame: .zero)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        didSet {
            self.titleLabel.text = self.title
            self.updateUI(for: self.status)
        }
    }
    
    public var rightImage: UIImage? {
        didSet {
            self.rightIconImageView.isHidden = (rightImage == nil)
            self.updateRightIconButtonVisibility()
            self.updateContent()
        }
    }
    
    /// 우측 아이콘(X 등)만 탭했을 때 호출
    public var onRightIconTap: (() -> Void)? {
        didSet {
            self.updateRightIconButtonVisibility()
        }
    }
    
    private let rightIconButton = UIButton(type: .custom)
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            self.highlightView.alpha = isHighlighted ? 1.0 : 0.0
        }
    }
    
    override func setUI() {
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
                
        self.snp.makeConstraints {
            $0.height.equalTo(self.configuration.height)
        }
        
        self.layer.cornerRadius = self.configuration.radius
        self.layer.masksToBounds = true
        
        self.addSubview(self.highlightView)
        self.highlightView.then {
            $0.alpha = 0.0
            $0.backgroundColor = .b2
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.borderColor = UIColor.b5.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = self.configuration.imageSize.width / 2
            $0.backgroundColor = UIColor.primary04
        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(self.configuration.leftPadding)
            $0.width.equalTo(self.configuration.imageSize.width)
            $0.height.equalTo(self.configuration.imageSize.height)
        }
        
        self.imageView.addSubview(self.placeholderImageView)
        self.placeholderImageView.then {
            let width = self.configuration.imageSize.width - self.configuration.placeholderInset * 2
            $0.image = self.placeholderImage?.withTintColor(UIColor.g30).resize(CGSize(width: width, height: width))
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.configuration.placeholderInset)
        }
                
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.spacing = self.configuration.contentSpacing
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.left.equalTo(self.imageView.snp.right).offset(self.configuration.interItemSpacing)
            $0.right.equalToSuperview().inset(self.configuration.rightPadding)
            $0.top.bottom.equalToSuperview()
        }

        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.do {
            $0.font = self.configuration.titleFont
            $0.textAlignment = .left
            $0.text = "imageChip"
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        
        self.contentStackView.addArrangedSubview(self.slotContainerView)
        self.slotContainerView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.height.equalTo(20.0)
        }
        
        self.contentStackView.addArrangedSubview(self.rightIconImageView)
        self.rightIconImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(self.configuration.rightIconImageSize)
        }
        
        self.addSubview(self.rightIconButton)
        self.rightIconButton.then {
            $0.backgroundColor = .clear
            $0.isHidden = true
            $0.addTarget(self, action: #selector(self.handleRightIconTap), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalTo(44.0)
        }
        
        self.updateContent()
    }
    
    private func updateRightIconButtonVisibility() {
        let showButton = (self.rightImage != nil && self.onRightIconTap != nil)
        self.rightIconButton.isHidden = !showButton
    }
    
    @objc private func handleRightIconTap() {
        self.onRightIconTap?()
    }

    override func updateUI(for state: DealiChipStatus) {
        self.configuration.status = state
        
        self.updateContent()
    }
    
    private func updateContent() {
        
        self.titleLabel.font = self.configuration.titleFont
        self.titleLabel.textColor = self.configuration.textColor
        self.rightIconImageView.image = self.rightImage?.withTintColor(self.configuration.textColor)
        self.invalidateIntrinsicContentSize()
        
        if self.slotView != nil {
            if self.showSlotWhenSelected == true {
                self.slotContainerView.isHidden = (self.status != .selected)
            } else {
                self.slotContainerView.isHidden = false
            }
        }
        
        let provider = self.configuration.style.colorProvider as! ChipColors
        let color: ChipColor = provider.getColor(for: status)
                
        self.upadateColor(color)
    }
    
    func upadateColor(_ color: ChipColorProtocol) {
        self.backgroundColor = color.backgroundColor
        self.titleLabel.textColor = color.textColor
        
        if let borderColor = color.borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        } else {
            self.layer.borderWidth = 0.0
        }
    }
}

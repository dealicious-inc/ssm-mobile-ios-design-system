//
//  ImageChip.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 11/5/24.
//

import UIKit

public class ImageChip: DealiChip {
    
    var configuration = ImageChipConfig(
        size: ChipSize(
            height: 46.0,
            imageSize: .init(width: 38.0, height: 38.0),
            placeholderInset: 9.5,
            titleFont: DealiFont.sh3Regular
        ), style: ChipStyle(
            colors: ChipColors(
                normal: ChipColor(textColor: DealiColor.g80, backgroundColor: DealiColor.b5),
                selected: ChipColor(textColor: DealiColor.primary04, backgroundColor: DealiColor.g100),
                disabled: ChipColor(textColor: DealiColor.g80, backgroundColor: DealiColor.b5)
            )
        )
    )
    
    private let contentStackView = UIStackView()
    private var currentColor: ClickableColorSet?
    
    private let highlightView = UIView()
    
    private let imageView = UIImageView()
    private let placeholderImageView = UIImageView()
    private let titleLabel = UILabel()
    private let rightIconImageView = UIImageView()
    
    public var placeholderImage: UIImage? = UIImage.dealiIcon(named: "ic_home_filled") {
        didSet {
            self.imageView.image = self.placeholderImage
        }
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    init(config: ImageChipConfig) {
        self.configuration = config
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
            $0.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.06)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
                
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.spacing = 4.0
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(self.configuration.leftPadding)
            $0.right.equalToSuperview().inset(self.configuration.rightPadding)
            $0.top.bottom.equalToSuperview().inset(self.configuration.verticalPadding)
        }
        
        self.contentStackView.addArrangedSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.borderColor = DealiColor.b5.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = self.configuration.imageSize.width / 2
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.height.equalTo(self.configuration.imageSize.width)
            $0.size.equalTo(self.configuration.imageSize)
        }
        
        self.imageView.addSubview(self.placeholderImageView)
        self.placeholderImageView.then {
            let width = self.configuration.imageSize.width - self.configuration.placeholderInset * 2
            $0.image = self.placeholderImage?.withTintColor(DealiColor.g30).resize(CGSize(width: width, height: width))
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(self.configuration.placeholderInset)
        }
       
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.do {
            $0.font = self.configuration.titleFont
            $0.textAlignment = .left
            $0.text = "imageChip"
        }
        
        self.contentStackView.addArrangedSubview(self.rightIconImageView)
        self.rightIconImageView.then {
            $0.isHidden = true
            $0.backgroundColor = .gray
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(self.configuration.rightIconImageSize)
        }
        
        self.updateContent()
    }

    override func updateUI(for state: DealiChipStatus) {
        self.configuration.status = state
        
        self.updateContent()
    }
}

private extension ImageChip {
    
    private func updateContent() {
        
        self.titleLabel.font = self.configuration.titleFont
        self.titleLabel.textColor = self.configuration.textColor
        
        let color = self.configuration.style.colors.getColor(for: self.status)
        self.upadateColor(color)
        
    }
    
    func upadateColor(_ color: ChipColorProtocol) {
        self.backgroundColor = color.backgroundColor
        self.titleLabel.textColor = color.textColor
        
        if let borderColor = color.borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
    }
    
    private func updateColor(color: ClickableColorSet?) {
        guard let color else { return }
        
        self.currentColor = color
        self.backgroundColor = color.background
        
        if let borderColor = color.border {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
        
        
//        self.titleLabel.textColor = color.text
        
        self.backgroundColor = DealiColor.b5


    }
}

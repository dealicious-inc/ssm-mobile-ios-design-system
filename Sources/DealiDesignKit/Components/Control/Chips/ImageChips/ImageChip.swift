//
//  ImageChip.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 11/5/24.
//

import UIKit

struct ChipConfig {
    
    var status: DealiChipStatus = .normal {
        didSet {
            self.setConfig(for: self.status)
        }
    }
    
    var radius: CGFloat {
        switch self.radiusType {
        case .none:
            return 0.0
        case .fixed(let radius):
            return radius
        case .capsule:
            return self.height / 2
        }
    }
    
    var style: ChipStyle
    
    init(size: ChipSize, style: ChipStyle) {
        self.height = size.height
        self.imageSize = size.imageSize
        self.dealiFont = size.titleFont
        self.placeholderInset = size.placeholderInset

        self.style = style
        let color = style.colors.getColor(for: .normal)
        self.textColor = color.textColor
        self.backgroundColor = color.backgroundColor
        self.borderColor = color.borderColor
        self.radiusType = style.radius
    }
    
    var radiusType: ChipStyle.Radius

    var height: CGFloat
    var imageSize: CGSize
    var placeholderInset: CGFloat
    var rightIconImageSize: CGSize = CGSize(width: 16.0, height: 16.0)

    var leftPadding: CGFloat = 4.0
    var rightPadding: CGFloat = 12.0
    var verticalPadding: CGFloat = 4.0
    
    var dealiFont: DealiFont
    
    private(set) var titleFont: UIFont?
    var textColor: UIColor

    var backgroundColor: UIColor
    var borderColor: UIColor?
    
    mutating func setConfig(for status: DealiChipStatus) {
        
        let color = self.style.colors.getColor(for: status)
        self.configColor(color)
        
        switch status {
        case .normal, .disabled:
            self.titleFont = self.dealiFont.systemFont
        case .selected:
            self.titleFont = self.dealiFont.makeBolder()
        }
    }
    
    mutating func configColor(_ color: ChipColor) {
        self.backgroundColor = color.backgroundColor
        self.textColor = color.textColor
        self.borderColor = color.backgroundColor
    }
}

struct ChipSize {
    var height: CGFloat
    var imageSize: CGSize
    var placeholderInset: CGFloat
    var titleFont: DealiFont
}

struct ChipStyle {
    enum Radius {
        case none
        case fixed(_ radius: CGFloat)
        case capsule
    }
    
    var radius: Radius = .capsule
    var colors: ChipColors
}


struct ChipColors {
    private var normal: ChipColor
    private var selected: ChipColor
    private var disabled: ChipColor
    
    init(normal: ChipColor, selected: ChipColor, disabled: ChipColor) {
        self.normal = normal
        self.selected = selected
        self.disabled = disabled
    }
    
    func getColor(for status: DealiChipStatus) -> ChipColor {
        switch status {
        case .normal:
            return self.normal
        case .selected:
            return self.selected
        case .disabled:
            return self.disabled
        }
    }
}

struct ChipColor {
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .white
    var borderColor: UIColor?
}


public class ImageChip: DealiChip {
    
    var configuration = ChipConfig(
        size: ChipSize(
            height: 46.0,
            imageSize: .init(width: 38.0, height: 38.0),
            placeholderInset: 9.5,
            titleFont: .sh3Regular
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
    
    init(config: ChipConfig) {
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
    
    func upadateColor(_ color: ChipColor) {
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

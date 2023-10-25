//
//  ClickableComponent.swift
//  
//
//  Created by 박경우 on 2023/10/23.
//

import UIKit

public class DealiControl {
    
}

final public class ClickableComponentButton: ClickableComponent {
    init(font: UIFont, size: ClickableSizeConfig, color: ClickableColorConfig, cornerRadius: ClickableComponent.Configuration.Corner?, functionName: String = #function) {
        super.init(font: font, style: .button, height: size.attribute.height, padding: size.attribute.padding, color: color.attribute, cornerRadius: cornerRadius)
        self.title = functionName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class ClickableComponentChip: ClickableComponent {
    init(font: UIFont, size: ClickableSizeConfig, color: ClickableColorConfig, cornerRadius: ClickableComponent.Configuration.Corner?) {
        super.init(font: font, style: .chip, height: size.attribute.height, padding: size.attribute.padding, color: color.attribute, cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class ClickableComponent: UIControl {
    
    private var configuration: ClickableComponent.Configuration?
    private var gradientBackgroundLayer: CAGradientLayer?
    private let highlightView = UIView()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()
    private var currentColor: ClickableColorSet?
    
    public var titleAlignment: NSTextAlignment = .center {
        didSet{
            self.titleLabel.textAlignment = titleAlignment
        }
    }
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
            self.titleLabel.isHidden = (title?.isEmpty ?? true)
        }
    }
    
    public var leftImage: UIImage? {
        didSet {
            self.contentStackView.snp.updateConstraints {
                if self.configuration?.style == .chip {
                    if leftImage != nil {
                        $0.left.equalToSuperview().offset(self.configuration?.padding?.left.withImage ?? 0.0)
                    } else {
                        $0.left.equalToSuperview().offset(self.configuration?.padding?.left.normal ?? 0.0)
                    }
                }
            }
            self.leftImageView.image = leftImage
            self.leftImageView.isHidden = (leftImage == nil)
            self.updateColor(color: self.currentColor)
        }
    }
    
    public var rightImage: UIImage? {
        didSet {
            self.contentStackView.snp.updateConstraints {
                if self.configuration?.style == .chip {
                    if rightImage != nil {
                        $0.right.equalToSuperview().offset(-(self.configuration?.padding?.right.withImage ?? 0.0))
                    } else {
                        $0.right.equalToSuperview().offset(-(self.configuration?.padding?.right.normal ?? 0.0))
                    }
                }
            }
            self.rightImageView.image = rightImage
            self.rightImageView.isHidden = (rightImage == nil)
            self.updateColor(color: self.currentColor)
        }
    }
    
    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            
            if newValue == true {
                self.updateColor(color: self.configuration?.color?.selected)
            } else {
                self.updateColor(color: self.configuration?.color?.normal)
            }
        }
    }
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            
            if newValue == true {
                self.updateColor(color: self.configuration?.color?.normal)
            } else {
                self.updateColor(color: self.configuration?.color?.disabled)
            }
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
//            self.backgroundColor = isHighlighted ? UIColor(rgb: 0x000000, alpha: 0.06) : ( self.isSelected ? self.configuration?.color?.selected?.background : self.configuration?.color?.normal.background)
            self.highlightView.alpha = isHighlighted ? 1.0 : 0.0
        }
    }
    
    init(font: UIFont, style: ClickableComponent.Configuration.Style, height: ClickableComponent.Configuration.Height, padding: ClickablePadding, color: ClickableColor, cornerRadius: ClickableComponent.Configuration.Corner?) {
        super.init(frame: .zero)
        var configuration = ClickableComponent.Configuration()
        configuration.style = style
        configuration.height = height
        configuration.padding = padding
        configuration.color = color
        self.configuration = configuration
        
        var height: CGFloat = 0.0
        if configuration.style == .button {
            height = configuration.height?.buttonHeight ?? 0.0
        } else {
            height = configuration.height?.chipHeight ?? 0.0
        }
        
        if let cornerRadius {
            switch cornerRadius {
            case .fixed(let radius):
                self.layer.cornerRadius = radius
            case .capsule:
                self.layer.cornerRadius = height/2.0
            case .none:
                self.layer.cornerRadius = 0.0
            }
            self.clipsToBounds = true
        }
        
        self.addSubview(self.highlightView)
        self.highlightView.then {
            $0.alpha = 0.0
            $0.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.06)
        }.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
        
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.spacing = 4.0
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(height)
            // 버튼은 컨텐츠 center / 칩은 이미지 좌우로 붙고 TitleLabel 늘어남
            if configuration.style == .button {
                $0.centerX.equalToSuperview()
                $0.left.greaterThanOrEqualToSuperview().offset(12.0)
                $0.right.lessThanOrEqualToSuperview().offset(-12.0)
            } else {
                $0.left.equalToSuperview().offset(configuration.padding?.left.normal ?? 0.0)
                $0.right.equalToSuperview().offset(-(configuration.padding?.right.normal ?? 0.0))
            }
        }
        
        self.contentStackView.addArrangedSubview(self.leftImageView)
        self.leftImageView.do {
            $0.isHidden = true
        }
        self.contentStackView.setCustomSpacing(configuration.padding?.left.internalSpacing ?? 0.0, after: self.leftImageView)
        
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.do {
            $0.font = font
            $0.isHidden = true
            if configuration.style == .button {
                $0.textAlignment = .center
            } else {
                $0.textAlignment = .left
            }
        }
        self.contentStackView.setCustomSpacing(configuration.padding?.right.internalSpacing ?? 0.0, after: self.titleLabel)
        
        self.contentStackView.addArrangedSubview(self.rightImageView)
        self.rightImageView.do {
            $0.isHidden = true
        }

        self.setBackgroundGradient(color: configuration.color?.normal)
        self.updateColor(color: configuration.color?.normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientBackgroundLayer = self.gradientBackgroundLayer {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientBackgroundLayer.frame = self.bounds
            CATransaction.commit()
        }
    }
    
    private func updateColor(color: ClickableColorSet?) {
        guard let color else { return }
        
        self.currentColor = color
        
        if let borderColor = color.border {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
        if color.gradientBackground != nil {
            self.gradientBackgroundLayer?.isHidden = false
        } else {
            self.gradientBackgroundLayer?.isHidden = true
        }
        self.backgroundColor = color.background
        self.titleLabel.textColor = color.text
        if let leftImage = self.leftImage {
            self.leftImageView.image = leftImage.withTintColor(color.text)
        }
        if let rightImage = self.rightImage {
            self.rightImageView.image = rightImage.withTintColor(color.text)
        }
    }
    
    private func setBackgroundGradient(color: ClickableColorSet?) {
        guard let gradientColors = color?.gradientBackground, gradientColors.count > 0 else { return }
        
        if let gradientBackgroundLayer = self.gradientBackgroundLayer {
            gradientBackgroundLayer.removeFromSuperlayer()
            self.gradientBackgroundLayer = nil
        }
        
        let layer = CAGradientLayer()
        layer.do {
            $0.colors = gradientColors.map({$0.cgColor})
            $0.locations = [0.0, 1.0]
            $0.startPoint = CGPoint(x: 0.0, y: 1.0)
            $0.endPoint = CGPoint(x: 1.0, y: 1.0)
            $0.frame = bounds
//            $0.cornerRadius = cornerRadius
        }
        self.layer.insertSublayer(layer, at: 0)
        self.gradientBackgroundLayer = layer
    }
    
}

extension ClickableComponent {
    
    public struct Configuration {
        
        public enum Corner {
            case none
            case fixed(_ radius: CGFloat)
            case capsule
        }
        
        public enum Style {
            case button
            case chip
        }
        
        public enum Height {
            case small
            case medium
            case large
            
            var buttonHeight: CGFloat {
                switch self {
                case .large:
                    return 50.0
                case .medium:
                    return 46.0
                default:
                    return 32.0
                }
            }
            
            var chipHeight: CGFloat {
                switch self {
                case .large:
                    return 46.0
                case .medium:
                    return 40.0
                default:
                    return 32.0
                }
            }
        }
        
        public var style: Style = .button
        
        public var font: UIFont?
        
        public var height: Height?
  
        public var color: ClickableColor?
        public var padding: ClickablePadding?
    }
    
}

public protocol ClickableColorConfig {
    var attribute: ClickableColor { get }
}

public struct ClickableColorSet {
    var gradientBackground: [UIColor]?
    var background: UIColor
    var text: UIColor
    var border: UIColor?
}

public struct ClickableColor {
    var normal: ClickableColorSet
    var selected: ClickableColorSet? // chip만 사용. button 없음.
    var disabled: ClickableColorSet
}

public protocol ClickableSizeConfig {
    var attribute: ClickableSize { get }
}

public struct ClickableSize {
    var height: ClickableComponent.Configuration.Height
    var padding: ClickablePadding
}


public struct ClickablePaddingSet {
    var normal: CGFloat
    var withImage: CGFloat
    var internalSpacing: CGFloat
}

public struct ClickablePadding {
    var left: ClickablePaddingSet
    var right: ClickablePaddingSet
}


//
//  ClickableComponent.swift
//  
//
//  Created by 박경우 on 2023/10/23.
//

import UIKit
import SnapKit

public class DealiControl {
    
}

final public class ClickableComponentButton: ClickableComponent {
    public init(config: ClickableConfig, color: ClickableColorConfig, functionName: String = #function) {
        super.init(style: .button, config: config, color: color.attribute)
#if DEBUG
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        if bundleID == "net.deali.DealiDesignSystemSampleApp" {
            self.title = functionName
        }
#endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class ClickableComponentChip: ClickableComponent {
    init(config: ClickableConfig, color: ClickableColorConfig, functionName: String = #function) {
        super.init(style: .chip, config: config, color: color.attribute)
#if DEBUG
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        if bundleID == "net.deali.DealiDesignSystemSampleApp" {
            self.title = functionName
        }
#endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class ClickableIndicatorView: UIView {
    private let indicatorImageView = UIImageView()

    private var indicatorImage: UIImage? {
        return UIImage(named: "loading")
    }
    
    var color: UIColor = .white {
        didSet {
            self.indicatorImageView.image = self.indicatorImage?.withTintColor(color)
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.indicatorImageView)
        self.indicatorImageView.then {
            $0.image = self.indicatorImage
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 21.0, height: 21.0))
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimating() {
        self.alpha = 1.0
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = .infinity
        self.indicatorImageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    public func stopAnimating() {
        self.alpha = 0.0
        self.indicatorImageView.layer.removeAllAnimations()
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
    
    private lazy var singleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var indicator: ClickableIndicatorView = {
        let indicatorView = ClickableIndicatorView()
        return indicatorView
    }()
    
    private var currentColor: ClickableColorSet?
    
    public var titleAlignment: NSTextAlignment = .center {
        didSet{
            if self.singleImage != nil {
                fatalError("singleImage가 있는 경우 title, leftImage, rightImage 사용 불가!")
            }
            self.titleLabel.textAlignment = titleAlignment
        }
    }
    
    public var title: String? {
        didSet {
            if self.singleImage != nil {
                fatalError("singleImage가 있는 경우 title, leftImage, rightImage 사용 불가!")
            }
            self.titleLabel.text = title
            self.titleLabel.isHidden = (title?.isEmpty ?? true)
            self.updateContent()
        }
    }

    
    /// 이미지 (텍스트 없음. 이미지 하나만 있는 경우)
    public var singleImage: ClickableImage? { // 가이드상에는 Chip에만 있음.
        didSet {
            
            if self.title != nil || self.leftImage != nil || self.rightImage != nil {
                fatalError("singleImage 사용하면 title, leftImage, rightImage 는 제거됩니다. 관련 코드 삭제 필요!!")
            }
        
            guard let image = singleImage else { return }
            
            self.contentStackView.removeFromSuperview()
            self.singleImageView.removeFromSuperview()
            self.addSubview(self.singleImageView)
            self.singleImageView.do {
                $0.image = image.uiImage
            }
            self.updateContent()
        }
    }
    
    /// 왼쪽 이미지(텍스트 포함 / rightImage와 함께 사용 가능)
    public var leftImage: ClickableImage? {
        didSet {
            if self.singleImage != nil {
                fatalError("singleImage가 있는 경우 title, leftImage, rightImage 사용 불가!")
            }
            self.leftImageView.image = leftImage?.uiImage
            self.leftImageView.isHidden = (leftImage == nil)
            self.updateContent()
        }
    }
    
    /// 오른쪽 이미지(텍스트 포함 / leftImage와 함께 사용 가능)
    public var rightImage: ClickableImage? {
        didSet {
            if self.singleImage != nil {
                fatalError("singleImage가 있는 경우 title, leftImage, rightImage 사용 불가")
            }
            self.rightImageView.image = rightImage?.uiImage
            self.rightImageView.isHidden = (rightImage == nil)
            self.updateContent()
        }
    }
    
    /// size
    public var fixedSize: CGSize {
        if self.configuration?.style == .button {
            return CGSize(width: self.fixedWidth, height: self.configuration?.height?.button ?? 0)
        } else {
            return CGSize(width: self.fixedWidth, height: self.configuration?.height?.chip ?? 0)
        }
    }
    
    /// size가 content 에 맞게 고정
    public var isFixedSize: Bool = false {
        didSet{
            guard self.singleImage == nil else { return }
            self.updateContentConstraints()
        }
    }
    
    /// content width
    private var fixedWidth: CGFloat {
        guard let configuration = self.configuration else { return 0.0 }
        
        var width: CGFloat = 0.0
        
        if let singleImage = self.singleImage {
            width += (configuration.singleImagePadding * 2.0)
            width += singleImage.uiImage?.size.width ?? 0.0
        } else {
            if let leftImage = self.leftImage {
                width += configuration.padding?.left.withImage ?? 0.0
                width += leftImage.uiImage?.size.width ?? 0.0
                width += configuration.padding?.left.internalSpacing ?? 0.0
            } else {
                width += configuration.padding?.left.normal ?? 0.0
            }
            
            width += ceil(self.titleLabel.intrinsicContentSize.width)
            if let rightImage = self.rightImage {
                width += configuration.padding?.right.withImage ?? 0.0
                width += rightImage.uiImage?.size.width ?? 0.0
                width += configuration.padding?.right.internalSpacing ?? 0.0
            } else {
                width += configuration.padding?.right.normal ?? 0.0
            }
        }
        return width
    }
    
    /// center 위치 offset (버튼만)
    private var horizontalOffset: CGFloat {
        // 버튼만 center 정렬이라 위치 조정. 칩은 이미지는 좌우 padding 고정이고 텍스트 left 정렬에 Label이 늘어남
        guard let style = self.configuration?.style, style == .button else { return 0.0 }
        
        var leftOffset: CGFloat = 0.0
        var rightOffset: CGFloat = 0.0
        if self.leftImage != nil {
            if let padding = self.configuration?.padding?.left {
                leftOffset = ((padding.normal - padding.withImage) / 2.0)
            }
        }
        if self.rightImage != nil {
            if let padding = self.configuration?.padding?.right {
                rightOffset = (padding.normal - padding.withImage) / 2.0
            }
        }
        return rightOffset - leftOffset
    }
    
    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            
            if self.configuration?.style == .chip { // 칩만 selected 가능.
                if self.isEnabled == true {
                    if newValue == true {
                        self.updateColor(color: self.configuration?.color?.selected)
                        self.titleLabel.font = self.configuration?.font?.selected
                    } else {
                        self.updateColor(color: self.configuration?.color?.normal)
                        self.titleLabel.font = self.configuration?.font?.normal
                    }
                }
            } else {
                // 버튼은 selected 상태의 디자인이 없습니다. selected 를 사용해야 한다면 chip을 사용하세요.
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
                if self.isSelected {
                    self.updateColor(color: self.configuration?.color?.selected)
                    self.titleLabel.font = self.configuration?.font?.selected
                } else {
                    self.updateColor(color: self.configuration?.color?.normal)
                    self.titleLabel.font = self.configuration?.font?.normal
                }
            } else {
                self.updateColor(color: self.configuration?.color?.disabled)
                self.titleLabel.font = self.configuration?.font?.disabled
            }
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            self.highlightView.alpha = isHighlighted ? 1.0 : 0.0
        }
    }
    
    init(style: ClickableComponent.Configuration.Style, config: ClickableConfig, color: ClickableColor) {
        super.init(frame: .zero)
        var configuration = ClickableComponent.Configuration()
        configuration.style = style
        configuration.height = config.height
        configuration.padding = config.padding.value(with: config.height, style: style)
        configuration.color = color
        configuration.font = config.font
        configuration.cornerRadius = config.cornerRadius
        self.configuration = configuration
        
        self.do {
            $0.snp.contentHuggingHorizontalPriority = 1000.0
            $0.snp.contentCompressionResistanceHorizontalPriority = 1000.0
            $0.snp.contentHuggingVerticalPriority = 1000.0
            $0.snp.contentCompressionResistanceVerticalPriority = 1000.0
        }
        
        var height: CGFloat = 0.0
        if configuration.style == .button {
            height = configuration.height?.button ?? 0.0
        } else {
            height = configuration.height?.chip ?? 0.0
        }
        
        switch config.cornerRadius {
        case .fixed(let radius):
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
        case .capsule:
            self.layer.cornerRadius = height/2.0
            self.clipsToBounds = true
        case .none:
            self.layer.cornerRadius = 0.0
        }
        
        
        self.addSubview(self.highlightView)
        self.highlightView.then {
            $0.alpha = 0.0
            $0.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.06)
        }.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
        
        self.addSubview(self.contentStackView)
        self.contentStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.spacing = 4.0
            $0.isUserInteractionEnabled = false
        }
        
        self.contentStackView.addArrangedSubview(self.leftImageView)
        self.leftImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        self.contentStackView.setCustomSpacing(configuration.padding?.left.internalSpacing ?? 0.0, after: self.leftImageView)
        
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.do {
            $0.font = config.font.normal
            $0.isHidden = true
            if configuration.style == .button {
                $0.textAlignment = .center
            } else {
                $0.textAlignment = .left
            }
        }
        self.contentStackView.setCustomSpacing(configuration.padding?.right.internalSpacing ?? 0.0, after: self.titleLabel)
        
        self.contentStackView.addArrangedSubview(self.rightImageView)
        self.rightImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
    
        self.setBackgroundGradient(color: configuration.color?.normal)
        self.updateContent(with: configuration.color?.normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // 백그라운드가 Gradient 인 경우 frame 조정
        if let gradientBackgroundLayer = self.gradientBackgroundLayer {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientBackgroundLayer.frame = self.bounds
            CATransaction.commit()
        }
    }
    
    /// content 상태 업데이트
    private func updateContent(with color: ClickableColorSet? = nil) {
        if let color {
            self.updateColor(color: color)
        } else {
            self.updateColor(color: self.currentColor)
        }
        
        self.updateContentConstraints()
    }
    
    /// 상태에 따른 content 색상 변경
    private func updateColor(color: ClickableColorSet?) {
        guard let color else { return }
        
        self.currentColor = color
        
        self.backgroundColor = color.background
        if self.configuration?.style == .button {
            self.indicator.color = color.text
        }
        if let singleImage = self.singleImage { // 싱글이미지인 경우 이미지 색상만 변경
            if singleImage.needOriginColor == false {
                self.singleImageView.image = singleImage.uiImage?.withTintColor(color.text)
            }
        } else {
            if let borderColor = color.border {
                self.layer.borderColor = borderColor.cgColor
                self.layer.borderWidth = 1.0
            }
            if color.gradientBackground != nil {
                self.gradientBackgroundLayer?.isHidden = false
            } else {
                self.gradientBackgroundLayer?.isHidden = true
            }
            
            self.titleLabel.textColor = color.text
            if let leftImage = self.leftImage, leftImage.needOriginColor == false {
                self.leftImageView.image = leftImage.uiImage?.withTintColor(color.text)
            }
            if let rightImage = self.rightImage, rightImage.needOriginColor == false {
                self.rightImageView.image = rightImage.uiImage?.withTintColor(color.text)
            }
        }
    }
    
    /// 제약조건 업데이트
    private func updateContentConstraints() {
        guard let configuration = self.configuration else { return }
        
        if self.singleImage != nil {
            
            self.singleImageView.snp.remakeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.bottom.equalToSuperview()
                $0.left.greaterThanOrEqualToSuperview().offset(configuration.singleImagePadding)
                $0.right.lessThanOrEqualToSuperview().offset(-configuration.singleImagePadding)
            }
            
        } else {
            
            let leftPadding: CGFloat = ((self.leftImage != nil) ? configuration.padding?.left.withImage : configuration.padding?.left.normal) ?? 0.0
            let rightPadding: CGFloat = ((self.rightImage != nil) ? configuration.padding?.right.withImage : configuration.padding?.right.normal) ?? 0.0
            
            
            self.contentStackView.snp.remakeConstraints { [weak self] in
                guard let self else { return }
                $0.top.bottom.equalToSuperview()
                if configuration.style == .button {
                    $0.height.equalTo(configuration.height?.button ?? 0.0)
                    if self.isFixedSize == true {
                        $0.left.equalToSuperview().offset(leftPadding)
                        $0.right.equalToSuperview().offset(-rightPadding)
                    } else {
                        let horizontalOffset = self.horizontalOffset
                        $0.centerX.equalToSuperview().offset(horizontalOffset)
                        $0.left.greaterThanOrEqualToSuperview().offset(leftPadding+(horizontalOffset))
                        $0.right.lessThanOrEqualToSuperview().offset(-rightPadding+(horizontalOffset))
                    }
                } else {
                    $0.height.equalTo(configuration.height?.chip ?? 0.0)
                    $0.left.equalToSuperview().offset(leftPadding)
                    $0.right.equalToSuperview().offset(-rightPadding)
                }
            }
            
        }
        
        // 전체 constraints에서 width constraint만 filter
        let widthconstraints = self.constraints.filter({ $0.firstAttribute.rawValue == 7 })
        // width constraints 제거
        self.removeConstraints(widthconstraints)
        // width constraint 다시 추가
        if self.isFixedSize == true {
            self.widthAnchor.constraint(equalToConstant: self.fixedWidth).isActive = true
        } else {
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.fixedWidth).isActive = true
        }
        /*
         Author 박경우
         왜 snapkit도 안쓰고 이렇게 했나요?
         외부에서 Clickable 의 constraints 을 설정하는 상황이 있을 수 있음.
         기존 constraints 를 유지하면서 width만 변경은 snapkit으로는 불가.
         */
    }

    /// Gradient Background
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
    
    // MARK: Indicator
    open func startIndicator() {
        self.singleImageView.alpha = 0.0
        self.contentStackView.alpha = 0.0
        self.addSubview(self.indicator)
        self.indicator.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        self.indicator.startAnimating()
    }

    open func stopIndicator() {
        self.singleImageView.alpha = 1.0
        self.contentStackView.alpha = 1.0
        self.indicator.stopAnimating()
    }
    
    @available(*, unavailable, message: "singleImage or leftImage or rightImage를 사용하세요. ex) $0.leftImage = ClickableImage(named: \"이미지명\")")
    func setImage(_ image: UIImage?, for state: UIControl.State) {
        
    }
    
    @available(*, unavailable, message: "디자인 시스템은 백그라운드 색상을 변경할 수 없습니다.")
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        
    }
    
    @available(*, unavailable, message: "디자인 시스템은 백그라운드를 변경할 수 없습니다.")
    func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {

    }
    
    @available(*, unavailable, message: "title 사용하세요. ex) $0.title = \"\"")
    func setTitle(_ title: String?, for state: UIControl.State) {
        
    }
    
    @available(*, unavailable, message: "디자인 시스템은 타이틀 색상을 변경할 수 없습니다.")
    func setTitleColor(_ color: UIColor, for state: UIControl.State) {
        
    }
    
}

extension ClickableComponent {
    
    public struct Configuration {
        
        public var singleImagePadding: CGFloat {
            switch self.height {
            case .large:
                return 16.0
            case .medium:
                return 12.0
            case .small:
                return 8.0
            case .none:
                return 0.0
            }
        }
        
        public enum Corner {
            case none
            case fixed(_ radius: CGFloat)
            case capsule
            var isCapsule: Bool {
                switch self {
                case .capsule:
                    return true
                default:
                    return false
                }
            }
        }
        
        public enum Style {
            case button
            case chip
        }
        
        public enum Height {
            case small
            case medium
            case large
            
            var button: CGFloat {
                switch self {
                case .large:
                    return 50.0
                case .medium:
                    return 46.0
                default:
                    return 32.0
                }
            }
            
            var chip: CGFloat {
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
        
        public enum Padding {
            case square
            case raund
            case text
            
            public func value(with height: ClickableComponent.Configuration.Height, style: ClickableComponent.Configuration.Style) -> ClickablePadding {
                switch height {
                case .large:
                    return self.largePadding(with: style)
                case .medium:
                    return self.mediumPadding(with: style)
                case .small:
                    return self.smallPadding(with: style)
                }
            }
            
            private func largePadding(with style: ClickableComponent.Configuration.Style) -> ClickablePadding {
                switch self {
                case .square:
                    if style == .button {
                        return ClickablePadding(left: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0),
                                                right: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0))
                    } else {
                        return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                                right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0))
                    }
                case .raund:
                    return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                            right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0))
                case .text:
                    return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0),
                                            right: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0))
                }
            }
            
            private func mediumPadding(with style: ClickableComponent.Configuration.Style) -> ClickablePadding {
                switch self {
                case .square:
                    if style == .button {
                        return ClickablePadding(left: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0),
                                                right: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0))
                    } else {
                        return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                                right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0))
                    }
                case .raund:
                    return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                            right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0))
                case .text:
                    return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0),
                                            right: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0))
                }
            }
            
            private func smallPadding(with style: ClickableComponent.Configuration.Style) -> ClickablePadding {
                switch self {
                case .square:
                    return ClickablePadding(left: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0),
                                            right: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0))
                case .raund:
                    if style == .button {
                        return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                                right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0))
                    } else {
                        return ClickablePadding(left: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0),
                                                right: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0))
                    }
                case .text:
                    return ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0),
                                            right: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0))
                }
            }
            
        }

        public var style: Style = .button
        
        public var font: ClickableFont?
        
        public var height: Height?
        public var color: ClickableColor?
        public var padding: ClickablePadding?
        public var cornerRadius: ClickableComponent.Configuration.Corner = .none
    }
}

// MARK: - Font
public struct ClickableFont {
    var normal: UIFont
    var selected: UIFont?
    var disabled: UIFont
    
    static func button(font: UIFont) -> ClickableFont {
        // 버튼은 selected 상태가 없음.
        return ClickableFont(normal: font, selected: nil, disabled: font)
    }
    
    static func chip(font: UIFont) -> ClickableFont {
        return ClickableFont(normal: font, selected: font, disabled: font)
    }
}

// MARK: - Color
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
    var selected: ClickableColorSet? // chip만 사용. button은 seleted 상태 없음.
    var disabled: ClickableColorSet
}

// MARK: - Config
public protocol ClickableConfig {
    var font: ClickableFont { get }
    var height: ClickableComponent.Configuration.Height { get }
    var cornerRadius: ClickableComponent.Configuration.Corner { get }
    var padding: ClickableComponent.Configuration.Padding { get }
}

// MARK: - Padding
public struct ClickablePaddingSet {
    /// 이미지가 없는 경우 Padding
    var normal: CGFloat
    /// 이미지가 있는 경우 Padding
    var withImage: CGFloat
    /// 이미지와 타이틀 사이 spacing
    var internalSpacing: CGFloat
}

public struct ClickablePadding {
    var left: ClickablePaddingSet
    var right: ClickablePaddingSet
}

// MARK: - Image
public struct ClickableImage {
    /// 이미지명
    var named: String
    /// 이미지 색상 유지?
    var needOriginColor: Bool = false // true = 이미지 색상 유지 / false = 상태마다 타이틀 생상과 동일
    fileprivate var uiImage: UIImage?
    public init(named name: String, needOriginColor: Bool = false) {
        self.named = name
        self.needOriginColor = needOriginColor
        self.uiImage = UIImage(named: name)
    }
    public init(_ image: UIImage?, needOriginColor: Bool = false) {
        self.named = ""
        self.uiImage = image
        self.needOriginColor = needOriginColor
    }
}

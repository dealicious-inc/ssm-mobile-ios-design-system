//
//  DealiClickableButtonUnitView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 8/21/25.
//

import UIKit

final public class ClickableUnitButtonComponent: ClickableUnitButton {
    public init(config: ClickableUnitButtonConfig, color: ClickableUnitButtonColor, functionName: String = #function) {
        super.init(config: config, color: color)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class ClickableUnitButton: SystemButton {

    private var preset: ClickableUnitButton.ButtonPreset
    private var gradientBackgroundLayer: CAGradientLayer?
    private let contentContainerView = UIView()
    private let contentStackView = UIStackView()
    private let dealiTitleLabel = UILabel()
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()
    
    private var currentColor: ClickableUnitButtonColorSet?
    
    private lazy var singleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var indicator: ClickableIndicatorView = {
        let indicatorView = ClickableIndicatorView()
        return indicatorView
    }()
    
    public var title: String? {
        didSet {
//            if self.singleImage != nil {
//                fatalError("singleImage가 있는 경우 title, attributedTitle, leftImage, rightImage 사용 불가!")
//            }
            guard let title = self.title else {
                self.attributedTitle = nil
                return
            }
            let titleFont: UIFont = (self.isEnabled == true ? (self.preset.font?.normal ?? .b3sb13) : (self.preset.font?.disabled ?? .b3sb13))
            
            self.attributedTitle = NSMutableAttributedString(string: title)
                .font(titleFont)
                .alignment(.center)
                .setLineHeight()
        }
    }

    public var attributedTitle: NSAttributedString? {
        didSet {
//            if self.singleImage != nil {
//                fatalError("singleImage가 있는 경우 title, attributedTitle, leftImage, rightImage 사용 불가!")
//            }
            self.dealiTitleLabel.attributedText = attributedTitle
            self.dealiTitleLabel.isHidden = (attributedTitle?.string.isEmpty ?? true)
            self.updateContent()
        }
    }
    
    /// 왼쪽 이미지(텍스트 포함 / rightImage와 함께 사용 가능)
    public var leftImage: ClickableImage? {
        didSet {
//            if self.singleImage != nil {
//                fatalError("singleImage가 있는 경우 title, leftImage, rightImage 사용 불가!")
//            }
            self.leftImageView.image = leftImage?.uiImage
            self.leftImageView.isHidden = (leftImage == nil)
            self.updateContent()
        }
    }
    
    /// 오른쪽 이미지(텍스트 포함 / leftImage와 함께 사용 가능)
    public var rightImage: ClickableImage? {
        didSet {
//            if self.singleImage != nil {
//                fatalError("singleImage가 있는 경우 title, leftImage, rightImage 사용 불가")
//            }
            self.rightImageView.image = rightImage?.uiImage
            self.rightImageView.isHidden = (rightImage == nil)
            self.updateContent()
        }
    }
    
    public var isFixedSize: Bool = false {
        didSet{
//            guard self.singleImage == nil else { return }
            self.updateContentConstraints()
        }
    }
    
    public override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
        print("isEnabled")
            if newValue == true {
                self.updateColor(color: self.preset.color?.normal)
                self.dealiTitleLabel.font = self.preset.font?.normal
            } else {
                self.updateColor(color: self.preset.color?.disabled)
                self.dealiTitleLabel.font = self.preset.font?.disabled
            }
        }
    }
    
    private var contentSize: CGSize = .zero
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard (self.contentSize == .zero || self.contentSize != self.bounds.size) else { return }
        self.contentSize = self.bounds.size
        print("layoutSubviews 0 = \(self.bounds.size.height)")
        if self.preset.cornerRadius == .normal {
            print("self.hieght normal = \(self.bounds.height)")
            self.setCornerRadius(self.preset.cornerRadius.radius(with: self.preset.buttonType), borderWidth: 1.0, borderColor: self.currentColor?.border)
        } else {
            print("self.hieght round = \(self.bounds.height)")
            self.setCornerRadius((self.bounds.height / 2.0), borderWidth: 1.0, borderColor: self.currentColor?.border)
        }
    }

    public init(config: ClickableUnitButtonConfig, color: ClickableUnitButtonColor) {
        var preset = ClickableUnitButton.ButtonPreset()
        preset.buttonType = config.buttonType
        preset.heightPadding = config.buttonType.heightPadding
        preset.widthPadding = config.buttonPadding.widthPadding(with: config.buttonType)
        preset.font = config.font
        preset.color = color
        preset.cornerRadius = config.cornerRadius
        self.preset = preset
        
        super.init(frame: .zero)
        
        
        self.addSubview(self.contentContainerView)
        self.contentContainerView.then {
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(preset.heightPadding ?? 0.0)
            $0.left.equalToSuperview().offset(preset.widthPadding?.normal ?? 0.0)
            $0.right.equalToSuperview().offset(-(preset.widthPadding?.normal ?? 0.0))
        }
        
        self.contentContainerView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = preset.widthPadding?.internalSpacing ?? 4.0
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.leftImageView)
        self.leftImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(preset.buttonType.imageSize)
            $0.centerY.equalToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.dealiTitleLabel)
        self.dealiTitleLabel.then {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.lineBreakMode = .byWordWrapping
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.rightImageView)
        self.rightImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(preset.buttonType.imageSize)
            $0.centerY.equalToSuperview()
        }
        
        self.setBackgroundGradient(color: self.preset.color?.normal)
        self.updateColor(color: self.preset.color?.normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Gradient Background
    private func setBackgroundGradient(color: ClickableUnitButtonColorSet?) {
        guard let gradient = color?.gradient else { return }
        
        if let gradientBackgroundLayer = self.gradientBackgroundLayer {
            gradientBackgroundLayer.removeFromSuperlayer()
            self.gradientBackgroundLayer = nil
        }

        let gradientLayer = self.setSystemGradient(gradient)
        self.gradientBackgroundLayer = gradientLayer
    }
    
    /// content 상태 업데이트
    private func updateContent(with color: ClickableUnitButtonColorSet? = nil) {
        if let color {
            self.updateColor(color: color)
        } else {
            self.updateColor(color: self.currentColor)
        }
        
        self.updateContentConstraints()
    }
    
    /// 상태에 따른 content 색상 변경
    private func updateColor(color: ClickableUnitButtonColorSet?) {
        guard let color else { return }
        
        self.currentColor = color
        
        self.backgroundColor = color.background
        self.indicator.color = color.text
        
        //        if let singleImage = self.singleImage { // 싱글이미지인 경우 이미지 색상만 변경
        //            if singleImage.needOriginColor == false {
        //                self.singleImageView.image = singleImage.uiImage?.withTintColor(color.text)
        //            }
        //        } else {
        if let borderColor = color.border {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        }
        if color.gradient != nil {
            self.gradientBackgroundLayer?.isHidden = false
        } else {
            self.gradientBackgroundLayer?.isHidden = true
        }
        
        if let attributedText = self.dealiTitleLabel.attributedText {
            self.dealiTitleLabel.attributedText = NSMutableAttributedString(attributedString: attributedText).color(color.text)
        }
        
        if let leftImage = self.leftImage, leftImage.needOriginColor == false {
            self.leftImageView.image = leftImage.uiImage?.withTintColor(color.text)
        }
        if let rightImage = self.rightImage, rightImage.needOriginColor == false {
            self.rightImageView.image = rightImage.uiImage?.withTintColor(color.text)
        }
    }
    
    private func updateContentConstraints() {
        let leftPadding: CGFloat = (self.leftImage != nil ? self.preset.widthPadding?.withImage : self.preset.widthPadding?.normal) ?? 0.0
        let rightPadding: CGFloat = (self.rightImage != nil ? self.preset.widthPadding?.withImage : self.preset.widthPadding?.normal) ?? 0.0
        
//        self.contentStackView.snp.remakeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.bottom.equalToSuperview()
//            if self.isFixedSize == true {
//                $0.left.equalToSuperview()
//                $0.right.equalToSuperview()
//            } else {
//                $0.left.greaterThanOrEqualToSuperview()
//                $0.right.lessThanOrEqualToSuperview()
//            }
//        }
        
        self.contentContainerView.snp.updateConstraints {
            $0.left.equalToSuperview().offset(leftPadding)
            $0.right.equalToSuperview().offset(-rightPadding)
        }
        
//        self.layoutIfNeeded()
//        
//        if self.preset.cornerRadius == .normal {
//            print("self.hieght = \(self.bounds.height)")
//            self.setCornerRadius(self.preset.cornerRadius.radius(with: self.preset.buttonType), borderWidth: 1.0, borderColor: self.currentColor?.border)
//        } else {
//            print("self.hieght = \(self.bounds.height)")
//            self.setCornerRadius((self.bounds.height / 2.0), borderWidth: 1.0, borderColor: self.currentColor?.border)
//        }
        
    }
    
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

}

extension ClickableUnitButton {
    public struct ButtonPreset {
        
        public enum ButtonType {
            case large
            case semiMedium
            case medium
            case small
            
            var imageSize: CGSize {
                switch self {
                case .large, .medium, .semiMedium:
                    return CGSize(width: 20.0, height: 20.0)
                case .small:
                    return CGSize(width: 20.0, height: 20.0)
                }
            }
            
            var heightPadding: CGFloat {
                switch self {
                case .large:
                    return 15.0
                case .medium:
                    return 13.0
                case .semiMedium:
                    return 10.0
                case .small:
                    return 7.0
                }
            }
        }
        
        public enum ButtonPadding {
            case normal
            case text
            
            public func widthPadding(with buttonType: ClickableUnitButton.ButtonPreset.ButtonType) -> ClickableUnitButtonWidthPadding {
                switch self {
                case .normal:
                    switch buttonType {
                    case .large, .medium:
                        return ClickableUnitButtonWidthPadding(normal: 20.0, withImage: 16.0, internalSpacing: 4.0)
                    case .semiMedium:
                        return ClickableUnitButtonWidthPadding(normal: 16.0, withImage: 12.0, internalSpacing: 4.0)
                    case .small:
                        return ClickableUnitButtonWidthPadding(normal: 12.0, withImage: 8.0, internalSpacing: 4.0)
                    }
                case .text:
                    return ClickableUnitButtonWidthPadding(normal: 16.0, withImage: 16.0, internalSpacing: 4.0)
                }
            }
            
        }
        
        public enum Corner {
            case normal
            case round
            
            public func radius(with buttonType: ClickableUnitButton.ButtonPreset.ButtonType) -> CGFloat {
                switch self {
                case .normal:
                    switch buttonType {
                    case .large, .medium, .semiMedium:
                        return 6.0
                    case .small:
                        return 4.0
                    }
                case .round:
                    return 0.0
                }
            }
        }
        
        public var buttonType: ButtonType = .large
        public var heightPadding: CGFloat?
        public var widthPadding: ClickableUnitButtonWidthPadding?
        public var font: ClickableUnitButtonFont?
        public var color: ClickableUnitButtonColor?
        public var cornerRadius: ClickableUnitButton.ButtonPreset.Corner = .normal
    }
}

// MARK: - Font
public struct ClickableUnitButtonFont {
    var normal: UIFont
    var disabled: UIFont
    
    static func set(font: UIFont) -> ClickableUnitButtonFont {
        return ClickableUnitButtonFont(normal: font, disabled: font)
    }
}

public struct ClickableUnitButtonColorSet {
    var gradient: GradientConfigurable?
    var background: UIColor
    var text: UIColor
    var border: UIColor?
}

public struct ClickableUnitButtonColor {
    var normal: ClickableUnitButtonColorSet
    var disabled: ClickableUnitButtonColorSet
}

// MARK: - Padding
public struct ClickableUnitButtonWidthPadding {
    /// 이미지가 없는 경우 Padding
    var normal: CGFloat
    /// 이미지가 있는 경우 Padding
    var withImage: CGFloat
    /// 이미지와 타이틀 사이 spacing
    var internalSpacing: CGFloat
}

public protocol ClickableUnitButtonConfig {
    var font: ClickableUnitButtonFont { get }
    var buttonType: ClickableUnitButton.ButtonPreset.ButtonType { get }
    var buttonPadding: ClickableUnitButton.ButtonPreset.ButtonPadding { get }
    var cornerRadius: ClickableUnitButton.ButtonPreset.Corner { get }
}

// MARK: - Image
public struct ClickableImage {
    /// 이미지명
    var named: String
    /// 이미지 색상 유지?
    var needOriginColor: Bool = false // true = 이미지 색상 유지 / false = 상태마다 타이틀 생상과 동일
    var uiImage: UIImage?
    public init(named name: String, needOriginColor: Bool = false) {
        self.named = name
        self.needOriginColor = needOriginColor
        self.uiImage = UIImage(named: name)
    }
    public init(dealiIconName: String, needOriginColor: Bool = false) {
        self.named = dealiIconName
        self.needOriginColor = needOriginColor
        self.uiImage = UIImage.dealiIcon(named: dealiIconName)?.resize(CGSize(width: 16.0, height: 16.0))
    }
    public init(_ image: UIImage?, needOriginColor: Bool = false) {
        self.named = ""
        self.uiImage = image
        self.needOriginColor = needOriginColor
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ClickableButtonUnitViewPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"
    
    static var previews: some View {
        VStack(alignment: .leading) {

            Text("RadioButtonWithText")
//            UIViewPreview {
//                let radioButtonWithText = ClickableButtonUnitView()
//                
//
//                return radioButtonWithText
//            }
//            .padding(.bottom, 10.0)
//            
//            UIViewPreview {
//                let radioButtonWithText = DealiRadioButtonWithText()
//                radioButtonWithText.text = testString
//                radioButtonWithText.isSelected = true
//                radioButtonWithText.cannotDeselect = true
//                return radioButtonWithText
//            }
//            .padding(.bottom, 10.0)
//
//            UIViewPreview {
//                let radioButtonWithText = DealiRadioButtonWithText()
//                radioButtonWithText.text = testString
//                radioButtonWithText.attributedText = .init()
//                radioButtonWithText.isEnabled = false
//                return radioButtonWithText
//            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

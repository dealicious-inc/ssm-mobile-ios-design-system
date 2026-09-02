//
//  DealiTag.swift
//
//
//  Created by 박경우 on 12/7/23.
//

import UIKit
import Then
import SnapKit

public final class DealiTag: UIView {

    public override var intrinsicContentSize: CGSize {
        self.titleLabel.sizeToFit()
        let size = self.type.size
        if self.showsIconArea {
            return CGSize(width: size.height, height: size.height)
        }

        var width = self.titleLabel.frame.width + size.padding * 2
        if self.showsLeftIconArea {
            width += self.type.layoutSizeCategory.iconDimension
        }
        if self.showsRightIconArea {
            width += self.type.layoutSizeCategory.iconDimension
        }
        return CGSize(width: width, height: size.height)
    }

    public var text: String? {
        didSet {
            self.titleLabel.text = text
            self.invalidateIntrinsicContentSize()
        }
    }

    /// 좌측 아이콘.
    public var leftIcon: UIImage? {
        didSet {
            self.refreshIcons()
        }
    }

    /// 우측 아이콘.
    public var rightIcon: UIImage? {
        didSet {
            self.refreshIcons()
        }
    }

    /// 단독 아이콘. 설정 시 leftIcon/rightIcon과 text 대신 아이콘만 표시합니다.
    public var icon: UIImage? {
        didSet {
            self.refreshIcons()
        }
    }

    public var type: EType = .tagFilledLarge01 {
        didSet {
            self.applyTypeStyle()
        }
    }

    /// 아이콘 이미지와 컨테이너 사이 여백. 기본값 0이면 아이콘이 컨테이너를 꽉 채운다. 외부에서 값을 지정해 여백을 줄 수 있다.
    public var iconImageInset: CGFloat = 0.0 {
        didSet {
            self.refreshIcons()
        }
    }

    private var showsLeftIconArea: Bool {
        self.icon == nil && self.leftIcon != nil
    }

    private var showsRightIconArea: Bool {
        self.icon == nil && self.rightIcon != nil
    }

    private var showsIconArea: Bool {
        self.icon != nil
    }

    private let contentStackView = UIStackView()
    private let iconContainer = UIView()
    private let iconImageView = UIImageView()
    private let leftIconContainer = UIView()
    private let leftIconImageView = UIImageView()
    private let rightIconContainer = UIView()
    private let rightIconImageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.do {
            $0.layer.cornerRadius = 4.0
            $0.clipsToBounds = true
        }
        self.setUpIcons()
        self.addSubview(self.contentStackView)
        self.contentStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 0.0
            $0.isLayoutMarginsRelativeArrangement = true
        }
        self.contentStackView.addArrangedSubview(self.iconContainer)
        self.contentStackView.addArrangedSubview(self.leftIconContainer)
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.contentStackView.addArrangedSubview(self.rightIconContainer)

        self.titleLabel.do {
            $0.textAlignment = .center
        }

        self.initTag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initTag() {
        self.type = .tagFilledLarge02
    }

    private func setUpIcons() {
        self.iconContainer.addSubview(self.iconImageView)
        self.iconImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(0)
        }

        self.leftIconContainer.addSubview(self.leftIconImageView)
        self.leftIconImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().inset(self.iconImageInset)
        }

        self.rightIconContainer.addSubview(self.rightIconImageView)
        self.rightIconImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().inset(self.iconImageInset)
        }

        self.iconContainer.snp.makeConstraints {
            $0.width.height.equalTo(0)
        }
        self.leftIconContainer.snp.makeConstraints {
            $0.width.height.equalTo(0)
        }
        self.rightIconContainer.snp.makeConstraints {
            $0.width.height.equalTo(0)
        }
    }

    private func applyTypeStyle() {
        let size = self.type.size
        let category = self.type.layoutSizeCategory
        let color = self.type.color
        let iconDimension = category.iconDimension
        let gap = category.iconTextSpacing

        self.titleLabel.font = self.type.font
        self.titleLabel.textColor = color.textColor
        self.setCornerRadius(size.cornerRadius)

        self.backgroundColor = color.backgroundColor
        if let borderColor = color.borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.0
        } else {
            self.layer.borderWidth = 0.0
        }

        self.contentStackView.spacing = gap
        self.updateContentLayoutMargins()

        self.contentStackView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(size.height)
        }

        self.titleLabel.snp.remakeConstraints {
            $0.height.equalTo(size.height)
        }

        let showIcon = self.showsIconArea
        let showLeftIcon = self.showsLeftIconArea
        let showRightIcon = self.showsRightIconArea
        self.iconContainer.isHidden = !showIcon
        self.leftIconContainer.isHidden = !showLeftIcon
        self.rightIconContainer.isHidden = !showRightIcon
        self.titleLabel.isHidden = showIcon

        self.iconContainer.snp.updateConstraints {
            $0.width.height.equalTo(showIcon ? iconDimension : 0)
        }

        self.leftIconContainer.snp.updateConstraints {
            $0.width.height.equalTo(showLeftIcon ? iconDimension : 0)
        }
        self.rightIconContainer.snp.updateConstraints {
            $0.width.height.equalTo(showRightIcon ? iconDimension : 0)
        }

        self.refreshIcons()
        self.invalidateIntrinsicContentSize()
    }

    private func updateContentLayoutMargins() {
        let size = self.type.size
        let category = self.type.layoutSizeCategory
        let gap = self.type.layoutSizeCategory.iconTextSpacing
        if self.showsIconArea {
            let padding = category.iconOnlyPadding
            self.contentStackView.layoutMargins = UIEdgeInsets(
                top: padding,
                left: padding,
                bottom: padding,
                right: padding
            )
            return
        }

        let leftPadding = max(0, size.padding - (self.showsLeftIconArea ? gap : 0))
        let rightPadding = max(0, size.padding - (self.showsRightIconArea ? gap : 0))
        self.contentStackView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: leftPadding,
            bottom: 0,
            right: rightPadding
        )
    }

    private func refreshIcons() {
        let color = self.type.color
        let category = self.type.layoutSizeCategory
        let iconDimension = category.iconDimension
        let iconInset = self.iconImageInset

        let showIcon = self.showsIconArea
        let showLeftIcon = self.showsLeftIconArea
        let showRightIcon = self.showsRightIconArea

        self.iconContainer.isHidden = !showIcon
        self.leftIconContainer.isHidden = !showLeftIcon
        self.rightIconContainer.isHidden = !showRightIcon
        self.titleLabel.isHidden = showIcon
        self.updateContentLayoutMargins()

        if let img = self.icon {
            self.iconImageView.image = img.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = color.textColor
            self.iconImageView.isHidden = false
        } else {
            self.iconImageView.image = nil
            self.iconImageView.isHidden = true
        }

        if let img = self.leftIcon {
            self.leftIconImageView.image = img.withRenderingMode(.alwaysTemplate)
            self.leftIconImageView.tintColor = color.textColor
            self.leftIconImageView.isHidden = false
        } else {
            self.leftIconImageView.image = nil
            self.leftIconImageView.isHidden = true
        }

        if let img = self.rightIcon {
            self.rightIconImageView.image = img.withRenderingMode(.alwaysTemplate)
            self.rightIconImageView.tintColor = color.textColor
            self.rightIconImageView.isHidden = false
        } else {
            self.rightIconImageView.image = nil
            self.rightIconImageView.isHidden = true
        }

        self.iconImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(showIcon ? iconDimension : 0)
        }
        self.leftIconImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().inset(iconInset)
        }
        self.rightIconImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().inset(iconInset)
        }

        self.iconContainer.snp.updateConstraints {
            $0.width.height.equalTo(showIcon ? iconDimension : 0)
        }
        self.leftIconContainer.snp.updateConstraints {
            $0.width.height.equalTo(showLeftIcon ? iconDimension : 0)
        }
        self.rightIconContainer.snp.updateConstraints {
            $0.width.height.equalTo(showRightIcon ? iconDimension : 0)
        }

        self.invalidateIntrinsicContentSize()
    }

}

public extension DealiTag {
    enum ESize: String, CaseIterable {
        case large
        case medium
        case semiMedium
        case small

        public struct LayoutMetrics {
            public var height: CGFloat
            public var padding: CGFloat
            public var cornerRadius: CGFloat

            public init(height: CGFloat, padding: CGFloat, cornerRadius: CGFloat = 4.0) {
                self.height = height
                self.padding = padding
                self.cornerRadius = cornerRadius
            }
        }

        public var layoutMetrics: LayoutMetrics {
            switch self {
            case .large:
                return LayoutMetrics(height: 28.0, padding: 8.0)
            case .medium:
                return LayoutMetrics(height: 26.0, padding: 8.0)
            case .semiMedium:
                return LayoutMetrics(height: 22.0, padding: 6.0)
            case .small:
                return LayoutMetrics(height: 16.0, padding: 4.0, cornerRadius: 3.0)
            }
        }

        public var font: UIFont {
            switch self {
            case .large:
                return .b2sb14
            case .medium, .semiMedium:
                return .b4sb12
            case .small:
                return .c1sb10
            }
        }

        public var iconDimension: CGFloat {
            switch self {
            case .large:
                return 20.0
            case .medium, .semiMedium:
                return 16.0
            case .small:
                return 12.0
            }
        }

        public var iconTextSpacing: CGFloat {
            2.0
        }

        public var iconOnlyPadding: CGFloat {
            (self.layoutMetrics.height - self.iconDimension) / 2
        }
    }

    enum EType: String {
        /// Background:Pink/Text:Pink
        case tagFilledLarge01
        /// Background:Blue/Text:Blue
        case tagFilledLarge02
        /// Background:Orange/Text:Orange
        case tagFilledLarge03
        /// Background:Gray/Text:Gray
        case tagFilledLarge04
        /// Background:Dark/Text:White
        case tagFilledLarge05
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineLarge01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineLarge02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineLarge03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineLarge04
        /// Background:White/Text:Dark/Border:Gray
        case tagOutlineLarge05
        /// Background:Clear/Text:Dark
        case tagTextLarge05
        /// Background:Pink/Text:Pink
        case tagFilledMedium01
        /// Background:Blue/Text:Blue
        case tagFilledMedium02
        /// Background:Orange/Text:Orange
        case tagFilledMedium03
        /// Background:Gray/Text:Gray
        case tagFilledMedium04
        /// Background:Dark/Text:White
        case tagFilledMedium05
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineMedium01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineMedium02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineMedium03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineMedium04
        /// Background:White/Text:Dark/Border:Gray
        case tagOutlineMedium05
        /// Background:Clear/Text:Dark
        case tagTextMedium05
        /// Background:Pink/Text:Pink
        case tagFilledSemiMedium01
        /// Background:Blue/Text:Blue
        case tagFilledSemiMedium02
        /// Background:Orange/Text:Orange
        case tagFilledSemiMedium03
        /// Background:Gray/Text:Gray
        case tagFilledSemiMedium04
        /// Background:Dark/Text:White
        case tagFilledSemiMedium05
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineSemiMedium01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineSemiMedium02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineSemiMedium03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineSemiMedium04
        /// Background:White/Text:Dark/Border:Gray
        case tagOutlineSemiMedium05
        /// Background:Clear/Text:Dark
        case tagTextSemiMedium05
        /// Background:Pink/Text:Pink
        case tagFilledSmall01
        /// Background:Blue/Text:Blue
        case tagFilledSmall02
        /// Background:Orange/Text:Orange
        case tagFilledSmall03
        /// Background:Gray/Text:Gray
        case tagFilledSmall04
        /// Background:Dark/Text:White
        case tagFilledSmall05
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineSmall01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineSmall02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineSmall03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineSmall04
        /// Background:White/Text:Dark/Border:Gray
        case tagOutlineSmall05
        /// Background:Clear/Text:Dark
        case tagTextSmall05

        public var layoutSizeCategory: ESize {
            Self.layoutSizeCategory(forTypeName: rawValue)
        }

        private static func layoutSizeCategory(forTypeName name: String) -> ESize {
            if name.contains("Large") { return ESize.large }
            if name.contains("SemiMedium") { return ESize.semiMedium }
            if name.contains("Medium") { return ESize.medium }
            if name.contains("Small") { return ESize.small }
            return .small
        }

        public enum Style {
            case filled
            case outline
            case text
        }

        public init?(size: ESize, outline: Bool, variant: Int) {
            self.init(size: size, style: outline ? .outline : .filled, variant: variant)
        }

        public init?(size: ESize, style: Style, variant: Int) {
            guard (1...5).contains(variant) else { return nil }
            let sizeSegment: String
            switch size {
            case .large:
                sizeSegment = "Large"
            case .medium:
                sizeSegment = "Medium"
            case .semiMedium:
                sizeSegment = "SemiMedium"
            case .small:
                sizeSegment = "Small"
            }
            let styleSegment: String
            switch style {
            case .filled:
                styleSegment = "Filled"
            case .outline:
                styleSegment = "Outline"
            case .text:
                styleSegment = "Text"
            }
            let rawValue = "tag\(styleSegment)\(sizeSegment)0\(variant)"
            self.init(rawValue: rawValue)
        }

        public var font: UIFont {
            self.layoutSizeCategory.font
        }

        public struct DealiTagSize {
            public var height: CGFloat
            public var padding: CGFloat
            public var cornerRadius: CGFloat

            public init(height: CGFloat, padding: CGFloat, cornerRadius: CGFloat = 4.0) {
                self.height = height
                self.padding = padding
                self.cornerRadius = cornerRadius
            }
        }

        public var size: DealiTagSize {
            let m = self.layoutSizeCategory.layoutMetrics
            return DealiTagSize(height: m.height, padding: m.padding, cornerRadius: m.cornerRadius)
        }

        struct DealiTagColor {
            var backgroundColor: UIColor
            var textColor: UIColor
            var borderColor: UIColor?
        }

        var color: DealiTagColor {
            let name = self.rawValue
            let number = Int(name.suffix(2))

            if name.contains("Filled") == true {
                switch number {
                case 1:
                    return DealiTagColor(backgroundColor: .primary03, textColor: .primary01)
                case 2:
                    return DealiTagColor(backgroundColor: .secondary03, textColor: .secondary01)
                case 3:
                    return DealiTagColor(backgroundColor: .secondary06, textColor: .secondary04)
                case 4:
                    return DealiTagColor(backgroundColor: .g10, textColor: .g80)
                default: // 5
                    return DealiTagColor(backgroundColor: .g10, textColor: .g100)
                }
            } else if name.contains("Outline") == true {
                switch number {
                case 1:
                    return DealiTagColor(backgroundColor: .primary04, textColor: .primary01, borderColor: .primary01)
                case 2:
                    return DealiTagColor(backgroundColor: .primary04, textColor: .secondary01, borderColor: .secondary01)
                case 3:
                    return DealiTagColor(backgroundColor: .primary04, textColor: .secondary04, borderColor: .secondary04)
                case 4:
                    return DealiTagColor(backgroundColor: .primary04, textColor: .g80, borderColor: .g20)
                default: // 5
                    return DealiTagColor(backgroundColor: .primary04, textColor: .g100, borderColor: .g20)
                }
            } else {
                return DealiTagColor(backgroundColor: .clear, textColor: .g80)
            }
        }
    }

}

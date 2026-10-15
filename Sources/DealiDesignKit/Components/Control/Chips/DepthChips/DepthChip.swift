//
//  DepthChip.swift
//  DealiDesignKit
//
//  Created by 이창호 on 10/15/26.
//

import UIKit

/// Depth 칩의 한 단계. `카테고리 > 하위 카테고리` 처럼 단계마다 제목과 좌우 아이콘을 둘 수 있다
public struct DealiDepthChipItem {
    public var title: String
    public var leftImage: UIImage?
    public var rightImage: UIImage?

    public init(title: String, leftImage: UIImage? = nil, rightImage: UIImage? = nil) {
        self.title = title
        self.leftImage = leftImage
        self.rightImage = rightImage
    }
}

/**
 설명: 여러 단계를 `>` 로 이어 보여주고 오른쪽 끝에 삭제(X) 아이콘을 두는 칩 (Figma chipFilledDepth*01).
 칩 전체 탭은 UIControl 이벤트로, X 아이콘 탭은 `onDeleteTap` 으로 받는다
 ```swift
 let chip = DealiControl.chipFilledDepthSmall01()
 chip.items = [.init(title: "여성의류"), .init(title: "아우터"), .init(title: "코트")]
 chip.onDeleteTap = { ... }
 ```
 */
public class DealiDepthChip: DealiChip {

    public override var intrinsicContentSize: CGSize {
        self.contentStackView.layoutIfNeeded()
        let width = self.configuration.horizontalPadding * 2.0 + self.contentStackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        return CGSize(width: ceil(width), height: self.configuration.height)
    }

    /// 단계 목록. 바꾸면 내용을 다시 그린다
    public var items: [DealiDepthChipItem] = [] {
        didSet {
            self.rebuildDepth()
        }
    }

    /// X 아이콘 탭. nil 이면 X 아이콘을 숨긴다
    public var onDeleteTap: (() -> Void)? {
        didSet {
            self.deleteImageView.isHidden = (self.onDeleteTap == nil)
            self.deleteButton.isHidden = (self.onDeleteTap == nil)
            self.invalidateIntrinsicContentSize()
        }
    }

    let configuration: DepthChipConfig

    private let highlightView = UIView()
    private let contentStackView = UIStackView()
    private let depthStackView = UIStackView()
    private let deleteImageView = UIImageView()
    private let deleteButton = UIButton(type: .custom)
    private var titleLabels: [UILabel] = []
    private var tintedImageViews: [UIImageView] = []

    init(configuration: DepthChipConfig) {
        self.configuration = configuration
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }
            self.highlightView.alpha = isHighlighted ? 1.0 : 0.0
        }
    }

    override func setUI() {
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)

        self.snp.makeConstraints {
            $0.height.equalTo(self.configuration.height)
        }

        self.layer.cornerRadius = self.configuration.cornerRadius
        self.layer.masksToBounds = true

        self.addSubview(self.highlightView)
        self.highlightView.then {
            $0.alpha = 0.0
            $0.backgroundColor = .b2
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = self.configuration.deleteSpacing
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(self.configuration.horizontalPadding)
            $0.top.bottom.equalToSuperview()
        }

        self.contentStackView.addArrangedSubview(self.depthStackView)
        self.depthStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = self.configuration.itemSpacing
        }

        self.contentStackView.addArrangedSubview(self.deleteImageView)
        self.deleteImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFit
            $0.image = self.configuration.deleteImage?.withRenderingMode(.alwaysTemplate)
        }.snp.makeConstraints {
            $0.size.equalTo(self.configuration.iconSize)
        }

        self.addSubview(self.deleteButton)
        self.deleteButton.then {
            $0.isHidden = true
            $0.addTarget(self, action: #selector(self.handleDeleteTap), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalTo(44.0)
        }
    }

    override func updateUI(for status: DealiChipStatus) {
        let color = self.configuration.color(for: status)
        self.backgroundColor = color.backgroundColor
        self.titleLabels.forEach {
            $0.font = self.configuration.font(for: status)
            $0.textColor = color.textColor
        }
        self.tintedImageViews.forEach {
            $0.tintColor = color.textColor
        }
        self.deleteImageView.tintColor = color.textColor
        self.invalidateIntrinsicContentSize()
    }

    @objc private func handleDeleteTap() {
        self.onDeleteTap?()
    }

    private func rebuildDepth() {
        self.depthStackView.arrangedSubviews.forEach {
            self.depthStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        self.titleLabels = []
        self.tintedImageViews = []

        // 단계에 아이콘이 하나라도 있으면 단계 사이를 8, 없으면 4로 벌린다 (Figma Show Icon 규칙)
        let hasItemIcon = self.items.contains { $0.leftImage != nil || $0.rightImage != nil }
        self.depthStackView.spacing = hasItemIcon ? self.configuration.itemSpacingWithIcon : self.configuration.itemSpacing

        for (index, item) in self.items.enumerated() {
            if index > 0 {
                let arrowImageView = self.makeIconImageView(image: self.configuration.arrowImage)
                self.depthStackView.addArrangedSubview(arrowImageView)
            }

            let itemStackView = UIStackView()
            itemStackView.do {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.spacing = self.configuration.itemContentSpacing
            }
            if let leftImage = item.leftImage {
                itemStackView.addArrangedSubview(self.makeIconImageView(image: leftImage))
            }
            let titleLabel = UILabel()
            titleLabel.do {
                $0.text = item.title
                $0.numberOfLines = 1
                $0.lineBreakMode = .byTruncatingTail
            }
            self.titleLabels.append(titleLabel)
            itemStackView.addArrangedSubview(titleLabel)
            if let rightImage = item.rightImage {
                itemStackView.addArrangedSubview(self.makeIconImageView(image: rightImage))
            }
            self.depthStackView.addArrangedSubview(itemStackView)
        }

        self.updateUI(for: self.status)
    }

    private func makeIconImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.then {
            $0.image = image?.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.size.equalTo(self.configuration.iconSize)
        }
        self.tintedImageViews.append(imageView)
        return imageView
    }
}

/// Depth 칩 크기·색 묶음. 색은 FilledDepth 01 한 가지라 크기만 고른다
struct DepthChipConfig {
    enum Size {
        case large
        case medium
        case small
    }

    let size: Size

    var height: CGFloat {
        switch self.size {
        case .large:
            return 46.0
        case .medium:
            return 40.0
        case .small:
            return 32.0
        }
    }

    let cornerRadius: CGFloat = 4.0
    let horizontalPadding: CGFloat = 12.0
    /// 단계 묶음과 X 아이콘 사이
    let deleteSpacing: CGFloat = 16.0
    /// 단계와 `>` 사이. 단계에 아이콘이 있으면 `itemSpacingWithIcon`
    let itemSpacing: CGFloat = 4.0
    let itemSpacingWithIcon: CGFloat = 8.0
    /// 단계 안 아이콘과 제목 사이
    let itemContentSpacing: CGFloat = 4.0
    let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)

    var arrowImage: UIImage? {
        return UIImage.dealiIcon(named: "ic_arrow_right")
    }

    var deleteImage: UIImage? {
        switch self.size {
        case .large, .medium:
            return UIImage.dealiIcon(named: "ic_x")
        case .small:
            return UIImage.dealiIcon(named: "ic_x_s")
        }
    }

    func font(for status: DealiChipStatus) -> UIFont {
        switch self.size {
        case .large, .medium:
            return .b2sb14
        case .small:
            return status == .selected ? .b2sb14 : .b2r14
        }
    }

    func color(for status: DealiChipStatus) -> ChipColor {
        switch status {
        case .normal:
            return ChipColor(textColor: .g100, backgroundColor: .g10)
        case .selected:
            return ChipColor(textColor: .g100, backgroundColor: .g20)
        case .disabled:
            return ChipColor(textColor: .g50, backgroundColor: .g10)
        }
    }
}

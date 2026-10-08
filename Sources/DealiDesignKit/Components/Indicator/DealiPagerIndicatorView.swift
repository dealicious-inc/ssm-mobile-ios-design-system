//
//  DealiPagerIndicatorView.swift
//
//
//  Created by 이창호 on 10/8/26.
//

import UIKit

/**
 설명: 좌/우 버튼으로 페이지를 넘기는 버튼형 페이지 인디케이터(number4)
 */
public final class DealiPagerIndicatorView: DealiIndicatorView {
    
    /// 버튼 탭으로 페이지가 바뀐 뒤 호출한다. 바뀐 페이지 index를 전달한다.
    public var pageChangedHandler: ((Int) -> Void)?
    
    private let previousButton = DealiPagerArrowButton(direction: .previous)
    private let nextButton = DealiPagerArrowButton(direction: .next)
    private let currentPageLabel = UILabel()
    private let numberOfPagesLabel = UILabel()
    
    private let preset: DealiIndicatorPreset
    
    /// 가운데 페이지 텍스트 영역 최소 폭. 자릿수가 바뀌어도 버튼 위치가 흔들리지 않게 한다.
    private let pageTextMinWidth: CGFloat = 60.0
    /// 현재 페이지와 전체 페이지 텍스트 사이 간격
    private let pageTextSpacing: CGFloat = 4.0
    
    public override var numberOfPages: Int {
        didSet {
            self.numberOfPagesLabel.text = String(format: "/ %d", self.numberOfPages)
            self.changedCurrentPage(index: self.currentPage)
        }
    }
    
    public override var currentPage: Int {
        willSet {
            guard newValue != self.currentPage else { return }
            self.changedCurrentPage(index: newValue)
        }
    }
    
    init(preset: DealiIndicatorPreset) {
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.then {
            $0.backgroundColor = preset.backgroundColor
        }.snp.makeConstraints {
            $0.height.equalTo(preset.indicatorViewHeight)
        }
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = preset.contentSpacing
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.previousButton)
        self.previousButton.addTarget(self, action: #selector(self.previousButtonTapped), for: .touchUpInside)
        
        let pageTextContainerView = UIView()
        contentStackView.addArrangedSubview(pageTextContainerView)
        pageTextContainerView.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(self.pageTextMinWidth)
        }
        
        let pageTextStackView = UIStackView()
        pageTextContainerView.addSubview(pageTextStackView)
        pageTextStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = self.pageTextSpacing
        }.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        
        pageTextStackView.addArrangedSubview(self.currentPageLabel)
        self.currentPageLabel.do {
            $0.font = preset.selectFont
            $0.textColor = preset.selectColor
            $0.text = "0"
            $0.textAlignment = .center
        }
        
        pageTextStackView.addArrangedSubview(self.numberOfPagesLabel)
        self.numberOfPagesLabel.do {
            $0.font = preset.normalFont
            $0.textColor = preset.normalColor
            $0.text = "/ 0"
            $0.textAlignment = .center
        }
        
        contentStackView.addArrangedSubview(self.nextButton)
        self.nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        
        self.changedCurrentPage(index: self.currentPage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func changedCurrentPage(index: Int, animated: Bool = true) {
        self.currentPageLabel.text = String(format: "%d", (index + 1))
        self.previousButton.isEnabled = (index > 0)
        self.nextButton.isEnabled = (index < (self.numberOfPages - 1))
    }
    
    @objc private func previousButtonTapped() {
        guard self.currentPage > 0 else { return }
        self.currentPage -= 1
        self.pageChangedHandler?(self.currentPage)
    }
    
    @objc private func nextButtonTapped() {
        guard self.currentPage < (self.numberOfPages - 1) else { return }
        self.currentPage += 1
        self.pageChangedHandler?(self.currentPage)
    }
}

/// 페이저 좌/우 화살표 버튼. 색상은 btnOutlineBgSmall06과 같은 토큰(`ButtonOutlineBgColor.secondary04`)을 쓰고 크기는 50×32로 고정한다.
private final class DealiPagerArrowButton: UIControl {
    
    enum Direction {
        case previous
        case next
    }
    
    private static let buttonSize = CGSize(width: 50.0, height: 32.0)
    private static let iconSize = CGSize(width: 18.0, height: 18.0)
    
    private let iconImageView = UIImageView()
    private let icon: UIImage
    private let colorAttribute = ButtonOutlineBgColor.secondary04.attribute
    
    override var isEnabled: Bool {
        didSet {
            self.updateColor()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = (self.isHighlighted ? 0.6 : 1.0)
        }
    }
    
    init(direction: Direction) {
        let image = (direction == .previous ? DealiIcon.ic_arrow_left.image : DealiIcon.ic_arrow_right.image)
        self.icon = image.resize(Self.iconSize)
        
        super.init(frame: .zero)
        
        self.then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 4.0
            $0.layer.borderWidth = 1.0
        }.snp.makeConstraints {
            $0.size.equalTo(Self.buttonSize)
        }
        
        self.addSubview(self.iconImageView)
        self.iconImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Self.iconSize)
        }
        
        self.updateColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateColor() {
        let colorSet = (self.isEnabled ? self.colorAttribute.normal : self.colorAttribute.disabled)
        self.backgroundColor = colorSet.background
        self.layer.borderColor = (colorSet.border ?? .clear).cgColor
        self.iconImageView.image = self.icon.withTintColor(colorSet.text)
    }
}

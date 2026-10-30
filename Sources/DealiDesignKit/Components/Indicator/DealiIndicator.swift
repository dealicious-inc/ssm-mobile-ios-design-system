//
//  DealiIndicator.swift
//  
//
//  Created by 이창호 on 4/17/24.
//

import UIKit

public class DealiIndicator {
    public static func dots() -> DealiIndicatorView {
        return DealiDotsIndicatorView(preset: .dots)
    }
    
    public static func dotsw() -> DealiIndicatorView {
        return DealiDotsIndicatorView(preset: .dotsw)
    }
    
    public static func number1() -> DealiIndicatorView {
        return DealiNumberIndicatorView(preset: .number1)
    }
    
    public static func number2() -> DealiIndicatorView {
        return DealiNumberIndicatorView(preset: .number2)
    }
    
    public static func number3() -> DealiIndicatorView {
        return DealiNumberIndicatorView(preset: .number3)
    }
    
    /// 좌/우 버튼으로 페이지를 넘기는 버튼형 페이저. 페이지 변경 콜백은 `DealiPagerIndicatorView.pageChangedHandler`
    public static func number4() -> DealiPagerIndicatorView {
        return DealiPagerIndicatorView(preset: .number4)
    }
}

public class DealiIndicatorView: UIView {
    public var numberOfPages: Int = 0
    public var currentPage: Int = 0
    func changedCurrentPage(index: Int, animated: Bool = true) {
        
    }
}

/**
 설명: 점 페이지 인디케이터(dots, dotsw). 선택 점은 선택된 점에 제약으로 붙여 두어 다시 배치돼도 자리를 지킨다
 */
public final class DealiDotsIndicatorView: DealiIndicatorView {
    
    private var indicatorViewArray: [UIView] = []
    private let selectedIndicatorView = UIView()
    private let contentStackView = UIStackView()
    
    private let preset: DealiIndicatorPreset
    
    public override var numberOfPages: Int {
        didSet {
            self.rebuildIndicatorViews()
            // 점을 새로 만들었으므로 선택 점을 다시 붙인다. 점 수가 줄어 선택 페이지가 범위를 벗어나면 마지막 점으로 맞춘다
            self.applyCurrentPage(self.clampedPage(self.currentPage), animated: false)
        }
    }
    
    public override var currentPage: Int {
        didSet {
            let page = self.clampedPage(self.currentPage)
            guard page != oldValue else {
                super.currentPage = page
                return
            }
            // 첫 점과 마지막 점을 바로 오갈 때(배너 무한 롤링)는 애니메이션 없이 옮긴다
            let lastIndex = self.numberOfPages - 1
            let isWrapping = (oldValue == 0 && page == lastIndex) || (oldValue == lastIndex && page == 0)
            self.applyCurrentPage(page, animated: isWrapping == false)
        }
    }
    
    init(preset: DealiIndicatorPreset) {
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.do {
            $0.backgroundColor = preset.backgroundColor
        }
        
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = preset.contentSpacing
        }.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        self.addSubview(self.selectedIndicatorView)
        self.selectedIndicatorView.then {
            $0.backgroundColor = preset.selectColor
            $0.clipsToBounds = true
            $0.layer.cornerRadius = (preset.dotsSize.height / 2.0)
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(preset.dotsSize)
            $0.left.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func changedCurrentPage(index: Int, animated: Bool = true) {
        guard let indicatorView = self.indicatorViewArray[safe: index] else {
            self.selectedIndicatorView.isHidden = true
            return
        }
        
        self.selectedIndicatorView.isHidden = false
        self.selectedIndicatorView.snp.remakeConstraints {
            $0.size.equalTo(self.preset.dotsSize)
            $0.center.equalTo(indicatorView)
        }
        
        // 화면에 붙기 전에는 배치할 크기가 없어 애니메이션 없이 다음 배치에 맡긴다
        guard animated, self.window != nil else {
            self.setNeedsLayout()
            return
        }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private func rebuildIndicatorViews() {
        self.indicatorViewArray.removeAll()
        self.contentStackView.subviews.forEach({ $0.removeFromSuperview() })
        
        for index in 0..<max(self.numberOfPages, 0) {
            let indicatorImageView = UIView()
            self.contentStackView.addArrangedSubview(indicatorImageView)
            indicatorImageView.then {
                $0.backgroundColor = self.preset.normalColor
                $0.tag = index
                $0.clipsToBounds = true
                $0.layer.cornerRadius = self.preset.cornerRadius
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.size.equalTo(self.preset.dotsSize)
            }
            
            self.indicatorViewArray.append(indicatorImageView)
        }
    }
    
    /// 선택 페이지를 저장하고 선택 점을 옮긴다. super에 직접 써서 observer를 다시 타지 않는다
    private func applyCurrentPage(_ page: Int, animated: Bool) {
        super.currentPage = page
        self.changedCurrentPage(index: page, animated: animated)
    }
    
    /// 0 ~ 마지막 점 사이로 맞춘 페이지. 점이 아직 없으면 값을 그대로 두어, 뒤에 점 수를 넣을 때 그 페이지를 선택한다
    private func clampedPage(_ page: Int) -> Int {
        guard self.numberOfPages > 0 else { return max(page, 0) }

        return min(max(page, 0), self.numberOfPages - 1)
    }
    
}

class DealiNumberIndicatorView: DealiIndicatorView {
    
    private let numberOfPagesLabel = UILabel()
    private let currentPageLabel = UILabel()
    
    public override var numberOfPages: Int {
        didSet {
            if case .number1 = preset {
                self.numberOfPagesLabel.text = String(format: "%d", self.numberOfPages)
            } else {
                self.numberOfPagesLabel.text = String(format: "/ %d", self.numberOfPages)
            }
            
            self.changedCurrentPage(index: self.currentPage)
        }
    }
    
    public override var currentPage: Int {
        willSet {
            guard newValue != self.currentPage else { return }
            self.changedCurrentPage(index: newValue)
        }
    }
    
    private let preset: DealiIndicatorPreset
    
    init(preset: DealiIndicatorPreset) {
        
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.then {
            $0.backgroundColor = preset.backgroundColor
            $0.clipsToBounds = true
            $0.layer.cornerRadius = preset.cornerRadius
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
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(preset.contentPadding)
        }
        
        contentStackView.addArrangedSubview(self.currentPageLabel)
        self.currentPageLabel.then {
            $0.font = preset.selectFont
            $0.textColor = preset.selectColor
            $0.text = "0"
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        if case .number1 = preset {
            let dividerImageView = UIImageView()
            contentStackView.addArrangedSubview(dividerImageView)
            dividerImageView.then {
                $0.backgroundColor = .w20
            }.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 1.0, height: 10.0))
            }
        }
        
        contentStackView.addArrangedSubview(self.numberOfPagesLabel)
        self.numberOfPagesLabel.then {
            $0.font = preset.normalFont
            $0.textColor = preset.normalColor
            $0.text = "0"
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func changedCurrentPage(index: Int, animated: Bool = true) {
        self.currentPageLabel.text = String(format: "%d", (index + 1))
    }
}

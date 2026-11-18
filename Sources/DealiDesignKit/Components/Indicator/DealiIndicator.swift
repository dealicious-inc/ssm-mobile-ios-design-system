//
//  DealiIndicator.swift
//  
//
//  Created by 이창호 on 4/17/24.
//

import UIKit

public class DealiIndicator {
    /// `maxVisibleDots`를 주면 점을 그 수까지만 그리고, 창 밖에 페이지가 더 있는 쪽 끝 점을 4pt로 줄인다(Indicator Guide). 없으면 페이지 수만큼 모두 그린다
    public static func dots(maxVisibleDots: Int? = nil) -> DealiIndicatorView {
        return DealiDotsIndicatorView(preset: .dots, maxVisibleDots: maxVisibleDots)
    }
    
    public static func dotsw(maxVisibleDots: Int? = nil) -> DealiIndicatorView {
        return DealiDotsIndicatorView(preset: .dotsw, maxVisibleDots: maxVisibleDots)
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
 설명: 점 페이지 인디케이터(dots, dotsw). 선택 점은 선택된 점에 제약으로 붙여 두어 다시 배치돼도 자리를 지킨다.
 `maxVisibleDots`가 있으면 그 수만큼의 창만 그리고, 선택 페이지가 작은 끝 점 자리에 오지 않게 창을 민다
 */
public final class DealiDotsIndicatorView: DealiIndicatorView {
    
    /// 지금 그려진 점. 창을 쓰면 창 안의 페이지 순서다
    private var indicatorViewArray: [UIView] = []
    private let selectedIndicatorView = UIView()
    private let contentStackView = UIStackView()
    
    private let preset: DealiIndicatorPreset
    /// 한 번에 보여줄 최대 점 수. nil이면 페이지 수만큼 모두 그린다. 끝 점 2개와 선택 점 자리가 필요해 3 아래로는 내리지 않는다
    private let maxVisibleDots: Int?
    /// 창의 첫 페이지. 창을 쓰지 않으면 항상 0
    private(set) var windowStart: Int = 0
    
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
    
    init(preset: DealiIndicatorPreset, maxVisibleDots: Int? = nil) {
        self.preset = preset
        self.maxVisibleDots = maxVisibleDots.map { max($0, 3) }
        
        super.init(frame: .zero)
        
        self.do {
            $0.backgroundColor = preset.backgroundColor
        }
        
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            // 작은 끝 점이 큰 점과 가운데 맞도록 center로 둔다
            $0.alignment = .center
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
        let didWindowMove = self.moveWindow(toShow: index)
        
        guard let indicatorView = self.indicatorViewArray[safe: index - self.windowStart] else {
            self.selectedIndicatorView.isHidden = true
            return
        }
        
        self.selectedIndicatorView.isHidden = false
        self.selectedIndicatorView.snp.remakeConstraints {
            $0.size.equalTo(self.preset.dotsSize)
            $0.center.equalTo(indicatorView)
        }
        
        // 화면에 붙기 전에는 배치할 크기가 없어 애니메이션 없이 다음 배치에 맡긴다. 창이 밀려 점들의 뜻이 바뀐 때도 바로 그린다
        guard animated, didWindowMove == false, self.window != nil else {
            self.setNeedsLayout()
            return
        }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    /// 실제로 그릴 점 수. 창을 쓰면 최대 점 수까지다
    private var visibleDotCount: Int {
        let pageCount = max(self.numberOfPages, 0)
        guard let maxVisibleDots = self.maxVisibleDots else { return pageCount }
        
        return min(pageCount, maxVisibleDots)
    }
    
    private func rebuildIndicatorViews() {
        self.indicatorViewArray.removeAll()
        self.contentStackView.subviews.forEach({ $0.removeFromSuperview() })
        
        for index in 0..<self.visibleDotCount {
            let indicatorImageView = UIView()
            self.contentStackView.addArrangedSubview(indicatorImageView)
            indicatorImageView.then {
                $0.backgroundColor = self.preset.normalColor
                $0.tag = index
                $0.clipsToBounds = true
                $0.layer.cornerRadius = self.preset.cornerRadius
            }.snp.makeConstraints {
                $0.size.equalTo(self.preset.dotsSize)
            }
            
            self.indicatorViewArray.append(indicatorImageView)
        }
    }
    
    /// 선택 페이지가 작은 끝 점 자리에 오지 않게 창을 민 뒤 끝 점 크기를 맞춘다. 창이 움직였으면 true
    private func moveWindow(toShow page: Int) -> Bool {
        let count = self.visibleDotCount
        let oldStart = self.windowStart
        var start = 0
        if self.numberOfPages > count {
            start = min(max(self.windowStart, 0), self.numberOfPages - count)
            // 창 밖에 페이지가 더 있는 쪽 끝 점은 작게 그리므로 선택 점이 설 수 있는 범위는 그만큼 좁다
            let lowest = start > 0 ? start + 1 : start
            let highest = (start + count < self.numberOfPages) ? start + count - 2 : start + count - 1
            if page < lowest {
                start = max(page - 1, 0)
            } else if page > highest {
                start = min(page + 2 - count, self.numberOfPages - count)
            }
        }
        self.windowStart = start
        self.applyDotSizes()
        return start != oldStart
    }
    
    /// 창 밖에 페이지가 더 있는 쪽 끝 점만 작게, 나머지는 기본 크기로 둔다
    private func applyDotSizes() {
        let count = self.indicatorViewArray.count
        for (position, indicatorView) in self.indicatorViewArray.enumerated() {
            let hasMoreBefore = (position == 0 && self.windowStart > 0)
            let hasMoreAfter = (position == count - 1 && self.windowStart + count < self.numberOfPages)
            let size = (hasMoreBefore || hasMoreAfter) ? self.preset.compactDotsSize : self.preset.dotsSize
            indicatorView.layer.cornerRadius = size.height / 2.0
            indicatorView.snp.remakeConstraints {
                $0.size.equalTo(size)
            }
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

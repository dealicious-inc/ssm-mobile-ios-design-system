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
}

public class DealiIndicatorView: UIView {
    public var numberOfPages: Int = 0
    public var currentPage: Int = 0
    func changedCurrentPage(index: Int, animated: Bool = true) {
        
    }
}

public final class DealiDotsIndicatorView: DealiIndicatorView {
    
    private var indicatorViewArray: [UIView] = []
    private let selectedIndicatorView = UIView()
    
    public override var numberOfPages: Int {
        didSet {
            self.indicatorViewArray.removeAll()
            self.contentStackView.subviews.forEach({ $0.removeFromSuperview() })
            
            for index in 0..<self.numberOfPages {
                let indicatorImageView = UIView()
                self.contentStackView.addArrangedSubview(indicatorImageView)
                indicatorImageView.then {
                    $0.backgroundColor = preset.normalColor
                    $0.tag = index
                    $0.clipsToBounds = true
                    $0.layer.cornerRadius = preset.cornerRadius
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.size.equalTo(preset.dotsSize)
                }
                
                self.indicatorViewArray.append(indicatorImageView)
            }
            
            self.changedCurrentPage(index: self.currentPage, animated: false)
        }
    }
    
    public override var currentPage: Int {
        willSet {
            guard newValue != self.currentPage else { return }
            if (newValue == 0 && self.currentPage == (self.numberOfPages - 1)) || (newValue == (self.numberOfPages - 1) && self.currentPage == 0) {
                self.changedCurrentPage(index: newValue, animated: false)
            } else {
                self.changedCurrentPage(index: newValue)
            }
        }
    }
    
    private let contentStackView = UIStackView()
    
    private let preset: DealiIndicatorPreset
    
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
            $0.left.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func changedCurrentPage(index: Int, animated: Bool = true) {
        self.selectedIndicatorView.isHidden = false
        if index >= self.numberOfPages {
            self.currentPage = 0
        } else {
            if let indicatorView = self.indicatorViewArray.first(where: { $0.tag == index }) {
                UIView.animate(withDuration: (animated ? 0.1 : 0.0)) { [weak self] in
                    guard let self else { return }
                    self.selectedIndicatorView.center = indicatorView.center
                }
            }
        }
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
                $0.backgroundColor = DealiColor.w20
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

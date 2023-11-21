//
//  DealiSliderBarWithRangeIndicatorView.swift
//
//
//  Created by 윤조현 on 2023/11/14.
//

import UIKit

/**
슬라이더 + 가격범위까지 담긴 뷰.
 */
public final class DealiSliderBarWithRangeIndicatorView: UIView {
    
    public var sliderBar = DealiSliderBar()
    public var rangeIndicatorArray: [String] = [] {
        didSet {
            for subView in self.rangeContentStackView.arrangedSubviews {
                subView.removeFromSuperview()
            }
            
            self.rangeIndicatorArray.forEach {
                self.rangeContentStackView.addArrangedSubview(RangeIndicatorView(title: $0))
            }
        }
    }
    
    private var rangeContentStackView = UIStackView()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.sliderBar)
        self.sliderBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(7.5)
        }
        
        self.addSubview(self.rangeContentStackView)
        self.rangeContentStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }.snp.makeConstraints {
            $0.top.equalTo(self.sliderBar.snp.bottom).offset(4.0)
            $0.left.right.equalToSuperview().inset(21.0)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(28.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class RangeIndicatorView: UIView {
        
        var title: String
        
        init(title: String) {
            self.title = title
            
            super.init(frame: .zero)

            
            let indicatorView = UIView()
            self.addSubview(indicatorView)
            indicatorView.then {
                $0.backgroundColor = DealiColor.g30
            }.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.width.equalTo(1.0)
                $0.height.equalTo(6.0)
            }
            
            self.addSubview(self.titleLabel)
            self.titleLabel.then {
                $0.textColor = DealiColor.g80
                $0.text = self.title
                $0.font = .b4r12
                $0.textAlignment = .center
            }.snp.makeConstraints {
                $0.left.right.bottom.equalToSuperview()
                $0.height.equalTo(18.0)
                $0.top.equalTo(indicatorView.snp.bottom).offset(4.0)
                $0.width.equalTo(40.0)
            }
        }
        
        private let titleLabel = UILabel()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

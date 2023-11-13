//
//  DealiSliderBar.swift
//
//
//  Created by 윤조현 on 2023/11/13.
//

import UIKit


public final class DealiSliderBar: UIControl {
    
    public var minValue: Int = 0
    public var maxValue: Int = 0
    
    private let minThumbView = UIView()
    private let maxThumbView = UIView()
    
    private let barView = UIView()
    private let activeRangeBarView = UIView()
    
    public convenience init(minValue: Int, maxValue: Int) {
        self.init(frame: .zero)

        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(self.barView)
        self.barView.then {
            //**TODO: @윤조현 디자인팀에 색상 확인해보기
            $0.backgroundColor = DealiColor.g30
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(22.0)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(6.0)
        }
        
        self.addSubview(self.minThumbView)
        self.minThumbView.then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 11.0
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
            $0.layer.shadowOpacity = 0.22
            $0.layer.shadowRadius = 3.0

        }.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 22.0, height: 22.0))
        }
        
        
        self.addSubview(self.maxThumbView)
        
        self.maxThumbView.then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 11.0
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
            $0.layer.shadowOpacity = 0.22
            $0.layer.shadowRadius = 3.0

        }.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 22.0, height: 22.0))
        }
        
        
        
    }
}

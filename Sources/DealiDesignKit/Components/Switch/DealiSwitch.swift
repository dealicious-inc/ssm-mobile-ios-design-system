//
//  DealiSwitch.swift
//
//
//  Created by 윤조현 on 2023/11/09.
//

import UIKit

///
/// Toggle/Switch Component
///
///
///
public class DealiSwitch: UIControl {
    
    public var size: SizeType = .small {
        didSet {
            self.setupViews()
        }
    }
    
    public enum SizeType {
        case large
        case small
        
        var contentSize: CGSize {
            switch self {
            case .large:
                return CGSize(width: 50.0, height: 30.0)
            case .small:
                return CGSize(width: 36.0, height: 22.0)
            }
        }
        
        var thumbWidth: CGFloat {
            switch self {
            case .large:
                return 26.0
            case .small:
                return 18.0
            }
        }
        
        var cornerRadius: CGFloat {
            return self.contentSize.height / 2.0
        }
    }
    
    private var backgroundView = UIView()
    private var thumbView = UIView()
    public var isOn = false
    
    public convenience init(size: SizeType = .small) {
        self.init(frame: .zero)
        self.size = size
        self.setupViews()
    }
    
    // 커스텀 스위치의 초기 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    // 뷰 및 레이아웃 설정
    private func setupViews() {
        self.backgroundView.removeFromSuperview()
        self.thumbView.removeFromSuperview()
        
        self.backgroundView = UIView()
        self.thumbView = UIView()
        
        // 탭 제스처
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.switchTapped))
        self.addGestureRecognizer(tapGesture)
        
        
        // 배경 뷰 설정
        self.addSubview(self.backgroundView)
        
        self.backgroundView.then {
            $0.backgroundColor = .g30
            $0.clipsToBounds = true
            $0.layer.cornerRadius = self.size.cornerRadius
        }.snp.makeConstraints {
            $0.size.equalTo(self.size.contentSize)
            $0.edges.equalToSuperview()
        }
        
        // 썸 뷰(스위치의 움직이는 부분) 설정
        self.addSubview(self.thumbView)
        self.thumbView.then {
            $0.backgroundColor = .primary04
            $0.layer.cornerRadius = self.size.cornerRadius - 2.0
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
            $0.layer.shadowOpacity = 0.22
            
        }.snp.makeConstraints {
            $0.width.height.equalTo(self.size.thumbWidth)
            $0.top.bottom.equalToSuperview().inset(2.0)
            $0.left.equalToSuperview().offset(2.0)
        }
    }
    
    // 스위치의 On/Off 상태를 토글하는 메서드
    @objc private func switchTapped() {
        self.setOn(!isOn, animated: true)
        self.sendActions(for: .valueChanged)
        
    }
    
    // 스위치의 On/Off 상태를 설정하는 메서드
    public func setOn(_ on: Bool, animated: Bool) {
        self.isOn = on
        
        let targetX = on ? self.size.contentSize.width - self.size.thumbWidth - 2.0 : 2.0
        let backgroundColor: UIColor = on ? .primary01 : .g30
        
        if animated {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self else { return }
                self.backgroundView.backgroundColor = backgroundColor
                self.thumbView.snp.updateConstraints {
                    $0.left.equalToSuperview().offset(targetX)
                }
                
                self.layoutIfNeeded()
                
            }
        } else {
            self.backgroundView.backgroundColor = backgroundColor
            self.thumbView.snp.updateConstraints {
                $0.left.equalToSuperview().offset(targetX)
            }
        }
    }
}

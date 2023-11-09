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
    
    public enum SwitchStyle {
        /// 시스템 UISwitch 처럼 생긴 형태. default 값
        case iosSystem
        case andriodSystem
    }
    
    public var style: SwitchStyle = .iosSystem {
        didSet {
            self.setupViews()
        }
    }
    
    private var backgroundView = UIView()
    private var thumbView = UIView()
    public var isOn = false
    
    public convenience init(style: SwitchStyle = .iosSystem) {
        self.init(frame: .zero)
        
        self.style = style
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
        
        if self.style == .iosSystem {
            
            // 배경 뷰 설정
            self.addSubview(self.backgroundView)
            
            self.backgroundView.then {
                $0.backgroundColor = DealiColor.g30
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 15.0
            }.snp.makeConstraints {
                $0.height.equalTo(30.0)
                $0.width.equalTo(50.0)
                $0.edges.equalToSuperview()
            }
            
            // 썸 뷰(스위치의 움직이는 부분) 설정
            self.addSubview(self.thumbView)
            self.thumbView.then {
                $0.backgroundColor = DealiColor.primary04
                $0.layer.cornerRadius = 13.0
                $0.layer.masksToBounds = false
                $0.layer.shadowColor = UIColor.black.cgColor
                $0.layer.shadowOffset = CGSize(width: 0, height: 1)
                $0.layer.shadowOpacity = 0.22
                
            }.snp.makeConstraints {
                $0.width.height.equalTo(26.0)
                $0.top.bottom.left.equalToSuperview().inset(2.0)
            }
            
        } else {
            // 배경 뷰 설정
            self.addSubview(self.backgroundView)
            
            self.backgroundView.then {
                $0.backgroundColor = DealiColor.g30
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 7.0
            }.snp.makeConstraints {
                $0.left.right.centerY.equalToSuperview()
                $0.top.bottom.equalToSuperview().inset(3.0)
                $0.height.equalTo(14.0)
                $0.width.equalTo(34.0)
            }
            
            // 썸 뷰(스위치의 움직이는 부분) 설정
            self.addSubview(self.thumbView)
            self.thumbView.then {
                $0.backgroundColor = DealiColor.primary04
                $0.layer.cornerRadius = 10.0
                $0.layer.masksToBounds = false
                $0.layer.shadowColor = UIColor.black.cgColor
                $0.layer.shadowOffset = CGSize(width: 0, height: 1)
                $0.layer.shadowOpacity = 0.22
                
            }.snp.makeConstraints {
                $0.width.height.equalTo(20.0)
                $0.top.bottom.left.equalToSuperview()
            }
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
        if self.style == .iosSystem {
            
            let targetX = on ? bounds.width - thumbView.bounds.width - 2 : 2
            let backgroundColor = on ? DealiColor.primary01 : DealiColor.g30
            
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.thumbView.frame.origin.x = targetX
                    self.backgroundView.backgroundColor = backgroundColor
                }
            } else {
                self.thumbView.frame.origin.x = targetX
                self.backgroundView.backgroundColor = backgroundColor
            }
            
        } else {
            
            let targetX = on ? bounds.width - thumbView.bounds.width : 0
            let thumbViewColor = on ? DealiColor.primary01 : DealiColor.primary04
            let backgroundColor = on ? DealiColor.primary03 : DealiColor.g30
            
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.thumbView.frame.origin.x = targetX
                    self.thumbView.backgroundColor = thumbViewColor
                    self.backgroundView.backgroundColor = backgroundColor
                }
            } else {
                self.thumbView.frame.origin.x = targetX
                self.thumbView.backgroundColor = thumbViewColor
                self.backgroundView.backgroundColor = backgroundColor
                
                
            }
        }
        
    }
}

//
//  DealiSliderBar.swift
//
//
//  Created by 윤조현 on 2023/11/13.
//

import UIKit
import RxSwift
import RxRelay


public final class DealiSliderBar: UIControl {
    
    // 0과 1 사이로 두고, 선택한 min, max 비율 값을 넘긴다. 사용하는 뷰에서 값 받아서 사용한다.
    public var minValue: BehaviorRelay<CGFloat> = .init(value: 0)
    public var maxValue: BehaviorRelay<CGFloat> = .init(value: 1)
    
    private let minThumbView = UIView()
    private let maxThumbView = UIView()
    private var leftThumbOffset: CGFloat = 0.0
    private var leftThumbLastOffset: CGFloat = 0.0
    
    private var rightThumbOffset: CGFloat = 0.0
    private lazy var rightThumbLastOffset: CGFloat = self.frame.maxX

    private let barView = UIView()
    private let activeRangeBarView = UIView()
    
    // 제스처
    var minPanGesture: UIPanGestureRecognizer!
    var maxPanGesture: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(self.barView)
        self.barView.then {
            $0.backgroundColor = DealiColor.g30
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 3.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(11.0)
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
            $0.backgroundColor = DealiColor.primary04
            
            self.minPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.thumbDragged(using:)))
            self.minPanGesture.cancelsTouchesInView = false
            
            $0.addGestureRecognizer(self.minPanGesture)
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
            $0.backgroundColor = DealiColor.primary04
            self.maxPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.thumbDragged(using:)))
            self.maxPanGesture.cancelsTouchesInView = false
            
            $0.addGestureRecognizer(self.maxPanGesture)
            $0.tag = 1
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: 22.0, height: 22.0))
        }
        
        self.addSubview(self.activeRangeBarView)
        self.activeRangeBarView.then {
            $0.backgroundColor = DealiColor.primary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 3.0
        }.snp.makeConstraints {
            $0.left.equalTo(self.minThumbView)
            $0.right.equalTo(self.maxThumbView)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(6.0)
        }
        
        self.bringSubviewToFront(self.minThumbView)
        self.bringSubviewToFront(self.maxThumbView)
    }
    
    
    @objc func thumbDragged(using gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .began:
            self.didBeginDragging(view)
        case .changed:
            self.dragThumb(view, translation: translation)
        case .ended:
            self.didEndDragging(view)
        default:
            break
        }
    }
    
    private func didBeginDragging(_ thumb: UIView) {
        self.bringSubviewToFront(thumb)
        
        self.leftThumbOffset = 0.0
        self.rightThumbOffset = 0.0
    }
    
    private func dragThumb(_ thumb: UIView, translation: CGPoint) {
        if thumb.tag == 0 {
            self.dragLeftThumb(thumb, translation: translation)
        } else {
            self.dragRightThumb(thumb, translation: translation)
        }
    }
    
    private func didEndDragging(_ thumb: UIView) {
        if thumb.tag == 0 {
            self.leftThumbLastOffset = self.leftThumbOffset
        } else {
            self.rightThumbLastOffset = self.rightThumbOffset
        }
    }

    private func dragLeftThumb(_ thumb: UIView, translation: CGPoint) {
        var newOffset = (floor(translation.x + self.leftThumbLastOffset))
        
        if newOffset < 0.0 {
            newOffset = 0.0
        }
        
        let maxOffset = self.barView.frame.maxX
        if newOffset > maxOffset {
            newOffset = maxOffset
        }
        
        if self.hasThumbCollision(thumb) && translation.x > 0.0 {
            return
        }
        
        self.minThumbView.snp.updateConstraints {
            $0.left.equalToSuperview().offset(newOffset)
        }
        
        self.leftThumbOffset = newOffset
        self.minValue.accept(newOffset / maxOffset)
    }
    
    private func dragRightThumb(_ thumb: UIView, translation: CGPoint) {
        
        var newOffset = translation.x + self.rightThumbLastOffset
        
        if newOffset < 0.0 {
            newOffset = 0.0
        }
        
        let maxOffset = self.barView.frame.maxX

        if newOffset > maxOffset {
            newOffset = maxOffset
        }
        
        if self.hasThumbCollision(thumb) && translation.x < 0.0 {
            return
        }
        
        self.rightThumbOffset = newOffset - 11.0
        self.maxThumbView.snp.remakeConstraints {
            $0.left.equalToSuperview().offset(self.rightThumbOffset)
            $0.top.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 22.0, height: 22.0))
        }
        
        self.maxValue.accept(newOffset / maxOffset)
        
    }
    
    private func hasThumbCollision(_ thumb: UIView) -> Bool {
        let diff = self.maxThumbView.center.x - self.minThumbView.center.x
        
        let hasCollision = diff <= 11.0
        if hasCollision {
            if thumb.tag == 0 {
                let rightThumbOffset = self.rightThumbLastOffset
        
                self.minThumbView.snp.updateConstraints {
                    $0.left.equalToSuperview().offset(rightThumbOffset)
                }
                
                self.leftThumbOffset = rightThumbOffset
                self.leftThumbLastOffset = rightThumbOffset
                
                self.bringSubviewToFront(self.minThumbView)
                
            } else {
                let leftThumbOffset = self.leftThumbLastOffset
                
                self.maxThumbView.snp.remakeConstraints {
                    $0.left.equalToSuperview().offset(leftThumbOffset)
                    $0.top.bottom.equalToSuperview()
                    $0.size.equalTo(CGSize(width: 22.0, height: 22.0))
                }
                
                self.bringSubviewToFront(self.maxThumbView)
                
                self.rightThumbOffset = leftThumbOffset
                self.rightThumbLastOffset = leftThumbOffset
            }
        }
        
        return hasCollision
    }
}

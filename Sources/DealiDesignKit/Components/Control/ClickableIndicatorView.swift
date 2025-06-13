//
//  ClickableIndicatorView.swift
//  
//
//  Created by 박경우 on 2023/10/23.
//

import UIKit
import SnapKit

public enum DealiControl { }

final class ClickableIndicatorView: UIView {
    private let indicatorImageView = UIImageView()

    private var indicatorImage: UIImage? {
        return UIImage.dealiIcon(named: "ic_loading_filled")
    }
    
    var color: UIColor = .white {
        didSet {
            self.indicatorImageView.image = self.indicatorImage?.withTintColor(color)
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.indicatorImageView)
        self.indicatorImageView.then {
            $0.image = self.indicatorImage
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 21.0, height: 21.0))
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimating() {
        self.alpha = 1.0
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = .infinity
        self.indicatorImageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    public func stopAnimating() {
        self.alpha = 0.0
        self.indicatorImageView.layer.removeAllAnimations()
    }
    
}

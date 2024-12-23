//
//  DealiLabeledTextGroupView.swift
//
//
//  Created by Lee Chang Ho on 8/22/24.
//

import UIKit

public class DealiLabeledText {
    public static func labeledTextBullet01() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextBullet01)
    }
    
    public static func labeledTextBullet02() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextBullet02)
    }
    
    public static func labeledTextNumber01() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextNumber01)
    }
    
    public static func labeledTextNumber02() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextNumber02)
    }
    
    public static func labeledTextIcon01() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextIcon01)
    }
    
    public static func labeledTextIcon02() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextIcon02)
    }
    
    public static func labeledTextCustom01() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextCustom01)
    }
    
    public static func labeledTextCustom02() -> DealiLabeledTextGroupView {
        return DealiLabeledTextGroupView(preset: .labeledTextCustom02)
    }
}

public class DealiLabeledTextGroupView: UIView {
    
    private let preset: DealiLabeledTextPreset
    
    private let titleContainerStackView = UIStackView()
    private let titleIconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    private let labeledTextStackView = UIStackView()
    
    public var titleImageName: String? {
        didSet {
            guard let imageName = self.titleImageName else {
                self.titleIconImageView.isHidden = true
                return
            }
            
            self.titleIconImageView.isHidden = false
            self.titleIconImageView.image = UIImage.dealiIcon(named: imageName)?.withTintColor(.g100).resize(CGSize(width: 16.0, height: 16.0))
        }
    }
    
    public var title: String? {
        didSet {
            guard let title = self.title else {
                self.titleContainerStackView.isHidden = true
                return
            }
            
            self.titleContainerStackView.isHidden = false
            self.titleLabel.attributedText = NSMutableAttributedString(string: title)
                .font(.b3sb13)
                .color(UIColor.g100)
                .alignment(.left)
                .setLineHeight()
        }
    }
    
    public init(preset: DealiLabeledTextPreset) {
        self.preset = preset
        
        super.init(frame: .zero)
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.titleContainerStackView)
        self.titleContainerStackView.then {
            $0.axis = .horizontal
            $0.spacing = 8.0
            $0.alignment = .center
            $0.distribution = .fill
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.titleContainerStackView.addArrangedSubview(self.titleIconImageView)
        self.titleIconImageView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        self.titleContainerStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.labeledTextStackView)
        self.labeledTextStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(modelArray: [DealiLabeledTextModel]) {
        
        self.labeledTextStackView.subviews.forEach { $0.removeFromSuperview() }
        
        for (index, model) in modelArray.enumerated() {
            var cModel = model
            if cModel.numberString == nil {
                cModel.numberString = "\(index + 1)."
            }
            
            let itemView = DealiLabeledTextView(preset: self.preset)
            self.labeledTextStackView.addArrangedSubview(itemView)
            itemView.then {
                $0.configure(model: cModel)
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
}

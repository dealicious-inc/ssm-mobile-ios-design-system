//
//  ImageChip.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 11/5/24.
//

import UIKit

public enum ChipState {
    case normal
    case selected
    case disabled
}

public class ImageChip: UIControl {
    
    private var chipState: ChipState = .normal
    
    var config: ClickableConfig
    var color: ClickableColorConfig
    
    private let contentStackView = UIStackView()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let rightIconImageView = UIImageView()
    
    init(config: ClickableConfig,
         color: ClickableColorConfig) {
        self.config = config
        self.color = color
        
        super.init(frame: .zero)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setState(for state: ChipState) {
        self.chipState = state
    }
}

private extension ImageChip {
    func setUI() {
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        self.setCornerRadius()
        
        self.addSubview(self.contentStackView)
        self.contentStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
            $0.spacing = 4.0
            $0.isUserInteractionEnabled = false
        }
        
        self.contentStackView.addArrangedSubview(self.imageView)
        self.imageView.then {
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
    }
    
    func setCornerRadius() {
        var height = self.config.height.chip
        
        switch self.config.cornerRadius {
        case .none:
            self.layer.cornerRadius = 0.0

        case let .fixed(radius):
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
        case .capsule:
            self.layer.cornerRadius = height / 2.0
            self.clipsToBounds = true
        }
    }
}

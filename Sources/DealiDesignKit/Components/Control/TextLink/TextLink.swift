//
//  TextLink.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/6/24.
//

import UIKit

final public class TextLink: SystemButton {
    
    var contentInsets: NSDirectionalEdgeInsets = .zero {
        didSet {
            self.setButtonConfiguarion()
        }
    }
    
    private var systemConfig = TextLinkConfig(size: TextLinkSizeType.large.size, style: TextLinkStyleType.primary01.style)
    
    private let contentStackView = UIStackView()
    private let leftIconImageView = UIImageView()
    private let textLabel = UILabel()
    private let rightIconImageView = UIImageView()
    
    private func setButtonConfiguarion() {
        var configuration = Configuration.plain()
        configuration.contentInsets = self.contentInsets
        self.configuration = configuration
    }
    
    override func setUI() {
        super.setUI()
        
        self.setButtonConfiguarion()
        
    }
}

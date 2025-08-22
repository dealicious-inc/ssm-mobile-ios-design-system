//
//  DealiClickableButtonUnitView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 8/21/25.
//

import UIKit

final public class ClickableButtonComponent: ClickableButtonUnitView {
    
}

public class ClickableButtonUnitView: UIControl {

    

}

extension ClickableButtonUnitView {
    public struct ButtonPreset {
        
        public enum ButtonType {
            case large
            case semiMedium
            case medium
            case small
        }
        
        
        public var buttonType: ButtonType?
        
        public var singleImagePadding: CGFloat {
            switch self.buttonType {
            case .large:
                return 16.0
            case .medium:
                return 12.0
            case .semiMedium:
                return 12.0
            case .small:
                return 8.0
            case .none:
                return 0.0
            }
        }
    }
}

// MARK: - Font
public struct ClickableButtonUnitFont {
    var normal: UIFont
    var disabled: UIFont
}

public struct ClickableButtonUnitColorSet {
    var gradient: GradientConfigurable?
    var background: UIColor
    var text: UIColor
    var border: UIColor?
}

public struct ClickableButtonUnitColor {
    var normal: ClickableButtonUnitColorSet
    var selected: ClickableButtonUnitColorSet? // chip만 사용. button은 seleted 상태 없음.
    var disabled: ClickableButtonUnitColorSet
}

// MARK: - Padding
public struct ClickableButtonUnitPaddingSet {
    /// 이미지가 없는 경우 Padding
    var normal: CGFloat
    /// 이미지가 있는 경우 Padding
    var withImage: CGFloat
    /// 이미지와 타이틀 사이 spacing
    var internalSpacing: CGFloat
}

// MARK: - Image
public struct ClickableImage {
    /// 이미지명
    var named: String
    /// 이미지 색상 유지?
    var needOriginColor: Bool = false // true = 이미지 색상 유지 / false = 상태마다 타이틀 생상과 동일
    var uiImage: UIImage?
    public init(named name: String, needOriginColor: Bool = false) {
        self.named = name
        self.needOriginColor = needOriginColor
        self.uiImage = UIImage(named: name)
    }
    public init(dealiIconName: String, needOriginColor: Bool = false) {
        self.named = dealiIconName
        self.needOriginColor = needOriginColor
        self.uiImage = UIImage.dealiIcon(named: dealiIconName)?.resize(CGSize(width: 16.0, height: 16.0))
    }
    public init(_ image: UIImage?, needOriginColor: Bool = false) {
        self.named = ""
        self.uiImage = image
        self.needOriginColor = needOriginColor
    }
}

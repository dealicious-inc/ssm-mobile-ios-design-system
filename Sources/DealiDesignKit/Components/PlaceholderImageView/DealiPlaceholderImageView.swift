//
//  DealiPlaceholderImageView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 12/23/24.
//

import UIKit
import SnapKit

public enum DealiPlaceholderImageStyle {
    case goods
    case store
    
    var placeholderImageName: String {
        switch self {
        case .goods:
            return "ic_empty40"
        default:
            return "ic_home_filled"
        }
    }
}

public enum DealiPlaceholderBackgroundColor {
    /// 흰색 배경색에 PlaceholderImage 는 어두운색
    case light
    /// 어두운 배경색에 PlaceholderImage 는 밝은색
    case dark
    
    /// imageView 배경 컬러
    var backgroundColor: UIColor {
        switch self {
        case .dark:
            return .g20
        default:
            return .primary04
        }
    }
    
    /// placeholderImage color
    var imageColor: UIColor {
        switch self {
        case .dark:
            return .primary04
        default:
            return .g20
        }
    }
}

/*
 viewShape = .rectangle([]) : 라운드가 없는 직각사각형
 viewShape = .rectangle(.allCorners) : 모든 코너에 라운드값 적용
 viewShape = .rectangle([.topLeft, .topRight, .bottomRight, .bottomLeft]) : 선택적으로 라운드를 적용하고 싶은 코너 지정
 */
public enum DealiPlaceholderViewShape: RadiusProvider {
    /// 사각형 형태의 imageView
    case rectangle(_ corners: UIRectCorner)
    /// 동그란 형태의 imageView
    case circle
    
    var borderWidth: CGFloat {
        return 0.5
    }
    
    var borderColor: CGColor {
        return UIColor.b5.cgColor
    }
    
    func getRadius(for height: CGFloat) -> CGFloat {
        switch self {
        case .rectangle(_):
            return 6.0
        case .circle:
            return height / 2.0
            
        }
    }
}

public class DealiPlaceholderImageView: UIImageView {

    private let placeholderImageView = UIImageView()
    
    public var imageStyle: DealiPlaceholderImageStyle = .goods {
        didSet {
            self.updatePlaceholderUI()
        }
    }
    
    public var backgroundStyle: DealiPlaceholderBackgroundColor = .light {
        didSet {
            self.updateUI()
        }
    }
    
    public var viewShape: DealiPlaceholderViewShape = .rectangle(.allCorners) {
        didSet {
            self.updateUI()
        }
    }
    
    public override var image: UIImage? {
        didSet {
            self.placeholderImageView.isHidden = (self.image != nil)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.resizePlaceholderImage()
    }
    
    public init() {
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        
        self.addSubview(self.placeholderImageView)
        self.placeholderImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize.zero)
        }
        
        self.updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        self.backgroundColor = self.backgroundStyle.backgroundColor
        self.layer.borderWidth = self.viewShape.borderWidth
        self.layer.borderColor = self.viewShape.borderColor
        
        self.setRoundCorners()
        
        self.updatePlaceholderUI()
    }
    
    private func updatePlaceholderUI() {
        
        guard let placeholderImage = UIImage.dealiIcon(named: self.imageStyle.placeholderImageName)?.withTintColor(self.backgroundStyle.imageColor) else { return }
        
        self.placeholderImageView.image = placeholderImage
    }
    
    private func resizePlaceholderImage() {
        guard self.bounds.size.width > 0 && self.bounds.size.height > 0 else { return }
        
        let parentWidth = self.bounds.size.width
        var placeholderImageWidth = 0.0
        
        if self.isAspectRatioOneToOne() == true {
            /// 1:1 비율의 사이즈 일경우 empty image 사이즈 비율은 width 가 70보다 작거나 같을경우 1:2 비율, 70보다 클경우 1:2.5 비율로 정의
            if parentWidth <= 70.0 {
                placeholderImageWidth = parentWidth / 2.0
            } else {
                placeholderImageWidth = parentWidth / 2.5
            }
            
        } else {
            /// 3:4 비율 사이즈와 그 이외의 비율은 empty image 사이즈 비율은 1:4로 정의
            placeholderImageWidth = parentWidth / 4.0
        }
        
        self.setRoundCorners()
        
        self.placeholderImageView.snp.updateConstraints {
            $0.size.equalTo(CGSize(width: placeholderImageWidth, height: placeholderImageWidth))
        }
    }
    
    /// ImageView 가 1:1 비율인지 계산 함수
    private func isAspectRatioOneToOne(tolerance: CGFloat = 0.01) -> Bool {
        guard self.bounds.size.width > 0 && self.bounds.size.height > 0 else { return false }
        let aspectRatio = self.bounds.size.width / self.bounds.size.height
        if abs(aspectRatio - 1.0) < tolerance {
            return true
        } else {
            return false
        }
    }
    
    private func setRoundCorners() {
        let sublayer = self.layer.sublayers ?? [CALayer]()
        for layer in sublayer {
            if layer.name == "placeholderImagelayer" {
                layer.removeFromSuperlayer()
            }
        }
        
        let radius = self.viewShape.getRadius(for: self.bounds.size.height)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        
        switch self.viewShape {
        case .rectangle(let corners):
            maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        default:
            maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        }
        
        self.layer.mask = maskLayer
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = self.viewShape.borderColor
        borderLayer.lineWidth = self.viewShape.borderWidth
        borderLayer.frame = bounds
        borderLayer.name = "placeholderImagelayer"
        self.layer.insertSublayer(borderLayer, at: 0)
    }

}

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
    case ligth
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

public enum DealiPlaceholderViewShape {
    /// 사각형 형태의 imageView
    case rectangle
    /// 동그란 형태의 imageView
    case circle
    
    var borderWidth: CGFloat {
        return 0.5
    }
    
    var borderColor: CGColor {
        return UIColor.b5.cgColor
    }
    
    var radius: CGFloat {
        return 6.0
    }
}

public final class DealiPlaceholderImageView: UIImageView {

    private let placeholderImageView = UIImageView()
    
    public var imageStyle: DealiPlaceholderImageStyle = .goods {
        didSet {
            self.updatePlaceholderUI()
        }
    }
    
    public var backgroundStyle: DealiPlaceholderBackgroundColor = .ligth {
        didSet {
            self.updateUI()
        }
    }
    
    public var viewShape: DealiPlaceholderViewShape = .rectangle {
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
        
        if self.isAspectRatioOneToOne() == true && self.viewShape == .circle {
            self.layer.cornerRadius = self.bounds.size.height / 2.0
        } else {
            self.layer.cornerRadius = self.viewShape.radius
        }
        
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
            
            /// 1:1 비율에 사이즈일 경우에만 circle 관련 cornerRadius 값이 적용되도록 수정
            if self.viewShape == .circle {
                self.layer.cornerRadius = parentWidth / 2.0
            }
            
        } else {
            /// 3:4 비율 사이즈와 그 이외의 비율은 empty image 사이즈 비율은 1:4로 정의
            placeholderImageWidth = parentWidth / 4.0
            
            /// 1:1 비율 사이즈가 아닌경우에는 circle 타입이더라도 View가 동그랗게 적용되지 않기 때문에 기본 cornerRadius 값이 적용 되도록 수정
            self.layer.cornerRadius = self.viewShape.radius
        }
        
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

}

public extension DealiPlaceholderImageView {
    
    func addImageMarkingView(view: UIImageView, layout: (_ make: ConstraintMaker) -> Void) {
        self.addSubview(view)
        view.snp.makeConstraints {
            layout($0)
        }
    }
}

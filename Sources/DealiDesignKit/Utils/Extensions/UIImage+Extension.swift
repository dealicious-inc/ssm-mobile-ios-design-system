//
//  UIImage+Extension.swift
//
//
//  Created by 윤조현 on 2024/03/11.
//

import UIKit
import Kingfisher

public extension UIImage {
    static func dealiIcon(named: String) -> UIImage? {
        let image = UIImage(named: named, in: Bundle.module, compatibleWith: nil)
        assert(image != nil, "디자인시스템에 정의된 아이콘이 아닙니다." )
        
        return image
    }
    
    func resize(_ size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIImageView {
    @discardableResult
    func setImage(url: URL?, size: CGSize, complete: ((UIImage?) -> Void)? = nil) -> DownloadTask? {
        guard let url
        else {
            complete?(nil)
            return nil
        }
        
        var option: KingfisherOptionsInfo?
        if size.width > 0 && size.height > 0 {
            let processor = DownsamplingImageProcessor(size: size)
            option = [.processor(processor), .scaleFactor(UIScreen.main.scale), .cacheOriginalImage]
        } else {
            option = [.scaleFactor(UIScreen.main.scale), .cacheOriginalImage]
        }
        
        return self.kf.setImage(with: url,
                                options: option,
                                progressBlock: nil) { result in
            switch result {
            case .success(let value):
                complete?(value.image)
            case .failure:
                complete?(nil)
            }
        }
    }
}

//
//  UIImage+Extension.swift
//
//
//  Created by 윤조현 on 2024/03/11.
//

import UIKit

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

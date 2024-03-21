//
//  UIImage+Extension.swift
//
//
//  Created by 윤조현 on 2024/03/11.
//

import UIKit

public extension UIImage {
    static func dealiIcon(_ name: String) -> UIImage? {
        let image = UIImage(named: name, in: Bundle.module, compatibleWith: nil)
        assert(image != nil, "디자인시스템에 정의된 아이콘이 아닙니다." )
        
        return image
    }
}

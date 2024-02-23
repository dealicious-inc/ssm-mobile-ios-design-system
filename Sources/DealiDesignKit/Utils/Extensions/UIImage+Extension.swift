//
//  File.swift
//  
//
//  Created by 윤조현 on 2024/02/23.
//

import UIKit

public extension UIImage {
    static func dealiIcon(_ name: String) -> UIImage? {
        guard let image = UIImage(named: name, in: Bundle.module, compatibleWith: nil) else {
            fatalError("디자인시스템에 정의된 아이콘이 아닙니다.")
        }
        
        return image
    }
}

//
//  File.swift
//  
//
//  Created by hoji on 2023/11/21.
//

import Foundation
import UIKit

public var safeAreaBottomMargin: CGFloat {
    if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
        return window.safeAreaInsets.bottom
    }
    return 0
}

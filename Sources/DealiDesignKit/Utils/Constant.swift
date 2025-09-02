//
//  File.swift
//  
//
//  Created by hoji on 2023/11/21.
//

import Foundation
import UIKit
import SwiftUI

public var safeAreaBottomMargin: CGFloat {
    if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
        return window.safeAreaInsets.bottom
    }
    return 0
}

public var isRunningInPreview: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
public let TEXT_LINK: String = "TextLink"

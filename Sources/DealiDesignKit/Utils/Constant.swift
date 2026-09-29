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

/// view가 붙은 윈도우의 크기. 윈도우에 붙기 전이면 활성 씬의 키 윈도우, 그것도 없으면 씬 화면 크기를 쓴다.
/// iPhone Duo처럼 화면이 둘인 기기에서는 `UIScreen.main`이 앱이 실제로 떠 있는 화면과 다를 수 있어
/// 레이아웃 기준은 항상 윈도우로 잡는다.
public func dealiWindowSize(for view: UIView? = nil) -> CGSize {
    if let window = view as? UIWindow ?? view?.window {
        return window.bounds.size
    }
    let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
    guard let scene = scenes.first(where: { $0.activationState == .foregroundActive }) ?? scenes.first else {
        return UIScreen.main.bounds.size
    }
    if let window = scene.windows.first(where: { $0.isKeyWindow }) ?? scene.windows.first {
        return window.bounds.size
    }
    return scene.screen.bounds.size
}

public var isRunningInPreview: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
public let TEXT_LINK: String = "TextLink"

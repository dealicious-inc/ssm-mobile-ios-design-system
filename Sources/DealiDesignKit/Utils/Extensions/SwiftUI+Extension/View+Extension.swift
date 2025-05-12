//
//  View+Extension.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 5/12/25.
//

import SwiftUI
import UIKit

public struct HostingViewResult {
    public let view: UIView
    public let controller: UIViewController

    public func detach() {
        controller.willMove(toParent: nil)
        view.removeFromSuperview()
        controller.removeFromParent()
    }
}

public extension View {
    func toUIView(embeddedIn parent: UIViewController) -> HostingViewResult {
        let hostingController = UIHostingController(rootView: self)
        parent.addChild(hostingController)
        
        let view = hostingController.view!
        hostingController.didMove(toParent: parent)
        
        return HostingViewResult(view: view, controller: hostingController)
    }
}


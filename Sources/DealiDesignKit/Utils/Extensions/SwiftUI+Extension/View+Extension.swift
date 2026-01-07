//
//  View+Extension.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 5/12/25.
//

import SwiftUI
import UIKit

final public class AnyDetachBag {
    private var results: [Detachable] = []
    
    public func add(_ result: any Detachable) {
        self.results.append(result)
    }
    
    public init() {}
    
    deinit {
        results.forEach { $0.detach() }
    }
}

public protocol Detachable {
    func detach()
}

public struct HostingViewResult: Detachable {
    public let view: UIView
    public let controller: UIViewController

    public func detach() {
        controller.willMove(toParent: nil)
        view.removeFromSuperview()
        controller.removeFromParent()
    }
}

public extension HostingViewResult {
    func detached(by detatchBag: AnyDetachBag) -> Self {
        detatchBag.add(self)
        return self
    }
}

public extension View {
    
    ///SwiftUI View를 UIKit View로 변환합니다.
    func UIKit() -> UIView {
        let view: UIView = UIHostingController(rootView: self).view
        view.backgroundColor = .clear
        return view
    }
    
    func toUIView(embeddedIn parent: UIViewController) -> HostingViewResult {
        let hostingController = UIHostingController(rootView: self)
        parent.addChild(hostingController)
        
        let view = hostingController.view!
        hostingController.didMove(toParent: parent)
        
        return HostingViewResult(view: view, controller: hostingController)
    }
    
    func font(_ font: UIFont) -> some View {
        
        let lineHeight = font.dealiLineHeight
        let offset = ((lineHeight - font.lineHeight) / 2.0)
        
        return self
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
//            .background(Color.clear)
            .padding(.vertical, offset)
//            .background(Color(uiColor: .red))
    }
    
    func handleOpenURL(_ handler: @escaping (URL) -> Void) -> some View {
        self.environment(\.openURL, OpenURLAction { url in
            handler(url)
            return .handled
        })
    }
}

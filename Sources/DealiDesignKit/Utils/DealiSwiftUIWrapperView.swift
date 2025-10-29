import UIKit
import SwiftUI

/**
 설명: SwiftUI 뷰를 UIKit에서 사용하기 위한 UIView 래퍼.
    포커스, 키보드 등 SwiftUI 기능이 올바르게 동작하도록 UIHostingController를 관리하기 위함
 */
public final class DealiSwiftUIWrapperView<Content: View>: UIView {

    private var hostingController: UIHostingController<Content>?
    public private(set) var rootView: Content

    public init(rootView: Content) {
        self.rootView = rootView
        super.init(frame: .zero)
    }
    
    public func update(rootView: Content) {
        self.rootView = rootView
        self.hostingController?.rootView = rootView
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()

        if self.window != nil, self.hostingController == nil {
            self.setHostingController()
        } else if self.window == nil, self.hostingController != nil {
            self.removeHostingController()
        }
    }

    private func setHostingController() {
        guard let parentViewController = findViewController() else {
            return
        }

        let hc = UIHostingController(rootView: rootView)
        hc.view.backgroundColor = .clear
        
        parentViewController.addChild(hc)
        self.addSubview(hc.view)

        hc.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        hc.didMove(toParent: parentViewController)
        self.hostingController = hc
    }

    private func removeHostingController() {
        guard let hostingController = hostingController else { return }
        hostingController.willMove(toParent: nil)
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
        self.hostingController = nil
    }

    private func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
}

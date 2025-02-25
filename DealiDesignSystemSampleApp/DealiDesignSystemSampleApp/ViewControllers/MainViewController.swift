//
//  MainViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/17.
//

import UIKit
import SwiftUI
import RxSwift

import DealiDesignKit

final class MainViewController: UIViewController {
    
    private let contentStackView = UIStackView()
    private var componentButtonArray: [ClickableComponentButton] = []
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .primary04
        
        self.navigationItem.backButtonTitle = "Home"
        self.title = "iOS Design System Sample App"
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
        let uikitBaseButton = DealiControl.btnOutlineLarge03()
        contentStackView.addArrangedSubview(uikitBaseButton)
        uikitBaseButton.do {
            $0.title = "UIKit Base"
            $0.addTarget(self, action: #selector(handleUIKitBaseButtonPress), for: .touchUpInside)
        }
        
        
        let swiftUIButton = DealiControl.btnOutlineLarge03()
        contentStackView.addArrangedSubview(swiftUIButton)
        swiftUIButton.do {
            $0.title = "SwiftUI Base"
            $0.addTarget(self, action: #selector(handleSwiftUIBaseButtonPress), for: .touchUpInside)
        }
        
        let fullSwiftUIButton = DealiControl.btnFilledTonalLarge03()
        contentStackView.addArrangedSubview(fullSwiftUIButton)
        fullSwiftUIButton.do {
            $0.title = "Full SwiftUI Base"
            $0.addTarget(self, action: #selector(handleFullSwiftUIBaseButtonPress), for: .touchUpInside)
        }
    }
    
    
    @objc func handleUIKitBaseButtonPress() {
        self.pushViewController(UIKitBaseViewController())
    }
    
    @objc func handleSwiftUIBaseButtonPress() {
        self.pushViewController(SwiftUIBaseViewController())
    }
    
    @objc func handleFullSwiftUIBaseButtonPress() {
        self.pushSwiftUIView(FullSwiftUIBaseView())
        
        // 특정 View를 UIKit에 추가하는 방법
        //        let testViewController = UIViewController()
        //        testViewController.view.backgroundColor = .white
        //        let alertView = AlertView().UIKit()
        //        testViewController.view.addSubview(alertView)
        //        alertView.snp.makeConstraints {
        //            $0.center.equalToSuperview()
        //        }
        //        self.pushViewController(testViewController)
    }
}

//MARK: - UIViewController Extension
extension UIViewController {
    func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// SwiftUI View를 HostViewController로 push 합니다.
    func pushSwiftUIView<Content: View>(_ view: Content) {
        let hostingViewController = UIHostingController(rootView: view)
        hostingViewController.navigationItem.hidesBackButton = false
        
        self.navigationController?.pushViewController(hostingViewController, animated: true)
    }
    
    func present<Content: View>(_ view: Content) {
        let hostingViewController = UIHostingController(rootView: view)
        hostingViewController.navigationItem.hidesBackButton = false
        hostingViewController.modalPresentationStyle = .overFullScreen
        hostingViewController.modalTransitionStyle = .crossDissolve
        hostingViewController.view.backgroundColor = .clear
        
        self.present(hostingViewController, animated: false)
    }
    
    
}

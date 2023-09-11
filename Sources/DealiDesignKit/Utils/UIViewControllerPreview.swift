//
//  UIViewControllerPreview.swift
//  
//
//  Created by hoji on 2023/08/22.
//

import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct UIViewControllerPreview: UIViewControllerRepresentable {
        let viewController: UIViewController

                func makeUIViewController(context: Context) -> UIViewController {
                    return viewController
                }

                func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
                }
    }
    
    func showPreview() -> some View {
        UIViewControllerPreview(viewController: self)
    }
}
#endif

//
//  DLToast.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/13/25.
//

import SwiftUI

public struct DLToast {
    public static func show(message: String, embeddedIn parentView: UIView, duration: TimeInterval = 3.0) {
        let toast = DLToastView(message: message)
        let toastView = UIHostingController(rootView: toast)
        
        parentView.addSubview(toastView.view)
        
        toastView.view.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(parentView.safeAreaLayoutGuide).inset(16.0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            toastView.view.removeFromSuperview()
        }
    }
}

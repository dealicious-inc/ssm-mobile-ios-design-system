//
//  UIViewPreview.swift
//  
//
//  Created by JohyeonYoon on 2023/06/22.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

/**
 설명:  UIView 를 SwiftUI 프리뷰로 볼 수 있게 해주는 Struct
 */
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif


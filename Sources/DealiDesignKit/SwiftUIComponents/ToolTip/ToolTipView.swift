//
//  ToolTipView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 3/27/25.
//

import SwiftUI

struct ToolTipView: View {
    /// For UIKit Base
    @Environment(\.dismiss) private var dismiss
    /// For Full SwiftUI Base
    @Binding var isPresented: Bool
    
    @State private var opacity = 0.0
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    var body: some View {
        Text("Hello")
            .font(Font(UIFont.b3sb13))
            .foregroundColor(.white)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 6.0)
                    .fill(Color(UIColor.secondary01))
            )
    }
    
    public init(isPresented: Binding<Bool> = .constant(true)) {
        self._isPresented = isPresented
    }
}

#Preview {
    ToolTipView()
}

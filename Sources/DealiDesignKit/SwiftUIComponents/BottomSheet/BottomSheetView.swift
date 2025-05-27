//
//  BottomSheetView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/27/25.
//

import SwiftUI

public struct BottomSheetView: View {
    @State private var isShowing: Bool = true
    
    public init(isShowing: Bool = true) {
        self.isShowing = isShowing
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Color(.b50)
                .onTapGesture {
                    withAnimation {
                        self.isShowing = false
                    }
                }
            
            if self.isShowing {
                VStack {
                    ForEach(0..<10) { _ in Text("test") }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(TopCornerRoundedShape())
                .transition(.move(edge: .bottom))
            }
            
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Text("바텀시트 여닫기")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(20)
                    .background(Color(.brown))
            }

        }
        .ignoresSafeArea(.all)
    }
}

struct TopCornerRoundedShape: Shape {
    var radius: CGFloat = 20

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    BottomSheetView()
}

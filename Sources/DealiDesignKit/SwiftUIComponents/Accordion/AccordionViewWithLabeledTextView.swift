//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/25/25.
//

import SwiftUI

struct AccordionViewWithLabeledTextView: View {
    
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var title: String?
        @Published var backgroundColor: UIColor = .g10
        @Published var contentViews: [AnyView]?
        @Published var contentTopPadding: CGFloat = 16.0
        @Published var contentItemSpacing: CGFloat = 0.0
        @Published var shouldExposeContent: Bool = false
    }
    
    var body: some View {
        AccordionView()
            .title(viewModel.title)
            .backgroundColor(viewModel.backgroundColor)
            .contentTopPadding(viewModel.contentTopPadding)
            .contentItemSpacing(viewModel.contentItemSpacing)
            
    }
    
    public func title(_ title: String?) -> Self {
        viewModel.title = title
        return self
    }
    
    public func backgroundColor(_ color: UIColor) -> Self {
        viewModel.backgroundColor = color
        return self
    }
    /// title Button 와 content 간의 간격 수치 설정
    public func contentTopPadding(_ padding: CGFloat) -> Self {
        viewModel.contentTopPadding = padding
        return self
    }
    /// content 간의 spacing 수치 설정
    public func contentItemSpacing(_ spacing: CGFloat) -> Self {
        viewModel.contentItemSpacing = spacing
        return self
    }
    
    /// View 표시시 처음에 오픈된 상태로 보여줄때 호출
    public func isInitiallyOpen() -> Self {
        viewModel.shouldExposeContent = true
        return self
    }
}

#Preview {
    AccordionViewWithLabeledTextView()
}

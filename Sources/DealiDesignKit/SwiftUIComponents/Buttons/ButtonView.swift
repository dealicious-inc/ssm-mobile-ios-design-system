//
//  ButtonView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/18/25.
//

import SwiftUI

public struct ButtonView: View {
    
    @ObservedObject
    private var viewModel: ViewModel = ViewModel()
    
    final class ViewModel: ObservableObject {
        @Published var title: String?
        @Published var backgroundColor: Color?
        @Published var foregroundColor: Color?
        @Published var font: Font?
        @Published var height: CGFloat?
        
        var config: ClickableConfig = ButtonFilledConfig.large
        var color: ClickableColorConfig = ButtonFilledColor.primary01
        
        var action: () -> Void = {}
    }
    
    public var body: some View {
        Button(viewModel.title ?? "") {
            viewModel.action()
        }
        .frame(height: viewModel.height)
        .frame(maxWidth: .infinity)
        .font(viewModel.font)
        .background(viewModel.backgroundColor)
        .foregroundColor(viewModel.foregroundColor)
        
        .cornerRadius(6.0)
    }
    
    public init() {}
}

// MARK: - Set ViewModel
public extension ButtonView {
    func addTitle(_ title: String) -> Self {
        viewModel.title = title
        return self
    }
    
    func addAction(_ action: @escaping () -> Void) -> Self {
        viewModel.action = action
        return self
    }
    
    private func setConfigStyle() {
        viewModel.backgroundColor = Color(viewModel.color.attribute.normal.background)
        viewModel.foregroundColor = Color(viewModel.color.attribute.normal.text)
        viewModel.font = Font(viewModel.config.font.normal)
        viewModel.height = viewModel.config.height.button
    }
    
    // MARK: - Large
    // Filled
    func btnFilledLarge01() -> Self {
        viewModel.config = ButtonFilledConfig.large
        viewModel.color  = ButtonFilledColor.primary01
        
        setConfigStyle()
        
        return self
    }
    
    // MARK: - Medium
    // Filled
    func btnFilledMedium01() -> Self {
        viewModel.config = ButtonFilledConfig.medium
        viewModel.color  = ButtonFilledColor.primary01
        
        setConfigStyle()
        
        return self
    }
    
    //Outline
    func btnOutlineMedium01() -> Self {
        viewModel.config = ButtonOutlineConfig.medium
        viewModel.color  = ButtonOutlineColor.primary01
        
        setConfigStyle()
        
        return self
    }
}

// MARK: - Preview
#Preview {
    ButtonView()
}


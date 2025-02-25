//
//  ButtonView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/18/25.
//

import SwiftUI

public struct ButtonView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    // indicator animation state
    @State private var isRotating = false
    
    final class ViewModel: ObservableObject {
        var action: () -> Void = {}
        var config: ClickableConfig = ButtonFilledConfig.large
        var color: ClickableColorConfig = ButtonFilledColor.primary01
        
        var font: Font?
        var height: CGFloat = 0.0
        var leftPaddingSet: ClickablePaddingSet?
        var rightPaddingSet: ClickablePaddingSet?
        var cornerRadius: CGFloat = 0.0
        
        @Published var title: String?
        @Published var titleAlignment: TextAlignment = .leading
        @Published var isEnabled: Bool = true
        @Published var isLoading: Bool = false
        @Published var leftImage: UIImage?
        @Published var rightImage: UIImage?
        
        @Published var backgroundColor: Color?
        @Published var gradientBackground: GradientBackground?
        @Published var foregroundColor: Color?
        @Published var borderColor: Color = .clear
    }
    
    public var body: some View {
        ZStack {
            buttonContainerView
                .frame(height: viewModel.config.height.button)
            
            if viewModel.isLoading {
                IndicatorImageView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                EmptyView()
            }
        }
    }
    
    public init(action: @escaping () -> Void = {}) {
        self.viewModel = ViewModel()
        self.viewModel.action = action
    }
    
    @ViewBuilder
    private var buttonContainerView: some View {
        Button(action: viewModel.action) {
            EmptyView()
        }
        .background(
            Group {
                if let gradientBackground = viewModel.gradientBackground {
                    LinearGradient(
                        gradient: Gradient(colors: gradientBackground.colors),
                        startPoint: gradientBackground.startPoint,
                        endPoint: gradientBackground.endPoint
                    )
                } else {
                    viewModel.backgroundColor
                }
            })
        .cornerRadius(viewModel.cornerRadius)
        .disabled(!viewModel.isEnabled)
        .overlay(
            RoundedRectangle(cornerRadius: 6.0)
                .stroke(viewModel.borderColor)
        )
        .buttonStyle(ButtonViewStyle(viewModel: viewModel))
    }
    
    @ViewBuilder
    private var IndicatorImageView: some View {
        Image(uiImage: UIImage(named: "loading")!)
            .rotationEffect(.degrees(isRotating ? 360.0 : 0.0))
            .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: isRotating)
            .opacity(viewModel.isLoading ? 1.0 : 0.0)
            .onAppear {
                isRotating = true
            }
            .onDisappear {
                isRotating = false
            }
    }
}

// MARK: - Set Button StyleConfig
public extension ButtonView {
    private func setConfigStyle(config: ClickableConfig, color: ClickableColorConfig) {
        viewModel.config = config
        viewModel.color  = color
        
        viewModel.font = Font(config.font.normal)
        viewModel.height = config.height.button
        
        switch config.cornerRadius {
        case .fixed(let radius):
            viewModel.cornerRadius = radius
        case .capsule:
            viewModel.cornerRadius = viewModel.height / 2.0
        default:
            break
        }
        
        let padding = viewModel.config.padding.value(with: config.height, style: .button)
        viewModel.leftPaddingSet = padding.left
        viewModel.rightPaddingSet = padding.right
        self.setConfigStyle(isEnabled: true)
    }
    
    private func setConfigStyle(isEnabled: Bool = true) {
        let attribute = viewModel.color.attribute
        if isEnabled {
            if let gradient = attribute.normal.gradient {
                viewModel.gradientBackground = GradientBackground(colors: gradient.colors.map { Color($0) },
                                                                  startPoint: UnitPoint(x: gradient.startPoint.x, y: gradient.startPoint.y),
                                                                  endPoint: UnitPoint(x: gradient.endPoint.x, y: gradient.endPoint.y))
            } else {
                viewModel.backgroundColor = Color(attribute.normal.background)
            }
            viewModel.foregroundColor = viewModel.isLoading ? .clear : Color(attribute.normal.text)
            viewModel.borderColor = Color(attribute.normal.border ?? .clear)
        } else {
            viewModel.backgroundColor = Color(attribute.disabled.background)
            viewModel.foregroundColor = viewModel.isLoading ? .clear : Color(attribute.disabled.text)
            viewModel.borderColor = Color(attribute.disabled.border ?? .clear)
        }
    }
}

// MARK: - HighlightButtonStyle
struct ButtonViewStyle: ButtonStyle {
    @ObservedObject var viewModel: ButtonView.ViewModel
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if !viewModel.isLoading {
                if configuration.isPressed && viewModel.isEnabled {
                    rippleView
                }
            }
            
            HStack(spacing: 4.0) {
                if let leftImage = viewModel.leftImage, !viewModel.isLoading {
                    Image(uiImage: leftImage)
                } else {
                    EmptyView()
                }
                
                Text(viewModel.title ?? "")
                    .multilineTextAlignment(viewModel.titleAlignment)
                    .font(viewModel.font)
                    .foregroundColor(viewModel.isLoading ? .clear : viewModel.foregroundColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if let rightImage = viewModel.rightImage, !viewModel.isLoading {
                    Image(uiImage: rightImage)
                } else {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, viewModel.leftPaddingSet?.normal)
            .padding(.trailing, viewModel.rightPaddingSet?.normal)
        }
        .frame(height: viewModel.config.height.button)
        .contentShape(Rectangle()) // 클릭영역을 버튼 전체로 세팅
    }
    
    @ViewBuilder
    private var rippleView: some View {
        RoundedRectangle(cornerRadius: 6.0)
            .fill(Color(.b2))
            .allowsHitTesting(false)
    }
}


// MARK: - Set ViewModel
public extension ButtonView {
    @discardableResult
    func setTitle(_ title: String) -> Self {
        viewModel.title = title
        return self
    }
    
    @discardableResult
    func setTitleAlignment(_ alignment: TextAlignment) -> Self {
        viewModel.titleAlignment = alignment
        return self
    }
    
    @discardableResult
    func addAction(_ action: @escaping () -> Void) -> Self {
        viewModel.action = action
        return self
    }
    
    @discardableResult
    func setEnabled(_ isEnabled: Bool) -> Self {
        viewModel.isEnabled = isEnabled
        setConfigStyle(isEnabled: isEnabled)
        return self
    }
    
    @discardableResult
    func setLoading(_ isLoading: Bool) -> Self {
        viewModel.isLoading = isLoading
        return self
    }
    
    @discardableResult
    func toggleLoading() -> Self {
        viewModel.isLoading.toggle()
        return self
    }
    
    @discardableResult
    func setLeftImage(_ image: UIImage?) -> Self {
        viewModel.leftImage = image
        return self
    }
    
    @discardableResult
    func setRightImage(_ image: UIImage?) -> Self {
        viewModel.rightImage = image
        return self
    }
}

// MARK: - GradientBackground
struct GradientBackground {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
}

// MARK: - Preview
#Preview {
    ButtonView()
}

// MARK: - Style
public extension ButtonView {
    // MARK: Large
    // MARK: Filled
    func btnFilledLarge01() -> Self {
        setConfigStyle(config: ButtonFilledConfig.large, color: ButtonFilledColor.primary01)
        return self
    }
    
    func btnFilledLarge02() -> Self {
        setConfigStyle(config: ButtonFilledConfig.large, color: ButtonFilledColor.primaryGradient)
        return self
    }
    
    func btnFilledLarge03() -> Self {
        setConfigStyle(config: ButtonFilledConfig.large, color: ButtonFilledColor.primary02)
        return self
    }
    
    func btnFilledLarge04() -> Self {
        setConfigStyle(config: ButtonFilledConfig.large, color: ButtonFilledColor.mbs01)
        return self
    }
    
    func btnFilledLarge05() -> Self {
        setConfigStyle(config: ButtonFilledConfig.large, color: ButtonFilledColor.mbsGradient)
        return self
    }
    
    func btnFilledLarge06() -> Self {
        setConfigStyle(config: ButtonFilledConfig.large, color: ButtonFilledColor.primary05)
        return self
    }
    
    // MARK: FilledRound
    func btnFilledRoundLarge01() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.large, color: ButtonFilledRoundColor.primary01)
        return self
    }
    
    func btnFilledRoundLarge02() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.large, color: ButtonFilledRoundColor.gradient)
        return self
    }
    
    func btnFilledRoundLarge03() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.large, color: ButtonFilledRoundColor.primary02)
        return self
    }
    
    // MARK: FilledTonal
    func btnFilledTonalLarge01() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.large, color: ButtonFilledTonalColor.primary01)
        return self
    }
    
    func btnFilledTonalLarge02() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.large, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalLarge03() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.large, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalLarge04() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.large, color: ButtonFilledTonalColor.secondary02)
        return self
    }
    
    func btnFilledTonalLarge05() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.large, color: ButtonFilledTonalColor.secondary03)
        return self
    }
    
    func btnFilledTonalLarge06() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.large, color: ButtonFilledTonalColor.secondary04)
        return self
    }
    
    // MARK: Outline
    func btnOutlineLarge01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineColor.primary01)
        return self
    }
    
    func btnOutlineLarge02() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineColor.primary02)
        return self
    }
    
    func btnOutlineLarge03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineColor.secondary01)
        return self
    }
    
    func btnOutlineLarge04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineColor.secondary02)
        return self
    }
    
    func btnOutlineLarge05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineColor.secondary03)
        return self
    }
    
    func btnOutlineLarge06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineColor.secondary04)
        return self
    }
    
    // MARK: Outline Bg
    func btnOutlineBgLarge01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineBgColor.primary01)
        return self
    }
    
    func btnOutlineBgLarge03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineBgColor.secondary01)
        return self
    }
    
    func btnOutlineBgLarge04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineBgColor.secondary02)
        return self
    }
    
    func btnOutlineBgLarge05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineBgColor.secondary03)
        return self
    }
    
    func btnOutlineBgLarge06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.large, color: ButtonOutlineBgColor.secondary04)
        return self
    }
    
    // MARK: Text
    func btnTextLarge01() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.primary01)
        return self
    }
    
    func btnTextLarge02() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.primary02)
        return self
    }
    
    func btnTextLarge03() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.secondary01)
        return self
    }
    
    func btnTextLarge04() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.secondary02)
        return self
    }
    
    func btnTextLarge05() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.secondary03)
        return self
    }
    
    func btnTextLarge06() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.secondary04)
        return self
    }
    
    func btnTextLarge07() -> Self {
        setConfigStyle(config: ButtonTextConfig.large, color: ButtonTextColor.secondary05)
        return self
    }
    
    // MARK: - Medium
    // MARK: Filled
    func btnFilledMedium01() -> Self {
        setConfigStyle(config: ButtonFilledConfig.medium, color: ButtonFilledColor.primary01)
        return self
    }
    
    func btnFilledMedium02() -> Self {
        setConfigStyle(config: ButtonFilledConfig.medium, color: ButtonFilledColor.primaryGradient)
        return self
    }
    
    func btnFilledMedium03() -> Self {
        setConfigStyle(config: ButtonFilledConfig.medium, color: ButtonFilledColor.primary02)
        return self
    }
    
    func btnFilledMedium04() -> Self {
        setConfigStyle(config: ButtonFilledConfig.medium, color: ButtonFilledColor.mbs01)
        return self
    }
    
    func btnFilledMedium05() -> Self {
        setConfigStyle(config: ButtonFilledConfig.medium, color: ButtonFilledColor.mbsGradient)
        return self
    }
    
    func btnFilledMedium06() -> Self {
        setConfigStyle(config: ButtonFilledConfig.medium, color: ButtonFilledColor.primary05)
        return self
    }
    
    // MARK: FilledRound
    func btnFilledRoundMedium01() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.medium, color: ButtonFilledRoundColor.primary01)
        return self
    }
    
    func btnFilledRoundMedium02() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.medium, color: ButtonFilledRoundColor.gradient)
        return self
    }
    
    func btnFilledRoundMedium03() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.medium, color: ButtonFilledRoundColor.primary02)
        return self
    }
    
    // MARK: FilledTonal
    func btnFilledTonalMedium01() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.medium, color: ButtonFilledTonalColor.primary01)
        return self
    }
    
    func btnFilledTonalMedium02() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.medium, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalMedium03() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.medium, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalMedium04() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.medium, color: ButtonFilledTonalColor.secondary02)
        return self
    }
    
    func btnFilledTonalMedium05() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.medium, color: ButtonFilledTonalColor.secondary03)
        return self
    }
    
    func btnFilledTonalMedium06() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.medium, color: ButtonFilledTonalColor.secondary04)
        return self
    }
    
    // MARK: Outline
    func btnOutlineMedium01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineColor.primary01)
        return self
    }
    
    func btnOutlineMedium02() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineColor.primary02)
        return self
    }
    
    func btnOutlineMedium03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineColor.secondary01)
        return self
    }
    
    func btnOutlineMedium04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineColor.secondary02)
        return self
    }
    
    func btnOutlineMedium05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineColor.secondary03)
        return self
    }
    
    func btnOutlineMedium06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineColor.secondary04)
        return self
    }
    
    // MARK: Outline Bg
    func btnOutlineBgMedium01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineBgColor.primary01)
        return self
    }
    
    func btnOutlineBgMedium03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineBgColor.secondary01)
        return self
    }
    
    func btnOutlineBgMedium04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineBgColor.secondary02)
        return self
    }
    
    func btnOutlineBgMedium05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineBgColor.secondary03)
        return self
    }
    
    func btnOutlineBgMedium06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.medium, color: ButtonOutlineBgColor.secondary04)
        return self
    }
    
    // MARK: Text
    func btnTextMedium01() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.primary01)
        return self
    }
    
    func btnTextMedium02() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.primary02)
        return self
    }
    
    func btnTextMedium03() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.secondary01)
        return self
    }
    
    func btnTextMedium04() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.secondary02)
        return self
    }
    
    func btnTextMedium05() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.secondary03)
        return self
    }
    
    func btnTextMedium06() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.secondary04)
        return self
    }
    
    func btnTextMedium07() -> Self {
        setConfigStyle(config: ButtonTextConfig.medium, color: ButtonTextColor.secondary05)
        return self
    }
    
    // MARK: - Semi Medium
    // MARK: Filled
    func btnFilledSemiMedium01() -> Self {
        setConfigStyle(config: ButtonFilledConfig.semiMedium, color: ButtonFilledColor.primary01)
        return self
    }
    
    func btnFilledSemiMedium02() -> Self {
        setConfigStyle(config: ButtonFilledConfig.semiMedium, color: ButtonFilledColor.primaryGradient)
        return self
    }
    
    func btnFilledSemiMedium03() -> Self {
        setConfigStyle(config: ButtonFilledConfig.semiMedium, color: ButtonFilledColor.primary02)
        return self
    }
    
    func btnFilledSemiMedium04() -> Self {
        setConfigStyle(config: ButtonFilledConfig.semiMedium, color: ButtonFilledColor.mbs01)
        return self
    }
    
    func btnFilledSemiMedium05() -> Self {
        setConfigStyle(config: ButtonFilledConfig.semiMedium, color: ButtonFilledColor.mbsGradient)
        return self
    }
    
    func btnFilledSemiMedium06() -> Self {
        setConfigStyle(config: ButtonFilledConfig.semiMedium, color: ButtonFilledColor.primary05)
        return self
    }
    
    // MARK: FilledRound
    func btnFilledRoundSemiMedium01() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.semiMedium, color: ButtonFilledRoundColor.primary01)
        return self
    }
    
    func btnFilledRoundSemiMedium02() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.semiMedium, color: ButtonFilledRoundColor.gradient)
        return self
    }
    
    func btnFilledRoundSemiMedium03() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.semiMedium, color: ButtonFilledRoundColor.primary02)
        return self
    }
    
    // MARK: FilledTonal
    func btnFilledTonalSemiMedium01() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.semiMedium, color: ButtonFilledTonalColor.primary01)
        return self
    }
    
    func btnFilledTonalSemiMedium02() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.semiMedium, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalSemiMedium03() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.semiMedium, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalSemiMedium04() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.semiMedium, color: ButtonFilledTonalColor.secondary02)
        return self
    }
    
    func btnFilledTonalSemiMedium05() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.semiMedium, color: ButtonFilledTonalColor.secondary03)
        return self
    }
    
    func btnFilledTonalSemiMedium06() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.semiMedium, color: ButtonFilledTonalColor.secondary04)
        return self
    }
    
    //MARK: Outline
    func btnOutlineSemiMedium01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineColor.primary01)
        return self
    }
    
    func btnOutlineSemiMedium02() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineColor.primary02)
        return self
    }
    
    func btnOutlineSemiMedium03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineColor.secondary01)
        return self
    }
    
    func btnOutlineSemiMedium04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineColor.secondary02)
        return self
    }
    
    func btnOutlineSemiMedium05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineColor.secondary03)
        return self
    }
    
    func btnOutlineSemiMedium06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineColor.secondary04)
        return self
    }
    
    // MARK: Outline Bg
    func btnOutlineBgSemiMedium01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineBgColor.primary01)
        return self
    }
    
    func btnOutlineBgSemiMedium03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineBgColor.secondary01)
        return self
    }
    
    func btnOutlineBgSemiMedium04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineBgColor.secondary02)
        return self
    }
    
    func btnOutlineBgSemiMedium05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineBgColor.secondary03)
        return self
    }
    
    func btnOutlineBgSemiMedium06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.semiMedium, color: ButtonOutlineBgColor.secondary04)
        return self
    }
    
    // MARK: Text
    func btnTextSemiMedium01() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.primary01)
        return self
    }
    
    func btnTextSemiMedium02() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.primary02)
        return self
    }
    
    func btnTextSemiMedium03() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.secondary01)
        return self
    }
    
    func btnTextSemiMedium04() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.secondary02)
        return self
    }
    
    func btnTextSemiMedium05() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.secondary03)
        return self
    }
    
    func btnTextSemiMedium06() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.secondary04)
        return self
    }
    
    func btnTextSemiMedium07() -> Self {
        setConfigStyle(config: ButtonTextConfig.semiMedium, color: ButtonTextColor.secondary05)
        return self
    }
    
    // MARK: - Small
    // MARK: Filled
    func btnFilledSmall01() -> Self {
        setConfigStyle(config: ButtonFilledConfig.small, color: ButtonFilledColor.primary01)
        return self
    }
    
    func btnFilledSmall02() -> Self {
        setConfigStyle(config: ButtonFilledConfig.small, color: ButtonFilledColor.primaryGradient)
        return self
    }
    
    func btnFilledSmall03() -> Self {
        setConfigStyle(config: ButtonFilledConfig.small, color: ButtonFilledColor.primary02)
        return self
    }
    
    func btnFilledSmall04() -> Self {
        setConfigStyle(config: ButtonFilledConfig.small, color: ButtonFilledColor.mbs01)
        return self
    }
    
    func btnFilledSmall05() -> Self {
        setConfigStyle(config: ButtonFilledConfig.small, color: ButtonFilledColor.mbsGradient)
        return self
    }
    
    func btnFilledSmall06() -> Self {
        setConfigStyle(config: ButtonFilledConfig.small, color: ButtonFilledColor.primary05)
        return self
    }
    
    // MARK: FilledRound
    func btnFilledRoundSmall01() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.small, color: ButtonFilledRoundColor.primary01)
        return self
    }
    
    func btnFilledRoundSmall02() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.small, color: ButtonFilledRoundColor.gradient)
        return self
    }
    
    func btnFilledRoundSmall03() -> Self {
        setConfigStyle(config: ButtonFilledRoundConfig.small, color: ButtonFilledRoundColor.primary02)
        return self
    }
    
    // MARK: FilledTonal
    func btnFilledTonalSmall01() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.small, color: ButtonFilledTonalColor.primary01)
        return self
    }
    
    func btnFilledTonalSmall02() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.small, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalSmall03() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.small, color: ButtonFilledTonalColor.primary02)
        return self
    }
    
    func btnFilledTonalSmall04() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.small, color: ButtonFilledTonalColor.secondary02)
        return self
    }
    
    func btnFilledTonalSmall05() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.small, color: ButtonFilledTonalColor.secondary03)
        return self
    }
    
    func btnFilledTonalSmall06() -> Self {
        setConfigStyle(config: ButtonFilledTonalConfig.small, color: ButtonFilledTonalColor.secondary04)
        return self
    }
    
    // MARK: Outline
    func btnOutlineSmall01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineColor.primary01)
        return self
    }
    
    func btnOutlineSmall02() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineColor.primary02)
        return self
    }
    
    func btnOutlineSmall03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineColor.secondary01)
        return self
    }
    
    func btnOutlineSmall04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineColor.secondary02)
        return self
    }
    
    func btnOutlineSmall05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineColor.secondary03)
        return self
    }
    
    func btnOutlineSmall06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineColor.secondary04)
        return self
    }
    
    // MARK: Outline Bg
    func btnOutlineBgSmall01() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineBgColor.primary01)
        return self
    }
    
    func btnOutlineBgSmall03() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineBgColor.secondary01)
        return self
    }
    
    func btnOutlineBgSmall04() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineBgColor.secondary02)
        return self
    }
    
    func btnOutlineBgSmall05() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineBgColor.secondary03)
        return self
    }
    
    func btnOutlineBgSmall06() -> Self {
        setConfigStyle(config: ButtonOutlineConfig.small, color: ButtonOutlineBgColor.secondary04)
        return self
    }
    
    // MARK: Text
    func btnTextSmall01() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.primary01)
        return self
    }
    
    func btnTextSmall02() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.primary02)
        return self
    }
    
    func btnTextSmall03() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.secondary01)
        return self
    }
    
    func btnTextSmall04() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.secondary02)
        return self
    }
    
    func btnTextSmall05() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.secondary03)
        return self
    }
    
    func btnTextSmall06() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.secondary04)
        return self
    }
    
    func btnTextSmall07() -> Self {
        setConfigStyle(config: ButtonTextConfig.small, color: ButtonTextColor.secondary05)
        return self
    }
}

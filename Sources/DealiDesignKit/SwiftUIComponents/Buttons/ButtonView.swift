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
        self.setColorConfigStyle(isEnabled: true)
    }
    
    private func setColorConfigStyle(isEnabled: Bool = true) {
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
    func setStyle(_ style: ButtonConfigStyle) -> Self {
        setConfigStyle(config: style.config, color: style.color)
        return self
    }
    
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
        setColorConfigStyle(isEnabled: isEnabled)
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
    
    enum ButtonConfigStyle {
        // MARK: Large
        /// Filled
        case btnFilledLarge01
        case btnFilledLarge02
        case btnFilledLarge03
        case btnFilledLarge04
        case btnFilledLarge05
        case btnFilledLarge06
        
        /// FilledRound
        case btnFilledRoundLarge01
        case btnFilledRoundLarge02
        case btnFilledRoundLarge03
        
        /// FilledTonal
        case btnFilledTonalLarge01
        case btnFilledTonalLarge02
        case btnFilledTonalLarge03
        case btnFilledTonalLarge04
        case btnFilledTonalLarge05
        case btnFilledTonalLarge06
        
        /// Outline
        case btnOutlineLarge01
        case btnOutlineLarge02
        case btnOutlineLarge03
        case btnOutlineLarge04
        case btnOutlineLarge05
        case btnOutlineLarge06
        
        /// Outline Bg
        case btnOutlineBgLarge01
        case btnOutlineBgLarge03
        case btnOutlineBgLarge04
        case btnOutlineBgLarge05
        case btnOutlineBgLarge06
        
        /// Text
        case btnTextLarge01
        case btnTextLarge02
        case btnTextLarge03
        case btnTextLarge04
        case btnTextLarge05
        case btnTextLarge06
        case btnTextLarge07
        
        // MARK: - Medium
        /// Filled
        case btnFilledMedium01
        case btnFilledMedium02
        case btnFilledMedium03
        case btnFilledMedium04
        case btnFilledMedium05
        case btnFilledMedium06
        
        /// FilledRound
        case btnFilledRoundMedium01
        case btnFilledRoundMedium02
        case btnFilledRoundMedium03
        
        /// FilledTonal
        case btnFilledTonalMedium01
        case btnFilledTonalMedium02
        case btnFilledTonalMedium03
        case btnFilledTonalMedium04
        case btnFilledTonalMedium05
        case btnFilledTonalMedium06
        
        /// Outline
        case btnOutlineMedium01
        case btnOutlineMedium02
        case btnOutlineMedium03
        case btnOutlineMedium04
        case btnOutlineMedium05
        case btnOutlineMedium06
        
        /// Outline Bg
        case btnOutlineBgMedium01
        case btnOutlineBgMedium03
        case btnOutlineBgMedium04
        case btnOutlineBgMedium05
        case btnOutlineBgMedium06
        
        /// Text
        case btnTextMedium01
        case btnTextMedium02
        case btnTextMedium03
        case btnTextMedium04
        case btnTextMedium05
        case btnTextMedium06
        case btnTextMedium07
        
        // MARK: - Semi Medium
        /// Filled
        case btnFilledSemiMedium01
        case btnFilledSemiMedium02
        case btnFilledSemiMedium03
        case btnFilledSemiMedium04
        case btnFilledSemiMedium05
        case btnFilledSemiMedium06
        
        /// FilledRound
        case btnFilledRoundSemiMedium01
        case btnFilledRoundSemiMedium02
        case btnFilledRoundSemiMedium03
        
        /// FilledTonal
        case btnFilledTonalSemiMedium01
        case btnFilledTonalSemiMedium02
        case btnFilledTonalSemiMedium03
        case btnFilledTonalSemiMedium04
        case btnFilledTonalSemiMedium05
        case btnFilledTonalSemiMedium06
        
        /// Outline
        case btnOutlineSemiMedium01
        case btnOutlineSemiMedium02
        case btnOutlineSemiMedium03
        case btnOutlineSemiMedium04
        case btnOutlineSemiMedium05
        case btnOutlineSemiMedium06
        
        /// Outline Bg
        case btnOutlineBgSemiMedium01
        case btnOutlineBgSemiMedium03
        case btnOutlineBgSemiMedium04
        case btnOutlineBgSemiMedium05
        case btnOutlineBgSemiMedium06
        
        /// Text
        case btnTextSemiMedium01
        case btnTextSemiMedium02
        case btnTextSemiMedium03
        case btnTextSemiMedium04
        case btnTextSemiMedium05
        case btnTextSemiMedium06
        case btnTextSemiMedium07
        
        // MARK: - Small
        /// Filled
        case btnFilledSmall01
        case btnFilledSmall02
        case btnFilledSmall03
        case btnFilledSmall04
        case btnFilledSmall05
        case btnFilledSmall06
        
        /// FilledRound
        case btnFilledRoundSmall01
        case btnFilledRoundSmall02
        case btnFilledRoundSmall03
        
        /// FilledTonal
        case btnFilledTonalSmall01
        case btnFilledTonalSmall02
        case btnFilledTonalSmall03
        case btnFilledTonalSmall04
        case btnFilledTonalSmall05
        case btnFilledTonalSmall06
        
        /// Outline
        case btnOutlineSmall01
        case btnOutlineSmall02
        case btnOutlineSmall03
        case btnOutlineSmall04
        case btnOutlineSmall05
        case btnOutlineSmall06
        
        /// Outline Bg
        case btnOutlineBgSmall01
        case btnOutlineBgSmall03
        case btnOutlineBgSmall04
        case btnOutlineBgSmall05
        case btnOutlineBgSmall06
        
        /// Text
        case btnTextSmall01
        case btnTextSmall02
        case btnTextSmall03
        case btnTextSmall04
        case btnTextSmall05
        case btnTextSmall06
        case btnTextSmall07
        
        // MARK: - Config
        var config: ClickableConfig {
            switch self {
                // Filled
            case .btnFilledLarge01, .btnFilledLarge02, .btnFilledLarge03, .btnFilledLarge04, .btnFilledLarge05, .btnFilledLarge06:
                return ButtonFilledConfig.large
            case .btnFilledMedium01, .btnFilledMedium02, .btnFilledMedium03, .btnFilledMedium04, .btnFilledMedium05, .btnFilledMedium06:
                return ButtonFilledConfig.medium
            case .btnFilledSemiMedium01, .btnFilledSemiMedium02, .btnFilledSemiMedium03, .btnFilledSemiMedium04, .btnFilledSemiMedium05, .btnFilledSemiMedium06:
                return ButtonFilledConfig.semiMedium
            case .btnFilledSmall01, .btnFilledSmall02, .btnFilledSmall03, .btnFilledSmall04, .btnFilledSmall05, .btnFilledSmall06:
                return ButtonFilledConfig.small
                
                // ✅ FilledRound
            case .btnFilledRoundLarge01, .btnFilledRoundLarge02, .btnFilledRoundLarge03:
                return ButtonFilledRoundConfig.large
            case .btnFilledRoundMedium01, .btnFilledRoundMedium02, .btnFilledRoundMedium03:
                return ButtonFilledRoundConfig.medium
            case .btnFilledRoundSemiMedium01, .btnFilledRoundSemiMedium02, .btnFilledRoundSemiMedium03:
                return ButtonFilledRoundConfig.semiMedium
            case .btnFilledRoundSmall01, .btnFilledRoundSmall02, .btnFilledRoundSmall03:
                return ButtonFilledRoundConfig.small
                
                // ✅ FilledTonal
            case .btnFilledTonalLarge01, .btnFilledTonalLarge02, .btnFilledTonalLarge03, .btnFilledTonalLarge04, .btnFilledTonalLarge05, .btnFilledTonalLarge06:
                return ButtonFilledTonalConfig.large
            case .btnFilledTonalMedium01, .btnFilledTonalMedium02, .btnFilledTonalMedium03, .btnFilledTonalMedium04, .btnFilledTonalMedium05, .btnFilledTonalMedium06:
                return ButtonFilledTonalConfig.medium
            case .btnFilledTonalSemiMedium01, .btnFilledTonalSemiMedium02, .btnFilledTonalSemiMedium03, .btnFilledTonalSemiMedium04, .btnFilledTonalSemiMedium05, .btnFilledTonalSemiMedium06:
                return ButtonFilledTonalConfig.semiMedium
            case .btnFilledTonalSmall01, .btnFilledTonalSmall02, .btnFilledTonalSmall03, .btnFilledTonalSmall04, .btnFilledTonalSmall05, .btnFilledTonalSmall06:
                return ButtonFilledTonalConfig.small
                
                // ✅ Outline
            case .btnOutlineLarge01, .btnOutlineLarge02, .btnOutlineLarge03, .btnOutlineLarge04, .btnOutlineLarge05, .btnOutlineLarge06:
                return ButtonOutlineConfig.large
            case .btnOutlineMedium01, .btnOutlineMedium02, .btnOutlineMedium03, .btnOutlineMedium04, .btnOutlineMedium05, .btnOutlineMedium06:
                return ButtonOutlineConfig.medium
            case .btnOutlineSemiMedium01, .btnOutlineSemiMedium02, .btnOutlineSemiMedium03, .btnOutlineSemiMedium04, .btnOutlineSemiMedium05, .btnOutlineSemiMedium06:
                return ButtonOutlineConfig.semiMedium
            case .btnOutlineSmall01, .btnOutlineSmall02, .btnOutlineSmall03, .btnOutlineSmall04, .btnOutlineSmall05, .btnOutlineSmall06:
                return ButtonOutlineConfig.small
                
                // ✅ Outline Bg
            case .btnOutlineBgLarge01, .btnOutlineBgLarge03, .btnOutlineBgLarge04, .btnOutlineBgLarge05, .btnOutlineBgLarge06:
                return ButtonOutlineConfig.large
            case .btnOutlineBgMedium01, .btnOutlineBgMedium03, .btnOutlineBgMedium04, .btnOutlineBgMedium05, .btnOutlineBgMedium06:
                return ButtonOutlineConfig.medium
            case .btnOutlineBgSemiMedium01, .btnOutlineBgSemiMedium03, .btnOutlineBgSemiMedium04, .btnOutlineBgSemiMedium05, .btnOutlineBgSemiMedium06:
                return ButtonOutlineConfig.semiMedium
            case .btnOutlineBgSmall01, .btnOutlineBgSmall03, .btnOutlineBgSmall04, .btnOutlineBgSmall05, .btnOutlineBgSmall06:
                return ButtonOutlineConfig.small
                
                // ✅ Text
            case .btnTextLarge01, .btnTextLarge02, .btnTextLarge03, .btnTextLarge04, .btnTextLarge05, .btnTextLarge06, .btnTextLarge07:
                return ButtonTextConfig.large
            case .btnTextMedium01, .btnTextMedium02, .btnTextMedium03, .btnTextMedium04, .btnTextMedium05, .btnTextMedium06, .btnTextMedium07:
                return ButtonTextConfig.medium
            case .btnTextSemiMedium01, .btnTextSemiMedium02, .btnTextSemiMedium03, .btnTextSemiMedium04, .btnTextSemiMedium05, .btnTextSemiMedium06, .btnTextSemiMedium07:
                return ButtonTextConfig.semiMedium
            case .btnTextSmall01, .btnTextSmall02, .btnTextSmall03, .btnTextSmall04, .btnTextSmall05, .btnTextSmall06, .btnTextSmall07:
                return ButtonTextConfig.small
            }
        }
        
        // MARK: - Color
        var color: ClickableColorConfig {
            switch self {
                // ✅ ButtonFilledColor
            case .btnFilledLarge01, .btnFilledMedium01, .btnFilledSemiMedium01, .btnFilledSmall01:
                return ButtonFilledColor.primary01
            case .btnFilledLarge02, .btnFilledMedium02, .btnFilledSemiMedium02, .btnFilledSmall02:
                return ButtonFilledColor.primaryGradient
            case .btnFilledLarge03, .btnFilledMedium03, .btnFilledSemiMedium03, .btnFilledSmall03:
                return ButtonFilledColor.primary02
            case .btnFilledLarge04, .btnFilledMedium04, .btnFilledSemiMedium04, .btnFilledSmall04:
                return ButtonFilledColor.mbs01
            case .btnFilledLarge05, .btnFilledMedium05, .btnFilledSemiMedium05, .btnFilledSmall05:
                return ButtonFilledColor.mbsGradient
            case .btnFilledLarge06, .btnFilledMedium06, .btnFilledSemiMedium06, .btnFilledSmall06:
                return ButtonFilledColor.primary05
                
                // ✅ ButtonFilledRoundColor
            case .btnFilledRoundLarge01, .btnFilledRoundMedium01, .btnFilledRoundSemiMedium01, .btnFilledRoundSmall01:
                return ButtonFilledRoundColor.primary01
            case .btnFilledRoundLarge02, .btnFilledRoundMedium02, .btnFilledRoundSemiMedium02, .btnFilledRoundSmall02:
                return ButtonFilledRoundColor.primary02
            case .btnFilledRoundLarge03, .btnFilledRoundMedium03, .btnFilledRoundSemiMedium03, .btnFilledRoundSmall03:
                return ButtonFilledRoundColor.primary01
                
                // ✅ ButtonFilledTonalColor
            case .btnFilledTonalLarge01, .btnFilledTonalMedium01, .btnFilledTonalSemiMedium01, .btnFilledTonalSmall01:
                return ButtonFilledTonalColor.primary01
            case .btnFilledTonalLarge02, .btnFilledTonalMedium02, .btnFilledTonalSemiMedium02, .btnFilledTonalSmall02:
                return ButtonFilledTonalColor.primary02
            case .btnFilledTonalLarge03, .btnFilledTonalMedium03, .btnFilledTonalSemiMedium03, .btnFilledTonalSmall03:
                return ButtonFilledTonalColor.primary02
            case .btnFilledTonalLarge04, .btnFilledTonalMedium04, .btnFilledTonalSemiMedium04, .btnFilledTonalSmall04:
                return ButtonFilledTonalColor.secondary02
            case .btnFilledTonalLarge05, .btnFilledTonalMedium05, .btnFilledTonalSemiMedium05, .btnFilledTonalSmall05:
                return ButtonFilledTonalColor.secondary03
            case .btnFilledTonalLarge06, .btnFilledTonalMedium06, .btnFilledTonalSemiMedium06, .btnFilledTonalSmall06:
                return ButtonFilledTonalColor.secondary04
                
                // ✅ ButtonOutlineColor
            case .btnOutlineLarge01, .btnOutlineMedium01, .btnOutlineSemiMedium01, .btnOutlineSmall01:
                return ButtonOutlineColor.primary01
            case .btnOutlineLarge02, .btnOutlineMedium02, .btnOutlineSemiMedium02, .btnOutlineSmall02:
                return ButtonOutlineColor.primary02
            case .btnOutlineLarge03, .btnOutlineMedium03, .btnOutlineSemiMedium03, .btnOutlineSmall03:
                return ButtonOutlineColor.secondary01
            case .btnOutlineLarge04, .btnOutlineMedium04, .btnOutlineSemiMedium04, .btnOutlineSmall04:
                return ButtonOutlineColor.secondary02
            case .btnOutlineLarge05, .btnOutlineMedium05, .btnOutlineSemiMedium05, .btnOutlineSmall05:
                return ButtonOutlineColor.secondary03
            case .btnOutlineLarge06, .btnOutlineMedium06, .btnOutlineSemiMedium06, .btnOutlineSmall06:
                return ButtonOutlineColor.secondary04
                
                // ✅ ButtonOutlineBgColor
            case .btnOutlineBgLarge01, .btnOutlineBgMedium01, .btnOutlineBgSemiMedium01, .btnOutlineBgSmall01:
                return ButtonOutlineBgColor.primary01
            case .btnOutlineBgLarge03, .btnOutlineBgMedium03, .btnOutlineBgSemiMedium03, .btnOutlineBgSmall03:
                return ButtonOutlineBgColor.secondary01
            case .btnOutlineBgLarge04, .btnOutlineBgMedium04, .btnOutlineBgSemiMedium04, .btnOutlineBgSmall04:
                return ButtonOutlineBgColor.secondary02
            case .btnOutlineBgLarge05, .btnOutlineBgMedium05, .btnOutlineBgSemiMedium05, .btnOutlineBgSmall05:
                return ButtonOutlineBgColor.secondary03
            case .btnOutlineBgLarge06, .btnOutlineBgMedium06, .btnOutlineBgSemiMedium06, .btnOutlineBgSmall06:
                return ButtonOutlineBgColor.secondary04
                
                // ✅ ButtonTextColor
            case .btnTextLarge01, .btnTextMedium01, .btnTextSemiMedium01, .btnTextSmall01:
                return ButtonTextColor.primary01
            case .btnTextLarge02, .btnTextMedium02, .btnTextSemiMedium02, .btnTextSmall02:
                return ButtonTextColor.primary02
            case .btnTextLarge03, .btnTextMedium03, .btnTextSemiMedium03, .btnTextSmall03:
                return ButtonTextColor.secondary01
            case .btnTextLarge04, .btnTextMedium04, .btnTextSemiMedium04, .btnTextSmall04:
                return ButtonTextColor.secondary02
            case .btnTextLarge05, .btnTextMedium05, .btnTextSemiMedium05, .btnTextSmall05:
                return ButtonTextColor.secondary03
            case .btnTextLarge06, .btnTextMedium06, .btnTextSemiMedium06, .btnTextSmall06:
                return ButtonTextColor.secondary04
            case .btnTextLarge07, .btnTextMedium07, .btnTextSemiMedium07, .btnTextSmall07:
                return ButtonTextColor.secondary05
            }
        }
    }
}

//
//  ButtonView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/18/25.
//

import SwiftUI

//config

public final class ButtonViewModel: ObservableObject {
    @Published var type: ButtonView.ButtonConfigStyle = .btnFilledLarge01
    @Published public var title: String?
    @Published public var isEnabled: Bool = true
    @Published public var isLoading: Bool = false
    
    @Published public var leftImage: ClickableImage?
    @Published public var rightImage: ClickableImage?
    var titleAlignment: TextAlignment = .center
    
    @Published var style = ConfigStyle()
    
    public init(type: ButtonView.ButtonConfigStyle,
                title: String,
                isEnabled: Bool = true,
                isLoading: Bool = false,
                leftImage: ClickableImage? = nil,
                rightImage: ClickableImage? = nil,
                titleAlignment: TextAlignment = .center) {
        self.type = type
        self.title = title
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.titleAlignment = titleAlignment
    }
    
    internal struct ConfigStyle {
        var config: ClickableUnitButtonConfig = ButtonFilledConfig.large
        var color: ClickableUnitButtonColorConfig = ButtonFilledColor.primary01
        
        var backgroundColor: Color?
        var gradientBackground: GradientBackground?
        var foregroundColor: Color?
        var borderColor: Color = .clear
        
        var font: Font?
        var heightPadding: CGFloat = 0.0
        var widthPadding: ClickableUnitButtonWidthPadding?
        var cornerRadius: ClickableUnitButton.ButtonPreset.Corner = .normal
    }
}

public struct ButtonView: View {
    
    @ObservedObject private var viewModel: ButtonViewModel
    /// indicator animation state
    @State private var isRotating = false
    public var action: () -> Void = { }
    
    public init(
        viewModel: ButtonViewModel,
        action:  (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.action = action ?? {}
        
        self.setConfigStyle(config: viewModel.type.config, color: viewModel.type.color)
    }
    
    public init(type: ButtonConfigStyle,
             title: String,
             isEnabled: Bool = true,
             isLoading: Bool = false,
             leftImage: ClickableImage? = nil,
             rightImage: ClickableImage? = nil,
             titleAlignment: TextAlignment = .center,
             action: (() -> Void)? = nil) {
            let viewModel = ButtonViewModel(type: type,
                                            title: title,
                                            isEnabled: isEnabled,
                                            isLoading: isLoading,
                                            leftImage: leftImage,
                                            rightImage: rightImage,
                                            titleAlignment: titleAlignment)
            self.init(viewModel: viewModel, action: action)
        }
    
    public var body: some View {
        ZStack {
            buttonContainerView
            
            if viewModel.isLoading {
                IndicatorImageView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                EmptyView()
            }
        }
        .onChange(of: viewModel.isEnabled) { newValue in
            setColorConfigStyle(isEnabled: newValue)
        }
    }
    
    @ViewBuilder
    private var buttonContainerView: some View {
        Button(action: self.action) {
            EmptyView()
        }
        .background(
            GeometryReader { geo in
                Group {
                    if let gradientBackground = viewModel.style.gradientBackground {
                        LinearGradient(
                            gradient: Gradient(colors: gradientBackground.colors),
                            startPoint: gradientBackground.startPoint,
                            endPoint: gradientBackground.endPoint
                        )
                        .clipShape(RoundedRectangle(cornerRadius: self.getRadius(geo: geo)))
                    } else {
                        viewModel.style.backgroundColor
                            .clipShape(RoundedRectangle(cornerRadius: self.getRadius(geo: geo)))
                    }
                }
            }
        )
        .disabled(!viewModel.isEnabled)
        .overlay(
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: self.getRadius(geo: geo))
                    .stroke(viewModel.style.borderColor)
            }
        )
        .buttonStyle(ButtonViewStyle(viewModel: viewModel))
    }
    
    @ViewBuilder
    private var IndicatorImageView: some View {
        Image(uiImage: DealiIcon.ic_loading_filled.image)
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
    
    /// 높이에 따라 cornerRadius 계산
    private func getRadius(geo: GeometryProxy) -> CGFloat {
        switch viewModel.style.cornerRadius {
        case .normal:
            return viewModel.style.cornerRadius.radius(with: viewModel.style.config.buttonType)
        case .round:
            return geo.size.height / 2.0
        }
    }
}

// MARK: - Set Button StyleConfig
public extension ButtonView {
    private mutating func setConfigStyle(config: ClickableUnitButtonConfig, color: ClickableUnitButtonColorConfig) {
        viewModel.style.config = config
        viewModel.style.color = color
        viewModel.style.font = Font(config.font.normal)
        viewModel.style.heightPadding = config.buttonType.heightPadding
        viewModel.style.widthPadding = config.buttonPadding.widthPadding(with: config.buttonType)
        viewModel.style.cornerRadius = config.cornerRadius
        
        self.setColorConfigStyle(isEnabled: true)
    }
    
    private func setColorConfigStyle(isEnabled: Bool = true) {
        let attribute = viewModel.style.color.attribute
        if isEnabled {
            if let gradient = attribute.normal.gradient {
                viewModel.style.gradientBackground = GradientBackground(colors: gradient.colors.map { Color($0) },
                                                                  startPoint: UnitPoint(x: gradient.startPoint.x, y: gradient.startPoint.y),
                                                                  endPoint: UnitPoint(x: gradient.endPoint.x, y: gradient.endPoint.y))
            } else {
                viewModel.style.backgroundColor = Color(attribute.normal.background)
            }
            viewModel.style.foregroundColor = viewModel.isLoading ? .clear : Color(attribute.normal.text)
            viewModel.style.borderColor = Color(attribute.normal.border ?? .clear)
        } else {
            viewModel.style.backgroundColor = Color(attribute.disabled.background)
            viewModel.style.foregroundColor = viewModel.isLoading ? .clear : Color(attribute.disabled.text)
            viewModel.style.borderColor = Color(attribute.disabled.border ?? .clear)
        }
    }
    
    
}

// MARK: - HighlightButtonStyle
struct ButtonViewStyle: ButtonStyle {
    @ObservedObject var viewModel: ButtonViewModel
    
    func makeBody(configuration: Configuration) -> some View {
        let textColor = self.viewModel.isEnabled
                ? self.viewModel.style.color.attribute.normal.text
                : self.viewModel.style.color.attribute.disabled.text
        
        ZStack {
            HStack(spacing: viewModel.style.widthPadding?.internalSpacing) {
                if let leftImageSet = viewModel.leftImage, let leftImage = self.processedUIImage(imageSet: leftImageSet) {
                    if leftImageSet.needOriginColor == true {
                        Image(uiImage: leftImage).renderingMode(.original)
                    } else {
                        Image(uiImage: leftImage).renderingMode(.template).foregroundColor(Color(uiColor: textColor))
                    }
                } else {
                    EmptyView()
                }
                
                AttributedText(
                    AttributedString(viewModel.title ?? "")
                        .setFont(viewModel.style.font)
                        .setColor(viewModel.isLoading ? .clear : viewModel.style.foregroundColor),
                    alignment: viewModel.titleAlignment
                )
                .frame(maxWidth: .infinity)
                
                if let rightImageSet = viewModel.rightImage, let rightImage = self.processedUIImage(imageSet: rightImageSet) {
                    if rightImageSet.needOriginColor == true {
                        Image(uiImage: rightImage).renderingMode(.original)
                    } else {
                        Image(uiImage: rightImage).renderingMode(.template).foregroundColor(Color(uiColor: textColor))
                    }
                } else {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,
                     viewModel.leftImage != nil && !viewModel.isLoading
                     ? (viewModel.style.widthPadding?.withImage ?? 0.0)
                     : (viewModel.style.widthPadding?.normal ?? 0.0)
            )
            .padding(.trailing,
                     viewModel.rightImage != nil && !viewModel.isLoading
                     ? (viewModel.style.widthPadding?.withImage ?? 0.0)
                     : (viewModel.style.widthPadding?.normal ?? 0.0)
            )
            .padding(.vertical, viewModel.style.heightPadding)
            .background(
                Group {
                    if configuration.isPressed,
                       viewModel.isEnabled,
                       !viewModel.isLoading {
                        rippleView
                    } else {
                        Color.clear
                    }
                }
            )
        }
        .contentShape(Rectangle()) // 클릭영역을 버튼 전체로 세팅
    }
    
    @ViewBuilder
    private var rippleView: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: self.getRadius(geo: geo))
                .fill(Color(.b2))
                .allowsHitTesting(false)
        }
    }
    
    private func processedUIImage(imageSet: ClickableImage) -> UIImage? {
        guard let leftImage = imageSet.uiImage,
              self.viewModel.isLoading == false else {
            return nil
        }
        
        let targetSize = self.viewModel.style.config.buttonType.imageSize
        let resized = leftImage.resize(targetSize)
        
        return resized.withRenderingMode(.alwaysOriginal)
    }
    
    /// 높이에 따라 cornerRadius 계산
    private func getRadius(geo: GeometryProxy) -> CGFloat {
        switch viewModel.style.cornerRadius {
        case .normal:
            return viewModel.style.cornerRadius.radius(with: viewModel.style.config.buttonType)
        case .round:
            return geo.size.height / 2.0
        }
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
    ButtonView(type: .btnFilledLarge01, title: "btnFilledLarge01")
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
        case btnFilledRoundLarge04
        case btnFilledRoundLarge05
        case btnFilledRoundLarge06
        
        /// FilledTonal
        case btnFilledTonalLarge01
        case btnFilledTonalLarge02
        case btnFilledTonalLarge03
        case btnFilledTonalLarge04
        case btnFilledTonalLarge05
        case btnFilledTonalLarge06
        
        /// FilledTonalRound
        case btnFilledTonalRoundLarge01
        case btnFilledTonalRoundLarge02
        case btnFilledTonalRoundLarge03
        case btnFilledTonalRoundLarge04
        case btnFilledTonalRoundLarge05
        case btnFilledTonalRoundLarge06
        
        /// Outline
        case btnOutlineLarge01
        case btnOutlineLarge02
        case btnOutlineLarge03
        case btnOutlineLarge04
        case btnOutlineLarge05
        case btnOutlineLarge06
        
        /// OutlineRound
        case btnOutlineRoundLarge01
        case btnOutlineRoundLarge02
        case btnOutlineRoundLarge03
        case btnOutlineRoundLarge04
        case btnOutlineRoundLarge05
        case btnOutlineRoundLarge06
        
        /// Outline Bg
        case btnOutlineBgLarge01
        case btnOutlineBgLarge03
        case btnOutlineBgLarge04
        case btnOutlineBgLarge05
        case btnOutlineBgLarge06
        
        /// Outline Bg Round
        case btnOutlineBgRoundLarge01
        case btnOutlineBgRoundLarge03
        case btnOutlineBgRoundLarge04
        case btnOutlineBgRoundLarge05
        case btnOutlineBgRoundLarge06
        
        /// Text
        case btnTextLarge01
        case btnTextLarge02
        case btnTextLarge03
        case btnTextLarge04
        case btnTextLarge05
        case btnTextLarge06
        case btnTextLarge07
        
        /// TextRound
        case btnTextRoundLarge01
        case btnTextRoundLarge02
        case btnTextRoundLarge03
        case btnTextRoundLarge04
        case btnTextRoundLarge05
        case btnTextRoundLarge06
        case btnTextRoundLarge07
        
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
        case btnFilledRoundMedium04
        case btnFilledRoundMedium05
        case btnFilledRoundMedium06
        
        /// FilledTonal
        case btnFilledTonalMedium01
        case btnFilledTonalMedium02
        case btnFilledTonalMedium03
        case btnFilledTonalMedium04
        case btnFilledTonalMedium05
        case btnFilledTonalMedium06
        
        /// FilledTonalRound
        case btnFilledTonalRoundMedium01
        case btnFilledTonalRoundMedium02
        case btnFilledTonalRoundMedium03
        case btnFilledTonalRoundMedium04
        case btnFilledTonalRoundMedium05
        case btnFilledTonalRoundMedium06
        
        /// Outline
        case btnOutlineMedium01
        case btnOutlineMedium02
        case btnOutlineMedium03
        case btnOutlineMedium04
        case btnOutlineMedium05
        case btnOutlineMedium06
        
        /// OutlineRound
        case btnOutlineRoundMedium01
        case btnOutlineRoundMedium02
        case btnOutlineRoundMedium03
        case btnOutlineRoundMedium04
        case btnOutlineRoundMedium05
        case btnOutlineRoundMedium06
        
        /// Outline Bg
        case btnOutlineBgMedium01
        case btnOutlineBgMedium03
        case btnOutlineBgMedium04
        case btnOutlineBgMedium05
        case btnOutlineBgMedium06
        
        /// Outline Bg Round
        case btnOutlineBgRoundMedium01
        case btnOutlineBgRoundMedium03
        case btnOutlineBgRoundMedium04
        case btnOutlineBgRoundMedium05
        case btnOutlineBgRoundMedium06
        
        /// Text
        case btnTextMedium01
        case btnTextMedium02
        case btnTextMedium03
        case btnTextMedium04
        case btnTextMedium05
        case btnTextMedium06
        case btnTextMedium07
        
        /// TextRound
        case btnTextRoundMedium01
        case btnTextRoundMedium02
        case btnTextRoundMedium03
        case btnTextRoundMedium04
        case btnTextRoundMedium05
        case btnTextRoundMedium06
        case btnTextRoundMedium07
        
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
        case btnFilledRoundSemiMedium04
        case btnFilledRoundSemiMedium05
        case btnFilledRoundSemiMedium06
        
        /// FilledTonal
        case btnFilledTonalSemiMedium01
        case btnFilledTonalSemiMedium02
        case btnFilledTonalSemiMedium03
        case btnFilledTonalSemiMedium04
        case btnFilledTonalSemiMedium05
        case btnFilledTonalSemiMedium06
        
        /// FilledTonalRound
        case btnFilledTonalRoundSemiMedium01
        case btnFilledTonalRoundSemiMedium02
        case btnFilledTonalRoundSemiMedium03
        case btnFilledTonalRoundSemiMedium04
        case btnFilledTonalRoundSemiMedium05
        case btnFilledTonalRoundSemiMedium06
        
        /// Outline
        case btnOutlineSemiMedium01
        case btnOutlineSemiMedium02
        case btnOutlineSemiMedium03
        case btnOutlineSemiMedium04
        case btnOutlineSemiMedium05
        case btnOutlineSemiMedium06
        
        /// OutlineRound
        case btnOutlineRoundSemiMedium01
        case btnOutlineRoundSemiMedium02
        case btnOutlineRoundSemiMedium03
        case btnOutlineRoundSemiMedium04
        case btnOutlineRoundSemiMedium05
        case btnOutlineRoundSemiMedium06
        
        /// Outline Bg
        case btnOutlineBgSemiMedium01
        case btnOutlineBgSemiMedium03
        case btnOutlineBgSemiMedium04
        case btnOutlineBgSemiMedium05
        case btnOutlineBgSemiMedium06
        
        /// Outline Bg Round
        case btnOutlineBgRoundSemiMedium01
        case btnOutlineBgRoundSemiMedium03
        case btnOutlineBgRoundSemiMedium04
        case btnOutlineBgRoundSemiMedium05
        case btnOutlineBgRoundSemiMedium06
        
        /// Text
        case btnTextSemiMedium01
        case btnTextSemiMedium02
        case btnTextSemiMedium03
        case btnTextSemiMedium04
        case btnTextSemiMedium05
        case btnTextSemiMedium06
        case btnTextSemiMedium07
        
        /// TextRound
        case btnTextRoundSemiMedium01
        case btnTextRoundSemiMedium02
        case btnTextRoundSemiMedium03
        case btnTextRoundSemiMedium04
        case btnTextRoundSemiMedium05
        case btnTextRoundSemiMedium06
        case btnTextRoundSemiMedium07
        
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
        case btnFilledRoundSmall04
        case btnFilledRoundSmall05
        case btnFilledRoundSmall06
        
        /// FilledTonal
        case btnFilledTonalSmall01
        case btnFilledTonalSmall02
        case btnFilledTonalSmall03
        case btnFilledTonalSmall04
        case btnFilledTonalSmall05
        case btnFilledTonalSmall06
        
        /// FilledTonalRound
        case btnFilledTonalRoundSmall01
        case btnFilledTonalRoundSmall02
        case btnFilledTonalRoundSmall03
        case btnFilledTonalRoundSmall04
        case btnFilledTonalRoundSmall05
        case btnFilledTonalRoundSmall06
        
        /// Outline
        case btnOutlineSmall01
        case btnOutlineSmall02
        case btnOutlineSmall03
        case btnOutlineSmall04
        case btnOutlineSmall05
        case btnOutlineSmall06
        
        /// OutlineRound
        case btnOutlineRoundSmall01
        case btnOutlineRoundSmall02
        case btnOutlineRoundSmall03
        case btnOutlineRoundSmall04
        case btnOutlineRoundSmall05
        case btnOutlineRoundSmall06
        
        /// Outline Bg
        case btnOutlineBgSmall01
        case btnOutlineBgSmall03
        case btnOutlineBgSmall04
        case btnOutlineBgSmall05
        case btnOutlineBgSmall06
        
        /// Outline Bg Round
        case btnOutlineBgRoundSmall01
        case btnOutlineBgRoundSmall03
        case btnOutlineBgRoundSmall04
        case btnOutlineBgRoundSmall05
        case btnOutlineBgRoundSmall06
        
        /// Text
        case btnTextSmall01
        case btnTextSmall02
        case btnTextSmall03
        case btnTextSmall04
        case btnTextSmall05
        case btnTextSmall06
        case btnTextSmall07
        
        /// TextRound
        case btnTextRoundSmall01
        case btnTextRoundSmall02
        case btnTextRoundSmall03
        case btnTextRoundSmall04
        case btnTextRoundSmall05
        case btnTextRoundSmall06
        case btnTextRoundSmall07
        
        // MARK: - Config
        var config: ClickableUnitButtonConfig {
            switch self {
                // ✅ Filled
            case .btnFilledLarge01, .btnFilledLarge02, .btnFilledLarge03, .btnFilledLarge04, .btnFilledLarge05, .btnFilledLarge06:
                return ButtonFilledConfig.large
            case .btnFilledMedium01, .btnFilledMedium02, .btnFilledMedium03, .btnFilledMedium04, .btnFilledMedium05, .btnFilledMedium06:
                return ButtonFilledConfig.medium
            case .btnFilledSemiMedium01, .btnFilledSemiMedium02, .btnFilledSemiMedium03, .btnFilledSemiMedium04, .btnFilledSemiMedium05, .btnFilledSemiMedium06:
                return ButtonFilledConfig.semiMedium
            case .btnFilledSmall01, .btnFilledSmall02, .btnFilledSmall03, .btnFilledSmall04, .btnFilledSmall05, .btnFilledSmall06:
                return ButtonFilledConfig.small
                
                // ✅ FilledRound
            case .btnFilledRoundLarge01, .btnFilledRoundLarge02, .btnFilledRoundLarge03, .btnFilledRoundLarge04, .btnFilledRoundLarge05, .btnFilledRoundLarge06:
                return ButtonFilledRoundConfig.large
            case .btnFilledRoundMedium01, .btnFilledRoundMedium02, .btnFilledRoundMedium03, .btnFilledRoundMedium04, .btnFilledRoundMedium05, .btnFilledRoundMedium06:
                return ButtonFilledRoundConfig.medium
            case .btnFilledRoundSemiMedium01, .btnFilledRoundSemiMedium02, .btnFilledRoundSemiMedium03, .btnFilledRoundSemiMedium04, .btnFilledRoundSemiMedium05, .btnFilledRoundSemiMedium06:
                return ButtonFilledRoundConfig.semiMedium
            case .btnFilledRoundSmall01, .btnFilledRoundSmall02, .btnFilledRoundSmall03, .btnFilledRoundSmall04, .btnFilledRoundSmall05, .btnFilledRoundSmall06:
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
                
                // ✅ FilledTonalRound
            case .btnFilledTonalRoundLarge01, .btnFilledTonalRoundLarge02, .btnFilledTonalRoundLarge03, .btnFilledTonalRoundLarge04, .btnFilledTonalRoundLarge05, .btnFilledTonalRoundLarge06:
                return ButtonFilledTonalRoundConfig.large
            case .btnFilledTonalRoundMedium01, .btnFilledTonalRoundMedium02, .btnFilledTonalRoundMedium03, .btnFilledTonalRoundMedium04, .btnFilledTonalRoundMedium05, .btnFilledTonalRoundMedium06:
                return ButtonFilledTonalRoundConfig.medium
            case .btnFilledTonalRoundSemiMedium01, .btnFilledTonalRoundSemiMedium02, .btnFilledTonalRoundSemiMedium03, .btnFilledTonalRoundSemiMedium04, .btnFilledTonalRoundSemiMedium05, .btnFilledTonalRoundSemiMedium06:
                return ButtonFilledTonalRoundConfig.semiMedium
            case .btnFilledTonalRoundSmall01, .btnFilledTonalRoundSmall02, .btnFilledTonalRoundSmall03, .btnFilledTonalRoundSmall04, .btnFilledTonalRoundSmall05, .btnFilledTonalRoundSmall06:
                return ButtonFilledTonalRoundConfig.small
                
                // ✅ Outline
            case .btnOutlineLarge01, .btnOutlineLarge02, .btnOutlineLarge03, .btnOutlineLarge04, .btnOutlineLarge05, .btnOutlineLarge06:
                return ButtonOutlineConfig.large
            case .btnOutlineMedium01, .btnOutlineMedium02, .btnOutlineMedium03, .btnOutlineMedium04, .btnOutlineMedium05, .btnOutlineMedium06:
                return ButtonOutlineConfig.medium
            case .btnOutlineSemiMedium01, .btnOutlineSemiMedium02, .btnOutlineSemiMedium03, .btnOutlineSemiMedium04, .btnOutlineSemiMedium05, .btnOutlineSemiMedium06:
                return ButtonOutlineConfig.semiMedium
            case .btnOutlineSmall01, .btnOutlineSmall02, .btnOutlineSmall03, .btnOutlineSmall04, .btnOutlineSmall05, .btnOutlineSmall06:
                return ButtonOutlineConfig.small
                
                // ✅ OutlineRound
            case .btnOutlineRoundLarge01, .btnOutlineRoundLarge02, .btnOutlineRoundLarge03, .btnOutlineRoundLarge04, .btnOutlineRoundLarge05, .btnOutlineRoundLarge06:
                return ButtonOutlineConfig.roundLarge
            case .btnOutlineRoundMedium01, .btnOutlineRoundMedium02, .btnOutlineRoundMedium03, .btnOutlineRoundMedium04, .btnOutlineRoundMedium05, .btnOutlineRoundMedium06:
                return ButtonOutlineConfig.roundMedium
            case .btnOutlineRoundSemiMedium01, .btnOutlineRoundSemiMedium02, .btnOutlineRoundSemiMedium03, .btnOutlineRoundSemiMedium04, .btnOutlineRoundSemiMedium05, .btnOutlineRoundSemiMedium06:
                return ButtonOutlineConfig.roundSemiMedium
            case .btnOutlineRoundSmall01, .btnOutlineRoundSmall02, .btnOutlineRoundSmall03, .btnOutlineRoundSmall04, .btnOutlineRoundSmall05, .btnOutlineRoundSmall06:
                return ButtonOutlineConfig.roundSmall
                
                // ✅ Outline Bg
            case .btnOutlineBgLarge01, .btnOutlineBgLarge03, .btnOutlineBgLarge04, .btnOutlineBgLarge05, .btnOutlineBgLarge06:
                return ButtonOutlineConfig.large
            case .btnOutlineBgMedium01, .btnOutlineBgMedium03, .btnOutlineBgMedium04, .btnOutlineBgMedium05, .btnOutlineBgMedium06:
                return ButtonOutlineConfig.medium
            case .btnOutlineBgSemiMedium01, .btnOutlineBgSemiMedium03, .btnOutlineBgSemiMedium04, .btnOutlineBgSemiMedium05, .btnOutlineBgSemiMedium06:
                return ButtonOutlineConfig.semiMedium
            case .btnOutlineBgSmall01, .btnOutlineBgSmall03, .btnOutlineBgSmall04, .btnOutlineBgSmall05, .btnOutlineBgSmall06:
                return ButtonOutlineConfig.small
                
                // ✅ Outline Bg Round
            case .btnOutlineBgRoundLarge01, .btnOutlineBgRoundLarge03, .btnOutlineBgRoundLarge04, .btnOutlineBgRoundLarge05, .btnOutlineBgRoundLarge06:
                return ButtonOutlineConfig.roundLarge
            case .btnOutlineBgRoundMedium01, .btnOutlineBgRoundMedium03, .btnOutlineBgRoundMedium04, .btnOutlineBgRoundMedium05, .btnOutlineBgRoundMedium06:
                return ButtonOutlineConfig.roundMedium
            case .btnOutlineBgRoundSemiMedium01, .btnOutlineBgRoundSemiMedium03, .btnOutlineBgRoundSemiMedium04, .btnOutlineBgRoundSemiMedium05, .btnOutlineBgRoundSemiMedium06:
                return ButtonOutlineConfig.roundSemiMedium
            case .btnOutlineBgRoundSmall01, .btnOutlineBgRoundSmall03, .btnOutlineBgRoundSmall04, .btnOutlineBgRoundSmall05, .btnOutlineBgRoundSmall06:
                return ButtonOutlineConfig.roundSmall
                
                // ✅ Text
            case .btnTextLarge01, .btnTextLarge02, .btnTextLarge03, .btnTextLarge04, .btnTextLarge05, .btnTextLarge06, .btnTextLarge07:
                return ButtonTextConfig.large
            case .btnTextMedium01, .btnTextMedium02, .btnTextMedium03, .btnTextMedium04, .btnTextMedium05, .btnTextMedium06, .btnTextMedium07:
                return ButtonTextConfig.medium
            case .btnTextSemiMedium01, .btnTextSemiMedium02, .btnTextSemiMedium03, .btnTextSemiMedium04, .btnTextSemiMedium05, .btnTextSemiMedium06, .btnTextSemiMedium07:
                return ButtonTextConfig.semiMedium
            case .btnTextSmall01, .btnTextSmall02, .btnTextSmall03, .btnTextSmall04, .btnTextSmall05, .btnTextSmall06, .btnTextSmall07:
                return ButtonTextConfig.small
                
                // ✅ TextRound
            case .btnTextRoundLarge01, .btnTextRoundLarge02, .btnTextRoundLarge03, .btnTextRoundLarge04, .btnTextRoundLarge05, .btnTextRoundLarge06, .btnTextRoundLarge07:
                return ButtonTextConfig.roundLarge
            case .btnTextRoundMedium01, .btnTextRoundMedium02, .btnTextRoundMedium03, .btnTextRoundMedium04, .btnTextRoundMedium05, .btnTextRoundMedium06, .btnTextRoundMedium07:
                return ButtonTextConfig.roundMedium
            case .btnTextRoundSemiMedium01, .btnTextRoundSemiMedium02, .btnTextRoundSemiMedium03, .btnTextRoundSemiMedium04, .btnTextRoundSemiMedium05, .btnTextRoundSemiMedium06, .btnTextRoundSemiMedium07:
                return ButtonTextConfig.roundSemiMedium
            case .btnTextRoundSmall01, .btnTextRoundSmall02, .btnTextRoundSmall03, .btnTextRoundSmall04, .btnTextRoundSmall05, .btnTextRoundSmall06, .btnTextRoundSmall07:
                return ButtonTextConfig.roundSmall
            }
        }
        
        // MARK: - Color
        var color: ClickableUnitButtonColorConfig {
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
                return ButtonFilledRoundColor.gradient
            case .btnFilledRoundLarge03, .btnFilledRoundMedium03, .btnFilledRoundSemiMedium03, .btnFilledRoundSmall03:
                return ButtonFilledRoundColor.primary02
            case .btnFilledRoundLarge04, .btnFilledRoundMedium04, .btnFilledRoundSemiMedium04, .btnFilledRoundSmall04:
                return ButtonFilledRoundColor.mbs01
            case .btnFilledRoundLarge05, .btnFilledRoundMedium05, .btnFilledRoundSemiMedium05, .btnFilledRoundSmall05:
                return ButtonFilledRoundColor.mbsGradient
            case .btnFilledRoundLarge06, .btnFilledRoundMedium06, .btnFilledRoundSemiMedium06, .btnFilledRoundSmall06:
                return ButtonFilledRoundColor.primary05
                
                // ✅ ButtonFilledTonalColor
            case .btnFilledTonalLarge01, .btnFilledTonalMedium01, .btnFilledTonalSemiMedium01, .btnFilledTonalSmall01:
                return ButtonFilledTonalColor.primary01
            case .btnFilledTonalLarge02, .btnFilledTonalMedium02, .btnFilledTonalSemiMedium02, .btnFilledTonalSmall02:
                return ButtonFilledTonalColor.primary02
            case .btnFilledTonalLarge03, .btnFilledTonalMedium03, .btnFilledTonalSemiMedium03, .btnFilledTonalSmall03:
                return ButtonFilledTonalColor.secondary01
            case .btnFilledTonalLarge04, .btnFilledTonalMedium04, .btnFilledTonalSemiMedium04, .btnFilledTonalSmall04:
                return ButtonFilledTonalColor.secondary02
            case .btnFilledTonalLarge05, .btnFilledTonalMedium05, .btnFilledTonalSemiMedium05, .btnFilledTonalSmall05:
                return ButtonFilledTonalColor.secondary03
            case .btnFilledTonalLarge06, .btnFilledTonalMedium06, .btnFilledTonalSemiMedium06, .btnFilledTonalSmall06:
                return ButtonFilledTonalColor.secondary04
                
                // ✅ ButtonFilledTonalRoundColor
            case .btnFilledTonalRoundLarge01, .btnFilledTonalRoundMedium01, .btnFilledTonalRoundSemiMedium01, .btnFilledTonalRoundSmall01:
                return ButtonFilledTonalRoundColor.primary01
            case .btnFilledTonalRoundLarge02, .btnFilledTonalRoundMedium02, .btnFilledTonalRoundSemiMedium02, .btnFilledTonalRoundSmall02:
                return ButtonFilledTonalRoundColor.primary02
            case .btnFilledTonalRoundLarge03, .btnFilledTonalRoundMedium03, .btnFilledTonalRoundSemiMedium03, .btnFilledTonalRoundSmall03:
                return ButtonFilledTonalRoundColor.secondary01
            case .btnFilledTonalRoundLarge04, .btnFilledTonalRoundMedium04, .btnFilledTonalRoundSemiMedium04, .btnFilledTonalRoundSmall04:
                return ButtonFilledTonalRoundColor.secondary02
            case .btnFilledTonalRoundLarge05, .btnFilledTonalRoundMedium05, .btnFilledTonalRoundSemiMedium05, .btnFilledTonalRoundSmall05:
                return ButtonFilledTonalRoundColor.secondary03
            case .btnFilledTonalRoundLarge06, .btnFilledTonalRoundMedium06, .btnFilledTonalRoundSemiMedium06, .btnFilledTonalRoundSmall06:
                return ButtonFilledTonalRoundColor.secondary04
                
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
                
                // ✅ ButtonOutlineColor
            case .btnOutlineRoundLarge01, .btnOutlineRoundMedium01, .btnOutlineRoundSemiMedium01, .btnOutlineRoundSmall01:
                return ButtonOutlineColor.primary01
            case .btnOutlineRoundLarge02, .btnOutlineRoundMedium02, .btnOutlineRoundSemiMedium02, .btnOutlineRoundSmall02:
                return ButtonOutlineColor.primary02
            case .btnOutlineRoundLarge03, .btnOutlineRoundMedium03, .btnOutlineRoundSemiMedium03, .btnOutlineRoundSmall03:
                return ButtonOutlineColor.secondary01
            case .btnOutlineRoundLarge04, .btnOutlineRoundMedium04, .btnOutlineRoundSemiMedium04, .btnOutlineRoundSmall04:
                return ButtonOutlineColor.secondary02
            case .btnOutlineRoundLarge05, .btnOutlineRoundMedium05, .btnOutlineRoundSemiMedium05, .btnOutlineRoundSmall05:
                return ButtonOutlineColor.secondary03
            case .btnOutlineRoundLarge06, .btnOutlineRoundMedium06, .btnOutlineRoundSemiMedium06, .btnOutlineRoundSmall06:
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
                
                // ✅ ButtonOutlineBgColor
            case .btnOutlineBgRoundLarge01, .btnOutlineBgRoundMedium01, .btnOutlineBgRoundSemiMedium01, .btnOutlineBgRoundSmall01:
                return ButtonOutlineBgColor.primary01
            case .btnOutlineBgRoundLarge03, .btnOutlineBgRoundMedium03, .btnOutlineBgRoundSemiMedium03, .btnOutlineBgRoundSmall03:
                return ButtonOutlineBgColor.secondary01
            case .btnOutlineBgRoundLarge04, .btnOutlineBgRoundMedium04, .btnOutlineBgRoundSemiMedium04, .btnOutlineBgRoundSmall04:
                return ButtonOutlineBgColor.secondary02
            case .btnOutlineBgRoundLarge05, .btnOutlineBgRoundMedium05, .btnOutlineBgRoundSemiMedium05, .btnOutlineBgRoundSmall05:
                return ButtonOutlineBgColor.secondary03
            case .btnOutlineBgRoundLarge06, .btnOutlineBgRoundMedium06, .btnOutlineBgRoundSemiMedium06, .btnOutlineBgRoundSmall06:
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
                
                // ✅ ButtonTextColor
            case .btnTextRoundLarge01, .btnTextRoundMedium01, .btnTextRoundSemiMedium01, .btnTextRoundSmall01:
                return ButtonTextColor.primary01
            case .btnTextRoundLarge02, .btnTextRoundMedium02, .btnTextRoundSemiMedium02, .btnTextRoundSmall02:
                return ButtonTextColor.primary02
            case .btnTextRoundLarge03, .btnTextRoundMedium03, .btnTextRoundSemiMedium03, .btnTextRoundSmall03:
                return ButtonTextColor.secondary01
            case .btnTextRoundLarge04, .btnTextRoundMedium04, .btnTextRoundSemiMedium04, .btnTextRoundSmall04:
                return ButtonTextColor.secondary02
            case .btnTextRoundLarge05, .btnTextRoundMedium05, .btnTextRoundSemiMedium05, .btnTextRoundSmall05:
                return ButtonTextColor.secondary03
            case .btnTextRoundLarge06, .btnTextRoundMedium06, .btnTextRoundSemiMedium06, .btnTextRoundSmall06:
                return ButtonTextColor.secondary04
            case .btnTextRoundLarge07, .btnTextRoundMedium07, .btnTextRoundSemiMedium07, .btnTextRoundSmall07:
                return ButtonTextColor.secondary05
            }
        }
    }
}

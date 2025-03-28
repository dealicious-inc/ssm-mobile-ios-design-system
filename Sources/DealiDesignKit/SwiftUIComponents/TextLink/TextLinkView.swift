//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 3/27/25.
//

import SwiftUI

public struct TextLinkView: View {
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        var action: () -> Void = {}
        @Published var configStyle: TextLinkConfig = TextLinkConfig(size: TextLinkSizeType.large.size, style: TextLinkStyleType.primary01.style)
        @Published var title: String?
        @Published var leftImage: UIImage?
        @Published var rightImage: UIImage?
        
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString(viewModel.title ?? "Text Link")
        if viewModel.configStyle.withLine == true {
            string.underlineStyle = .single
        }
        return string
    }
    
    public init() { }
    
    public var body: some View {
        Button(action: viewModel.action) {
            HStack(spacing: 4.0) {
                
                if let leftImage = viewModel.leftImage {
                    Image(uiImage: leftImage)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundStyle(Color(uiColor: viewModel.configStyle.iconColor))
                }
                
                if #available(iOS 16.0, *) {
                    Text(viewModel.title ?? "Text Link")
                        .font(viewModel.configStyle.textFont)
                        .foregroundStyle(Color(uiColor: viewModel.configStyle.textColor))
                        .underline(viewModel.configStyle.withLine)
                } else {
                    Text(attributedString)
                        .font(viewModel.configStyle.textFont)
                        .foregroundStyle(Color(uiColor: viewModel.configStyle.textColor))
                }
                
                if let rightImage = viewModel.rightImage {
                    Image(uiImage: rightImage)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundStyle(Color(uiColor: viewModel.configStyle.iconColor))
                }
            }
        }.background(Color(uiColor: viewModel.configStyle.backgroundColor)).buttonStyle(PressButton())
            .fixedSize()
            .disabled(viewModel.configStyle.status == .disabled)
    }
}

public extension TextLinkView {
    func setConfigStyle(_ configStyle: TextLinkConfigStyle) -> Self {
        viewModel.configStyle = TextLinkConfig(size: configStyle.size, style: configStyle.style, withLine: configStyle.withLine)
        return self
    }
    
    func status(_ state: DealiButtonStatus) -> Self {
        viewModel.configStyle.status = state
        return self
    }
    
    func title(_ title: String?) -> Self {
        viewModel.title = title
        return self
    }
    
    func leftImage(_ leftImage: UIImage?) -> Self {
        viewModel.leftImage = leftImage
        return self
    }
    
    func rightImage(_ rightImage: UIImage?) -> Self {
        viewModel.rightImage = rightImage
        return self
    }
    
    func addAction(_ action: @escaping () -> Void) -> Self {
        viewModel.action = action
        return self
    }
    
}

#Preview {
    TextLinkView()
        .setConfigStyle(.textLinkLarge01)
        .leftImage(UIImage.dealiIcon(named: "ic_notice"))
        .addAction {
            print("textLink Click Action")
        }
    
    TextLinkView()
        .setConfigStyle(.textLinkLarge01)
        .leftImage(UIImage.dealiIcon(named: "ic_notice"))
        .status(.disabled)
}


// MARK: - Style
public extension TextLinkView {
    
    enum TextLinkConfigStyle {
        // MARK: Large
        case textLinkLarge01
        case textLinkLarge02
        case textLinkLarge03
        case textLinkLarge04
        case textLinkLarge05
        case textLinkLarge06
        case textLinkLarge07
        
        case textLinkLineLarge01
        case textLinkLineLarge02
        case textLinkLineLarge03
        case textLinkLineLarge04
        case textLinkLineLarge05
        case textLinkLineLarge06
        case textLinkLineLarge07
        
        // MARK: Medium
        case textLinkMedium01
        case textLinkMedium02
        case textLinkMedium03
        case textLinkMedium04
        case textLinkMedium05
        case textLinkMedium06
        case textLinkMedium07
        
        case textLinkLineMedium01
        case textLinkLineMedium02
        case textLinkLineMedium03
        case textLinkLineMedium04
        case textLinkLineMedium05
        case textLinkLineMedium06
        case textLinkLineMedium07
        
        // MARK: Small
        case textLinkSmall01
        case textLinkSmall02
        case textLinkSmall03
        case textLinkSmall04
        case textLinkSmall05
        case textLinkSmall06
        case textLinkSmall07
        
        case textLinkLineSmall01
        case textLinkLineSmall02
        case textLinkLineSmall03
        case textLinkLineSmall04
        case textLinkLineSmall05
        case textLinkLineSmall06
        case textLinkLineSmall07
        
        // MARK: - Size
        var size: TextLinkSize {
            switch self {
                // Filled
            case .textLinkLarge01, .textLinkLarge02, .textLinkLarge03, .textLinkLarge04, .textLinkLarge05, .textLinkLarge06, .textLinkLarge07, .textLinkLineLarge01, .textLinkLineLarge02, .textLinkLineLarge03, .textLinkLineLarge04, .textLinkLineLarge05, .textLinkLineLarge06, .textLinkLineLarge07:
                
                return TextLinkSizeType.large.size
                
            case .textLinkMedium01, .textLinkMedium02, .textLinkMedium03, .textLinkMedium04, .textLinkMedium05, .textLinkMedium06, .textLinkMedium07, .textLinkLineMedium01, .textLinkLineMedium02, .textLinkLineMedium03, .textLinkLineMedium04, .textLinkLineMedium05, .textLinkLineMedium06, .textLinkLineMedium07:
                
                return TextLinkSizeType.medium.size
                
            case .textLinkSmall01, .textLinkSmall02, .textLinkSmall03, .textLinkSmall04, .textLinkSmall05, .textLinkSmall06, .textLinkSmall07, .textLinkLineSmall01, .textLinkLineSmall02, .textLinkLineSmall03, .textLinkLineSmall04, .textLinkLineSmall05, .textLinkLineSmall06, .textLinkLineSmall07:
                
                return TextLinkSizeType.small.size
            }
        }
        
        // MARK: - Style
        var style: TextLinkStyle {
            switch self {
            case .textLinkLarge01, .textLinkMedium01, .textLinkSmall01, .textLinkLineLarge01, .textLinkLineMedium01, .textLinkLineSmall01:
                return TextLinkStyleType.primary01.style
                
            case .textLinkLarge02, .textLinkMedium02, .textLinkSmall02, .textLinkLineLarge02, .textLinkLineMedium02, .textLinkLineSmall02:
                return TextLinkStyleType.primary04.style
                
            case .textLinkLarge03, .textLinkMedium03, .textLinkSmall03, .textLinkLineLarge03, .textLinkLineMedium03, .textLinkLineSmall03:
                return TextLinkStyleType.secondary01.style
                
            case .textLinkLarge04, .textLinkMedium04, .textLinkSmall04, .textLinkLineLarge04, .textLinkLineMedium04, .textLinkLineSmall04:
                return TextLinkStyleType.g100.style
                
            case .textLinkLarge05, .textLinkMedium05, .textLinkSmall05, .textLinkLineLarge05, .textLinkLineMedium05, .textLinkLineSmall05:
                return TextLinkStyleType.g80.style
                
            case .textLinkLarge06, .textLinkMedium06, .textLinkSmall06, .textLinkLineLarge06, .textLinkLineMedium06, .textLinkLineSmall06:
                return TextLinkStyleType.g70.style
                
            case .textLinkLarge07, .textLinkMedium07, .textLinkSmall07, .textLinkLineLarge07, .textLinkLineMedium07, .textLinkLineSmall07:
                return TextLinkStyleType.g60.style
            }
        }
        
        // MARK: - withLine
        var withLine: Bool {
            switch self {
                // Filled
            case .textLinkLineLarge01, .textLinkLineLarge02, .textLinkLineLarge03, .textLinkLineLarge04, .textLinkLineLarge05, .textLinkLineLarge06, .textLinkLineLarge07, .textLinkLineMedium01, .textLinkLineMedium02, .textLinkLineMedium03, .textLinkLineMedium04, .textLinkLineMedium05, .textLinkLineMedium06, .textLinkLineMedium07, .textLinkLineSmall01, .textLinkLineSmall02, .textLinkLineSmall03, .textLinkLineSmall04, .textLinkLineSmall05, .textLinkLineSmall06, .textLinkLineSmall07:
                
                return true
                
            default:
                return false
            }
        }
    }
}

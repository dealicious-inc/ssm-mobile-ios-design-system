//
//  DealiImageChip.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 5/19/25.
//

import SwiftUI
import Kingfisher
public final class DealiImageChipViewModel: ObservableObject {
    @Published var urlString: String?
    @Published var text: String?
    @Published var status: DealiChipStatus = .normal
    @Published var iconName: String?
    
    public var isSelected: Bool {
        get {
            return self.status == .selected
        } set {
            guard self.status != .disabled else { return }
            self.status = newValue ? .selected : .normal
        }
    }
    
    
    var url: URL? {
        guard let urlString = urlString else { return nil }
        return URL(string: urlString)
    }
    
    public init(
        urlString: String?,
        text: String?,
        status: DealiChipStatus = .normal,
        iconName: String? = nil
    ) {
        self.urlString = urlString
        self.text = text
        self.status = status
        self.iconName = iconName
    }
    
    func toggle() {
        guard status != .disabled else { return }
        self.status.toggle()
    }
}

public struct DealiImageChip<Content: View>: View {
    @ObservedObject var viewModel: DealiImageChipViewModel
    var action: (() -> Void)?
    var content: Content
    var preset: ImageChipPreset = .imgChipLarge01
    
    private var config: DLImageChipConfig {
        return preset.config
    }
    
    public init(
        viewModel: DealiImageChipViewModel,
        action: (() -> Void)? = nil,
        @ViewBuilder content: (() -> Content),
        preset: ImageChipPreset = .imgChipLarge01
    ) {
        self.viewModel = viewModel
        self.action = action
        self.content = content()
        self.preset = preset
    }
    
    public var body: some View {
        
        let style = config.style(for: viewModel.status)
        
        Button {
            viewModel.toggle()
            action?()
        } label: {
            HStack(spacing: style.interItemSpacing) {
                imageView(for: style)
                
                Text(viewModel.text ?? "")
                    .foregroundStyle(style.textColor)
                    .font(style.titleFont)
                
                content
                    .frame(height: 20)
                
                if let iconName = viewModel.iconName {
                    Image.dealiIcon(named: iconName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: style.rightIconImageSize.width, height: style.rightIconImageSize.height)
                }
            }
            .padding(.vertical, style.verticalPadding)
            .padding(.leading, style.leftPadding)
            .padding(.trailing, style.rightPadding)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius))
            .overlay(
                Group {
                    if let borderColor = style.borderColor {
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .stroke(borderColor, lineWidth: 1)
                    }
                }
            )
        }
        .disabled(viewModel.status == .disabled)
    }
    
    func imageView(for style: DLImageChipStyle) -> some View {
        KFImage.url(viewModel.url)
            .resizable()
            .placeholder({
                ZStack {
                    Color.white
                    Image.dealiIcon(named: "ic_home_filled")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color(.g30))
                        .padding(style.placeholderInset)
                        
                }
            })
            .aspectRatio(contentMode: .fill)
            .frame(width: style.imageSize.width, height: style.imageSize.height)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color(.b5), lineWidth: 1)
            )
    }
}

public struct DealiImageChipTabBarItem {
    let viewModel: DealiImageChipViewModel
    let content: () -> AnyView
    
    public init(
        viewModel: DealiImageChipViewModel,
        content: @escaping () -> AnyView = { AnyView(EmptyView()) }
    ) {
        self.viewModel = viewModel
        self.content = content
    }
}

#Preview {
    
    DealiImageChip(
        viewModel: DealiImageChipViewModel(
            urlString:               "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D",
            text: "Sample Text",
            status: .selected,
            iconName: "ic_home_filled"
        ),
        content: {
            RoundedRectangle(cornerRadius: 4.0)
                .foregroundStyle(Color.orange)
                .frame(width: 20.0)
        }
    )
}

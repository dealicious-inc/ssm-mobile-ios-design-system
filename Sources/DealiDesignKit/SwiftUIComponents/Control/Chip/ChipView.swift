//
//  ChipView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 6/17/25.
//

import SwiftUI

public final class ChipViewModel: ObservableObject {
    @Published var type: ChipViewType = .chipOutlineLarge01
    @Published public var text: String?
    @Published public var status: DealiChipStatus = .normal
    @Published public var singleImage: UIImage? {
        didSet {
            self.text = nil
            self.leftImage = nil
            self.rightImage = nil
        }
    }
    @Published public var leftImage: UIImage?
    @Published public var rightImage: UIImage?
    
    public var isSelected: Bool {
        get {
            return self.status == .selected
        } set {
            guard self.status != .disabled else { return }
            self.status = newValue ? .selected : .normal
        }
    }
    
    public init(
        type: ChipViewType,
        text: String? = nil,
        status: DealiChipStatus = .normal,
        singleImage: UIImage? = nil
    ) {
        self.type = type
        self.text = text
        self.status = status
        self.singleImage = singleImage
    }
    
    public init(
        type: ChipViewType,
        text: String? = nil,
        status: DealiChipStatus = .normal,
        leftImage: UIImage? = nil,
        rightImage: UIImage? = nil
    ) {
        self.type = type
        self.text = text
        self.status = status
        self.leftImage = leftImage
        self.rightImage = rightImage
    }
    
    func toggle() {
        guard status != .disabled else { return }
        self.status.toggle()
    }
}

public struct ChipView: View {
    @ObservedObject public var viewModel: ChipViewModel
    var action: (() -> Void)?
    
    public init(viewModel: ChipViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        let colorAttribute = viewModel.type.color.attribute
        let chipColor = (viewModel.status == .disabled)
        ? colorAttribute.disabled
        : (viewModel.isSelected ? (colorAttribute.selected ?? colorAttribute.normal) : colorAttribute.normal)
        
        let config = viewModel.type.config.font
        let font = (viewModel.status == .disabled)
        ? config.disabled
        : (viewModel.isSelected ? config.selected ?? config.normal : config.normal)
        
        let paddingSet = viewModel.type.padding.value(with: viewModel.type.config.height, style: .chip)
        let singleImagePadding = viewModel.type.config.singleImagePadding
        
        let leftPadding = viewModel.singleImage != nil
        ? singleImagePadding
        : viewModel.leftImage != nil ? paddingSet.left.withImage : paddingSet.left.normal
        
        let rightPadding = viewModel.singleImage != nil
        ? singleImagePadding
        : viewModel.rightImage != nil ? paddingSet.right.withImage : paddingSet.right.normal
        
        Button {
            
        } label: {
            HStack(spacing: 4.0) {
                if let leftImageName = viewModel.leftImage {
                    Image(uiImage: leftImageName).frame(width: 16.0, height: 16.0)
                } else if let singleImage = viewModel.singleImage {
                    Image(uiImage: singleImage).frame(width: 16.0, height: 16.0)
                }
                
                if let text = viewModel.text, !text.isEmpty {
                    Text(text)
                        .foregroundStyle(Color(chipColor.text))
                        .font(Font(font))
                }
                
                if let rightImage = viewModel.rightImage, viewModel.singleImage == nil {
                    Image(uiImage: rightImage).frame(width: 16.0, height: 16.0)
                }
            }
            .padding(.leading, leftPadding)
            .padding(.trailing, rightPadding)
            .frame(height: viewModel.type.config.height.chip)
            .background(Color(chipColor.background))
            .clipShape(RoundedRectangle(cornerRadius: viewModel.type.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: viewModel.type.cornerRadius)
                    .stroke(Color(chipColor.border ?? .clear))
                    .frame(height: viewModel.type.config.height.chip)
            )
        }
        .disabled(viewModel.status == .disabled)
        .frame(height: viewModel.type.config.height.chip)
    }
}

public enum ChipViewType: CaseIterable {
    case chipOutlineLarge01
    case chipOutlineMedium01
    case chipOutlineMedium02
    case chipOutlineSmall01

    case chipFilledLarge01
    case chipFilledMedium01
    case chipFilledSmall01
    case chipFilledSmall02
    case chipFilledSmall03
    
    case chipFilledSquareLarge01
    case chipFilledSquareLarge02
    case chipFilledSquareLarge03
    case chipFilledSquareMedium01
    case chipFilledSquareMedium02
    case chipFilledSquareSmall01
    case chipFilledSquareSmall02
    
    case chipOutlineSquareLarge01
    case chipOutlineSquareMedium01
    case chipOutlineSquareSmall01
    
    var color: ClickableColorConfig {
        switch self {
        case .chipOutlineLarge01, .chipOutlineMedium01, .chipOutlineSmall01:
            return ChipsOutlineColor.primary01
        case .chipOutlineMedium02:
            return ChipsOutlineColor.primary02
            
        case .chipFilledLarge01, .chipFilledMedium01, .chipFilledSmall01:
            return ChipsFilledColor.primary01
        case .chipFilledSmall02:
            return ChipsFilledColor.secondary01
        case .chipFilledSmall03:
            return ChipsFilledColor.primary02
        
        case .chipFilledSquareLarge01, .chipFilledSquareMedium01, .chipFilledSquareSmall01:
            return ChipsFilledSquareColor.primary01
        case .chipFilledSquareLarge02:
            return ChipsFilledSquareColor.primary02
        case .chipFilledSquareLarge03, .chipFilledSquareMedium02, .chipFilledSquareSmall02:
            return ChipsFilledSquareColor.scondary01
            
        case .chipOutlineSquareLarge01, .chipOutlineSquareMedium01, .chipOutlineSquareSmall01:
            return ChipsSquareColor.primary01
        }
    }
    
    var config: ChipsConfig {
        switch self {
        case .chipOutlineLarge01, .chipFilledLarge01, .chipFilledSquareLarge01, .chipFilledSquareLarge02, .chipOutlineSquareLarge01, .chipFilledSquareLarge03:
            return ChipsConfig.large
        case .chipOutlineMedium01, .chipOutlineMedium02, .chipFilledMedium01, .chipFilledSquareMedium01, .chipFilledSquareMedium02, .chipOutlineSquareMedium01:
            return ChipsConfig.medium
        case .chipOutlineSmall01, .chipFilledSmall01, .chipFilledSmall02, .chipFilledSmall03, .chipFilledSquareSmall01, .chipFilledSquareSmall02, .chipOutlineSquareSmall01:
            return ChipsConfig.small
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .chipOutlineLarge01, .chipOutlineMedium01, .chipOutlineMedium02, .chipOutlineSmall01, .chipFilledLarge01, .chipFilledMedium01, .chipFilledSmall01, .chipFilledSmall02, .chipFilledSmall03:
            return config.height.chip / 2
        default:
            return 4.0
        }
    }
    
    var padding: ClickableComponent.Configuration.Padding {
        switch self {
        case .chipOutlineLarge01, .chipOutlineMedium01, .chipOutlineMedium02, .chipOutlineSmall01, .chipFilledLarge01, .chipFilledMedium01, .chipFilledSmall01, .chipFilledSmall02, .chipFilledSmall03:
            return .round
        default:
            return .square
        }
    }
}
 
#Preview {
    ChipView(viewModel: ChipViewModel(type: .chipOutlineLarge01, text: "Chip"))
}

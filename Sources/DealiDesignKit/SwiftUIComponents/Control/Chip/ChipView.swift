//
//  ChipView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 6/17/25.
//

import SwiftUI

public final class ChipViewModel: ObservableObject {
    @Published public var text: String?
    @Published public var status: DealiChipStatus = .normal
    
    public var isSelected: Bool {
        get {
            return self.status == .selected
        } set {
            guard self.status != .disabled else { return }
            self.status = newValue ? .selected : .normal
        }
    }
    
    public init(
        text: String?,
        status: DealiChipStatus = .normal
    ) {
        self.text = text
        self.status = status
    }
    
    func toggle() {
        guard status != .disabled else { return }
        self.status.toggle()
    }
}

public struct ChipView: View {
    @ObservedObject var viewModel: ChipViewModel
    var action: (() -> Void)?
//    var preset: ImageChipPreset = .imgChipLarge01
//
//    private var config: DLImageChipConfig {
//        return preset.config
//    }
    
    public init(viewModel: ChipViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        Button {
            
        } label: {
            HStack(spacing: 4.0) {
                
                Image(uiImage: UIImage(named: "ic_refresh")!).frame(width: 16.0, height: 16.0)
                    
                
                Text(viewModel.text ?? "")
                    .foregroundStyle(Color(.g100))
                    .font(Font(UIFont.b2sb14))
                
                Image(uiImage: UIImage(named: "ic_refresh")!).frame(width: 16.0, height: 16.0)
            }
            .padding(.vertical, 13.0)
            .padding(.horizontal, 12.0)
            .background(Color(.primary04))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color(.g100))
            )
//            .clipShape(RoundedRectangle(cornerRadius: 6.0))
//            .overlay(
//                RoundedRectangle(cornerRadius: 6.0)
//                    .stroke(Color(.g100))
//            )
            
            
        }
        .disabled(viewModel.status == .disabled)
        .frame(height: 46.0)
    }
}

public enum ChipViewStyle: CaseIterable {
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
        case .chipFilledSmall02, .chipFilledSmall03:
            return ChipsFilledColor.secondary01
            // 작업중 ~~
        }
    }
}
 
#Preview {
    ChipView(viewModel: ChipViewModel(text: "Chip"))
}

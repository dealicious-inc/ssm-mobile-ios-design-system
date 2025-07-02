//
//  CheckboxView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 2/27/25.
//

import SwiftUI

public struct CheckboxView: View {
    @ObservedObject public var viewModel = CheckboxViewModel()
    public var label: String?
    
    public init(label: String? = nil, viewModel: CheckboxViewModel = CheckboxViewModel()) {
        self.label = label
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Button(action: {
            guard self.viewModel.isEnabled else { return }
            self.viewModel.toggle()
        }) {
            HStack(spacing: 8.0) {
                Image(self.viewModel.imageName, bundle: .module)
                    .resizable()
                    .frame(width: 24.0, height: 24.0)
                
                if let label = self.label {
                    Text(label)
                        .font(Font(UIFont.b2r14))
                        .foregroundStyle(Color(self.viewModel.textColor))
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(NoHighlightButtonStyle())
        .disabled(!self.viewModel.isEnabled)
    }
}

public final class CheckboxViewModel: ObservableObject {
    @Published public var isSelected: Bool = false
    @Published public var isEnabled: Bool = true
    
    public init() {}
    
    public init(isSelected: Bool = false, isEnabled: Bool = true) {
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }
    
    func toggle() {
        guard self.isEnabled else { return }
        self.isSelected.toggle()
    }
    
    var imageName: String {
        switch self.isEnabled {
        case true:
            return self.isSelected ? "ic_checkbox_on" : "ic_checkbox_off"
        case false:
            return  self.isSelected ? "ic_checkbox_ondisable" : "ic_checkbox_disable"
        }
    }
    
    var textColor: UIColor {
        switch self.isEnabled {
        case true:
            return .g100
        case false:
            return .g50
        }
    }
}

public struct NoHighlightButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 기본 상태
            CheckboxView(label: "기본 체크박스")
                .previewDisplayName("기본 상태")
            
            // 선택된 상태
            CheckboxView(label: "선택된 체크박스", viewModel: {
                let vm = CheckboxViewModel()
                vm.isSelected = true
                return vm
            }())
                .previewDisplayName("선택된 상태")
            
            // 비활성화 상태
            CheckboxView(label: "비활성화 체크박스", viewModel: {
                let vm = CheckboxViewModel()
                vm.isEnabled = false
                return vm
            }())
                .previewDisplayName("비활성화 상태")
            
            // 선택된 비활성화 상태
            CheckboxView(label: "선택된 비활성화 체크박스", viewModel: {
                let vm = CheckboxViewModel()
                vm.isSelected = true
                vm.isEnabled = false
                return vm
            }())
                .previewDisplayName("선택된 비활성화 상태")
            
            // 라벨 없는 상태
            CheckboxView(label: nil)
                .previewDisplayName("라벨 없음")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

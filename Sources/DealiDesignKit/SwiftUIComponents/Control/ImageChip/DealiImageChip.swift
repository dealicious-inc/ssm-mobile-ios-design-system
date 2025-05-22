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
    
    var url: URL? {
        guard let urlString = urlString else { return nil }
        return URL(string: urlString)
    }
    
    init(
        urlString: String?,
        text: String?,
        status: DealiChipStatus = .normal
    ) {
        self.urlString = urlString
        self.text = text
        self.status = status
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
    
    public init(
        viewModel: DealiImageChipViewModel,
        action: (() -> Void)? = nil,
        @ViewBuilder content: (() -> Content)
    ) {
        self.viewModel = viewModel
        self.action = action
        self.content = content()
    }
    
    public var body: some View {
        
        let style = viewModel.status.style(for: .basic)

        Button {
            viewModel.toggle()
            action?()
        } label: {
            HStack {
                KFImage.url(viewModel.url)
                    .resizable()
                    .placeholder({
                        ZStack {
                            Color.white
                            Image.dealiIcon(named: "ic_home_filled")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color(.g30))
                                .padding(1.5)
                        }
                    })
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(.b5), lineWidth: 1)
                    )
                    
                Text(viewModel.text ?? "")
                    .foregroundStyle(style.textColor)
                    
                content
                    .background(Color.orange)
                    .frame(height: 20)
            }
            .padding(4.0)
            .background(style.backgroundColor)
        }
    }
}

#Preview {
    
    DealiImageChip(
        viewModel: DealiImageChipViewModel(
            urlString: nil,
//                "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D",
            text: "Sample Text",
            status: .selected
        ),
        content: {
            Rectangle()
            
        }
    )
}

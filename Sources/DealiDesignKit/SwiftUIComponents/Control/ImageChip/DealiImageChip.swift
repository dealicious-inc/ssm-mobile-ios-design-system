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
    
    var url: URL? {
        guard let urlString = urlString else { return nil }
        return URL(string: urlString)
    }
    
    init(
        urlString: String?,
        text: String?
    ) {
        self.urlString = urlString
        self.text = text
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
        Button {
            action?()
        } label: {
            HStack {
                KFImage.url(viewModel.url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(.b5), lineWidth: 1)
                    )
                    
                Text(viewModel.text ?? "")
                content
                    .frame(width: 20, height: 20)
            }
            .padding(4.0)
            .background(Color(.g80))

        }
    }
}


#Preview {
    DealiImageChip(
        viewModel: DealiImageChipViewModel(
            urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D",
            text: "Sample Text"
        ), content: {
            
        }
    )
}

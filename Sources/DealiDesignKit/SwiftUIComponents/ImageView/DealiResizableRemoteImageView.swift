//
//  DealiResizableRemoteImageView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 10/30/25.
//

import SwiftUI
import Kingfisher

/**
 설명: 이미지 사이즈에 맞게 리사이징한 url을 받아와 이미지를 보여주는 뷰
 */
public struct DealiResizableRemoteImageView<Placeholder: View>: View {
    let urlString: String?
    var contentMode: SwiftUI.ContentMode = .fill
    var resizer: (((String?, CGSize)) -> URL?)?
    var placeholder: Placeholder

    public init(
        urlString: String?,
        contentMode: SwiftUI.ContentMode = .fill,
        resizer: (((String?, CGSize)) -> URL?)?,
        @ViewBuilder placeholder: () -> Placeholder = { DealiImagePlaceholder() }
    ) {
        self.urlString = urlString
        self.contentMode = contentMode
        self.resizer = resizer
        self.placeholder = placeholder()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let targetSize = geometry.size
            
            let finalUrl = self.resizer?((self.urlString, targetSize))
            
            let width = targetSize.width * UIScreen.main.scale
            let height = targetSize.height * UIScreen.main.scale
            let processor = DownsamplingImageProcessor(size: CGSize(width: width, height: height))
            
            KFImage(finalUrl)
                .placeholder { self.placeholder }
                .setProcessor(processor)
                .cacheOriginalImage(false)
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: self.contentMode)
                .frame(width: targetSize.width, height: targetSize.height)
                .clipped()
        }
    }
}

// MARK: - Preview
struct DealiResizableRemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                DealiResizableRemoteImageView(urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D", resizer: { urlString, _ in
                    guard let urlString = urlString else { return nil }
                    return URL(string: urlString)
                })
                    .frame(width: 200, height: 150)
                    .padding()
                
                DealiResizableRemoteImageView(urlString: nil, resizer: nil)
                    .frame(width: 200, height: 150)
                    .padding()
            }
            .previewLayout(.sizeThatFits)
        }
    }
}

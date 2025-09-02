//
//  Image+Extension.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 3/12/25.
//

import SwiftUI
import Kingfisher

public extension Image {
    
    static func dealiIcon(named: String) -> Image {
        return Image(named, bundle: .module)
    }
}

public struct KFImageView: View {
    let url: URL?
    let size: CGSize?
    let contentMode: SwiftUI.ContentMode
    let completion: ((UIImage?) -> Void)?

    public init(url: URL?,
                size: CGSize? = nil,
                contentMode: SwiftUI.ContentMode = .fit,
                completion: ((UIImage?) -> Void)? = nil) {
        self.url = url
        self.size = size
        self.contentMode = contentMode
        self.completion = completion
    }

    public var body: some View {
        KFImage(url)
            .placeholder {
                Color.gray.opacity(0.1)
            }
            .setProcessor()
            .onSuccess { result in
                completion?(result.image)
            }
            .onFailure { _ in
                completion?(nil)
            }
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: size?.width, height: size?.height)
    }
}

private extension KFImage {
    func setProcessor(_ size: CGSize? = nil) -> KFImage {
        guard let size else { return self }

        let processor = DownsamplingImageProcessor(size: size)
        return self
            .resizable()
            .setProcessor(processor)
            .scaleFactor(UIScreen.main.scale)
            .cacheOriginalImage()
    }
}


public struct ImageHelper {
    @ViewBuilder
    static func kfImage(
        url: URL?,
        size: CGSize? = nil,
        contentMode: SwiftUI.ContentMode = .fit,
        onComplete: ((UIImage?) -> Void)? = nil
    ) -> some View {
        KFImage(url)
            .placeholder {
                Color.clear
            }
            .resizable()
            .setProcessor(size)
            .onSuccess { result in
                onComplete?(result.image)
            }
            .onFailure { _ in
                onComplete?(nil)
            }
            .aspectRatio(contentMode: contentMode)
            .frame(width: size?.width, height: size?.height)
    }
}

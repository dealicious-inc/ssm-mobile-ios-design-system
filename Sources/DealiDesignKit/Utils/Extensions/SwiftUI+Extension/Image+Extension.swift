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

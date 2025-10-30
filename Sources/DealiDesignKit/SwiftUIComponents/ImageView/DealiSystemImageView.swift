//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 10/30/25.
//

import SwiftUI
/**
 설명: systemStyle을 받아 리사이징 및 placeholder를 그리는 시스템 컴포넌트
 */
public struct DealiSystemImageView: View {
    let urlString: String?
    let systemStyle: DealiImageSystemStyle
    var resizer: (((String?, CGSize)) -> URL?)?
    `
    public init(
        urlString: String? = nil,
        systemStyle: DealiImageSystemStyle,
        resizer: (((String?, CGSize)) -> URL?)?) {
            self.urlString = urlString
            self.systemStyle = systemStyle
            self.resizer = resizer
        }`

    // systemStyle을 기반으로 placeholder를 내부에서 구성
    var placeholder: some View {
        DealiImagePlaceholder(
            imageStyle: self.systemStyle.placeholderImageStyle,
            backgroundStyle: self.systemStyle.placeholderBackgroundStyle,
            shape: self.systemStyle.shape
        )
    }
    
    public var body: some View {
        DealiResizableRemoteImageView(
            urlString: self.urlString,
            resizer: self.resizer
        ) {
            self.placeholder
        }
        .clipShape(self.systemStyle.shape.shape())
        .overlay(
            self.systemStyle.shape.shape()
                .stroke(self.systemStyle.strokeColor, lineWidth: 1)
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        Text("Store Profile Style")
        DealiSystemImageView(
            urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D",
            systemStyle: .storeProfile,
            resizer: { urlString, _ in
                guard let urlString = urlString else { return nil }
                return URL(string: urlString)
            }
        )
        .frame(width: 100, height: 100)
        
        DealiSystemImageView(
            urlString: nil,
            systemStyle: .storeProfile,
            resizer: nil
        )
        .frame(width: 100, height: 100)
        
        Text("Product Thumbnail Style")
        DealiSystemImageView(
            urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D",
            systemStyle: .productThumbnail,
            resizer: { urlString, _ in
                guard let urlString = urlString else { return nil }
                return URL(string: urlString)
            }
        )
        .frame(width: 120, height: 160)
        
        DealiSystemImageView(
            urlString: nil,
            systemStyle: .productThumbnail,
            resizer: nil
        )
        .frame(width: 120, height: 160)
    }
}

public enum DealiImageSystemStyle {
    case storeProfile
    case productThumbnail

    var placeholderImageStyle: DealiPlaceholderImageStyle {
        switch self {
        case .storeProfile:
            return .store
        case .productThumbnail:
            return .goods
        }
    }
    
    /// 각 스타일에 맞는 플레이스홀더 배경 종류
    var placeholderBackgroundStyle: DealiPlaceholderBackgroundColor {
        switch self {
        case .storeProfile:
            return .dark
        case .productThumbnail:
            return .dark
        }
    }

    /// 각 스타일에 맞는 모양
    var shape: DealiPlaceholderViewShape {
        switch self {
        case .storeProfile:
            return .circle
        case .productThumbnail:
            return .rectangle(.allCorners)
        }
    }
    
    // 테두리 색상
    var strokeColor: Color {
        return Color(shape.borderColor)
    }
}

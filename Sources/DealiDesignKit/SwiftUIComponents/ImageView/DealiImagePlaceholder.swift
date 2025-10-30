//
//  DealiImagePlaceholder.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 10/30/25.
//

import SwiftUI

/**
 설명: 이미지 placeholder 
 */
public struct DealiImagePlaceholder: View {
    public let imageStyle: DealiPlaceholderImageStyle
    public let backgroundStyle: DealiPlaceholderBackgroundColor
    public let shape: DealiPlaceholderViewShape

    func iconView() -> Image {
        switch imageStyle {
        case .store:
            DealiIcon.ic_home_filled.swiftUIImage
        default:
            DealiIcon.ic_empty40.swiftUIImage
        }
    }

    public init(
        imageStyle: DealiPlaceholderImageStyle = .goods,
        backgroundStyle: DealiPlaceholderBackgroundColor = .dark,
        shape: DealiPlaceholderViewShape = .rectangle(.allCorners)
    ) {
        self.imageStyle = imageStyle
        self.backgroundStyle = backgroundStyle
        self.shape = shape
    }

    public var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let placeholderSize = calculateIconSize(for: size)
            ZStack {
                Color(backgroundStyle.backgroundColor)
                self.iconView()
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(backgroundStyle.imageColor))
                    .scaledToFit()
                    .frame(width: placeholderSize.width, height: placeholderSize.height)
            }
            .clipShape(shape.shape())
            .overlay(
                shape.shape()
                    .stroke(
                        Color(shape.borderColor),
                        lineWidth: shape.borderWidth
                    )
            )
        }
    }

    private func calculateIconSize(for parentSize: CGSize) -> CGSize {
        guard parentSize.width > 0, parentSize.height > 0 else { return .zero }
        
        let parentWidth = parentSize.width
        var placeholderWidth: CGFloat = 0.0
        var placeholderHeight: CGFloat = 0.0
        
        switch self.imageStyle {
        case .custom(let image) where image != nil:
            return parentSize
            
        default:
            let isOneToOne = abs(parentSize.width / parentSize.height - 1.0) < 0.01
            
            if isOneToOne {
                if parentWidth <= 70.0 {
                    placeholderWidth = parentWidth / 2.0
                } else {
                    placeholderWidth = parentWidth / 2.5
                }
                placeholderHeight = placeholderWidth
            } else {
                placeholderWidth = parentWidth / 2.5
                
                switch self.imageStyle {
                case .goods:
                    placeholderHeight = placeholderWidth * 4 / 3
                default:
                    placeholderHeight = placeholderWidth
                }
            }
        }
        
        return CGSize(width: placeholderWidth, height: placeholderHeight)
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ScrollView {
        VStack(alignment: .center) {
            Text("210*280")
            DealiImagePlaceholder(imageStyle: .goods, backgroundStyle: .dark, shape: .rectangle(.allCorners))
                .frame(width: 210, height: 280)

            Text("165*220")
            HStack {
                DealiImagePlaceholder(imageStyle: .goods, backgroundStyle: .dark, shape: .rectangle(.allCorners))
                    .frame(width: 165, height: 220)
                DealiImagePlaceholder(imageStyle: .goods, backgroundStyle: .light, shape: .rectangle(.allCorners))
                    .frame(width: 165, height: 220)
            
            }
            
            Text("108*144")
            DealiImagePlaceholder(imageStyle: .goods, backgroundStyle: .dark, shape: .rectangle(.allCorners))
                .frame(width: 108, height: 144)
            
            Text("108*108")
            DealiImagePlaceholder(imageStyle: .goods, backgroundStyle: .dark, shape: .rectangle(.allCorners))
                .frame(width: 108, height: 108)
          
            DealiImagePlaceholder(imageStyle: .store, backgroundStyle: .dark, shape: .circle)
                .frame(width: 90, height: 90)
        }
    }
}


#Preview("70미만 사이즈") {
    ScrollView {
        VStack(alignment: .center) {
            Text("68*68")
            DealiImagePlaceholder(imageStyle: .goods, backgroundStyle: .dark, shape: .rectangle(.allCorners))
                .frame(width: 68, height: 68)

            DealiImagePlaceholder(imageStyle: .store, backgroundStyle: .light, shape: .circle)
                .frame(width: 60, height: 60)
        }
    }
}

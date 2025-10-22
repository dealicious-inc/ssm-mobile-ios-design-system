
//
//  PlaceholderImageView.swift
//  DealiDesignKit
//
//  Created by yunjohyeon on 2025/10/22.
//

import SwiftUI
import UIKit

public struct PlaceholderImageView: View {
    @ObservedObject public var viewModel = PlaceholderImageViewModel()
    
    public init(viewModel: PlaceholderImageViewModel = .init()) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let image = self.viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    self.placeholderView(size: geometry.size)
                }
            }
            .background(self.viewModel.backgroundColor)
            .clipShape(shape(for: geometry.size))
            .overlay(
                shape(for: geometry.size)
                    .stroke(self.viewModel.borderColor,
                            lineWidth: self.viewModel.borderWidth)
            )
        }
    }
    
    @ViewBuilder
    private func placeholderView(size: CGSize) -> some View {
        let placeholderSize = self.calculatePlaceholderSize(for: size)
        
        ZStack {
            switch viewModel.imageStyle {
            case .custom(let customImage):
                if let customImage = customImage {
                    Image(uiImage: customImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(uiImage: placeholderIcon)
                        .resizable()
                        .scaledToFit()
                }
            default:
                Image(uiImage: placeholderIcon)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: placeholderSize.width, height: placeholderSize.height)
    }
    
    private var placeholderIcon: UIImage {
        let iconName: String
        switch self.viewModel.imageStyle {
        case .store:
            iconName = "ic_home_filled"
        default:
            iconName = "ic_empty40"
        }
        
        let iconColor: UIColor
        switch self.viewModel.backgroundStyle {
        case .dark:
            iconColor = .primary04
        default:
            iconColor = .g20
        }
        
        return UIImage.dealiIcon(named: iconName)?.withTintColor(iconColor) ?? UIImage()
    }
    
    private func calculatePlaceholderSize(for parentSize: CGSize) -> CGSize {
        guard parentSize.width > 0, parentSize.height > 0 else { return .zero }
        
        let parentWidth = parentSize.width
        var placeholderWidth: CGFloat = 0.0
        var placeholderHeight: CGFloat = 0.0
        
        switch self.viewModel.imageStyle {
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
                placeholderWidth = parentWidth / 4.0
                
                switch self.viewModel.imageStyle {
                case .goods:
                    placeholderHeight = placeholderWidth * 4 / 3
                default:
                    placeholderHeight = placeholderWidth
                }
            }
        }
        
        return CGSize(width: placeholderWidth, height: placeholderHeight)
    }
    
    private func shape(for size: CGSize) -> some Shape {
        let radius = self.viewModel.viewShape.getRadius(for: size.height)
        let corners: UIRectCorner
        
        switch self.viewModel.viewShape {
        case .rectangle(let rectCorners):
            corners = rectCorners
        case .circle:
            corners = .allCorners
        }
        
        return RoundedCorner(radius: radius, corners: corners)
    }
}

public class PlaceholderImageViewModel: ObservableObject {
    @Published public var image: UIImage?
    @Published public var imageStyle: DealiPlaceholderImageStyle
    @Published public var backgroundStyle: DealiPlaceholderBackgroundColor
    @Published public var viewShape: DealiPlaceholderViewShape
    
    var borderColor: Color {
        return Color(self.viewShape.borderColor)
    }
    
    var borderWidth: CGFloat {
        switch self.imageStyle {
        case .custom:
            return 0
        default:
            return self.viewShape.borderWidth
        }
    }
    
    var backgroundColor: Color {
        switch self.imageStyle {
        case .custom:
            return Color(UIColor.g10)
        default:
            return Color(self.backgroundStyle.backgroundColor)
        }
    }
    
    public init(
        image: UIImage? = nil,
        imageStyle: DealiPlaceholderImageStyle = .goods,
        backgroundStyle: DealiPlaceholderBackgroundColor = .light,
        viewShape: DealiPlaceholderViewShape = .rectangle(.allCorners)
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.backgroundStyle = backgroundStyle
        self.viewShape = viewShape
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct PlaceholderImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                PlaceholderImageView(viewModel: PlaceholderImageViewModel(imageStyle: .goods, backgroundStyle: .light, viewShape: .rectangle(.allCorners)))
                    .frame(width: 100, height: 100)
                
                PlaceholderImageView(viewModel: PlaceholderImageViewModel(imageStyle: .store, backgroundStyle: .dark, viewShape: .circle))
                    .frame(width: 100, height: 100)
                
                PlaceholderImageView(viewModel: PlaceholderImageViewModel(imageStyle: .custom(UIImage.dealiIcon(named: "ic_refresh")), backgroundStyle: .light, viewShape: .rectangle([.topLeft, .bottomRight])))
                    .frame(width: 100, height: 100)
            }
            
            PlaceholderImageView(viewModel: PlaceholderImageViewModel(image: UIImage(named: "IMG_4640"), imageStyle: .goods, backgroundStyle: .light, viewShape: .rectangle(.allCorners)))
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

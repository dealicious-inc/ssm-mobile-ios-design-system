//
//  TagView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 5/30/25.
//

import SwiftUI

public struct TagView: View {
    private let text: String
    private let type: DealiTag.EType
    private let leftIcon: Image?
    private let rightIcon: Image?
    /// 아이콘 이미지와 컨테이너 사이 여백. 기본값 0이면 아이콘이 컨테이너를 꽉 채운다.
    private let iconImageInset: CGFloat

    public init(
        text: String,
        type: DealiTag.EType,
        leftIcon: Image? = nil,
        rightIcon: Image? = nil,
        iconImageInset: CGFloat = 0.0
    ) {
        self.text = text
        self.type = type
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.iconImageInset = iconImageInset
    }
    
    private var category: DealiTag.ESize {
        type.layoutSizeCategory
    }
    
    private var showLeftIcon: Bool {
        leftIcon != nil
    }
    
    private var showRightIcon: Bool {
        rightIcon != nil
    }
    
    public var body: some View {
        let size = type.size
        let iconDimension = category.iconDimension
        let gap = category.iconTextSpacing
        let inset = self.iconImageInset
        let leftPadding = max(0, size.padding - (showLeftIcon ? gap : 0))
        let rightPadding = max(0, size.padding - (showRightIcon ? gap : 0))
        
        HStack(spacing: gap) {
            if showLeftIcon {
                iconView(
                    icon: leftIcon,
                    iconDimension: iconDimension,
                    inset: inset
                )
            }
            Text(text)
                .font(Font(type.font))
                .frame(height: type.size.height)
                .foregroundColor(Color(type.color.textColor))
            if showRightIcon {
                iconView(
                    icon: rightIcon,
                    iconDimension: iconDimension,
                    inset: inset
                )
            }
        }
        .padding(.leading, leftPadding)
        .padding(.trailing, rightPadding)
        .background(Color(type.color.backgroundColor))
        .cornerRadius(size.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .stroke(
                    Color(type.color.borderColor ?? .clear),
                    lineWidth: 1.0
                )
        )
    }
    
    @ViewBuilder
    private func iconView(
        icon: Image?,
        iconDimension: CGFloat,
        inset: CGFloat
    ) -> some View {
        ZStack {
            if let icon {
                icon
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color(type.color.textColor))
                    .padding(inset)
                    .frame(width: iconDimension, height: iconDimension)
            }
        }
        .frame(width: iconDimension, height: iconDimension)
    }
}

#Preview {
    VStack(spacing: 12) {
        TagView(text: "Test", type: .tagOutlineLarge01)
        TagView(text: "Test", type: .tagOutlineLarge04)
        TagView(
            text: "아이콘 슬롯",
            type: .tagFilledLarge01,
            leftIcon: Image.dealiIcon(named: "ic_check_s"),
            rightIcon: Image.dealiIcon(named: "ic_x_s")
        )
    }
}

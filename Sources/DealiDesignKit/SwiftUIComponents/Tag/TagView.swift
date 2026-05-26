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
    private let icon: Image?
    private let leftIcon: Image?
    private let rightIcon: Image?

    public init(
        text: String,
        type: DealiTag.EType,
        leftIcon: Image? = nil,
        rightIcon: Image? = nil
    ) {
        self.text = text
        self.type = type
        self.icon = nil
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
    }

    public init(
        icon: Image,
        type: DealiTag.EType
    ) {
        self.text = ""
        self.type = type
        self.icon = icon
        self.leftIcon = nil
        self.rightIcon = nil
    }

    private var category: DealiTag.ESize {
        type.layoutSizeCategory
    }

    private var showLeftIcon: Bool {
        icon == nil && leftIcon != nil
    }

    private var showRightIcon: Bool {
        icon == nil && rightIcon != nil
    }

    private var showIcon: Bool {
        icon != nil
    }

    public var body: some View {
        let size = type.size
        let iconDimension = category.iconDimension
        let gap = category.iconTextSpacing
        let inset = category.iconImageInset
        let leftPadding = max(0, size.padding - (showLeftIcon ? gap : 0))
        let rightPadding = max(0, size.padding - (showRightIcon ? gap : 0))

        Group {
            if showIcon {
                iconOnlyView(
                    icon: icon,
                    iconDimension: iconDimension,
                    padding: category.iconOnlyPadding
                )
            } else {
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
            }
        }
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

    @ViewBuilder
    private func iconOnlyView(
        icon: Image?,
        iconDimension: CGFloat,
        padding: CGFloat
    ) -> some View {
        if let icon {
            icon
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color(type.color.textColor))
                .frame(width: iconDimension, height: iconDimension)
                .padding(padding)
        }
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
        TagView(
            icon: Image.dealiIcon(named: "ic_check_s"),
            type: .tagFilledSmall01
        )
    }
}

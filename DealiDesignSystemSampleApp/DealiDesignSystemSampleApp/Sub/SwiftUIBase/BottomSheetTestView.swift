//
//  BottomSheetTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by jalynneyoon on 7/28/26.
//  Copyright © 2026 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct BottomSheetTestView: View {

    private struct Sample: Identifiable {
        let id = UUID()
        /// 버튼 개수 / 용도 / 배치 이름
        let layoutName: String
        /// 바텀시트 타이틀에 노출할 전체 조합 이름
        let fullName: String
        let buttonType: EBottomSheetButtonType
    }

    private struct UsageGroup: Identifiable {
        let id = UUID()
        let name: String
        let samples: [Sample]
    }

    @StateObject private var sheetState = DealiSheetState()
    @State private var selectedSample: Sample?

    private let usageGroups: [UsageGroup] = {
        let usages: [(name: String, usage: EBottomSheetButtonUsage)] = [
            ("Default", .default),
            ("도매 멤버십", .wholesaleMembership),
            ("소매 멤버십1", .retailMembership01),
            ("소매 멤버십2", .retailMembership02),
            ("커스텀 조합", EBottomSheetButtonUsage(confirmButtonStyle: .btnFilledLarge06, optionButtonStyle: .btnOutlineLarge04))
        ]

        let layouts: [(name: String, makeButtonType: (EBottomSheetButtonUsage) -> EBottomSheetButtonType)] = [
            ("1btn", { .oneButton(buttonTitle: "Button", usage: $0) }),
            ("option 좌우", { .twoButton(confirmTitle: "Option Button", cancelTitle: "Option Button", cancelButtonType: .option, usage: $0, axis: .horizontal) }),
            ("option 상하", { .twoButton(confirmTitle: "Option Button", cancelTitle: "Option Button", cancelButtonType: .option, usage: $0, axis: .vertical) }),
            ("cancel 좌우", { .twoButton(confirmTitle: "Confirm Button", cancelTitle: "Cancel Button", cancelButtonType: .cancel, usage: $0, axis: .horizontal) }),
            ("cancel 상하", { .twoButton(confirmTitle: "Confirm Button", cancelTitle: "Cancel Button", cancelButtonType: .cancel, usage: $0, axis: .vertical) })
        ]

        return usages.map { usageSample in
            UsageGroup(
                name: usageSample.name,
                samples: layouts.map { layoutSample in
                    Sample(layoutName: layoutSample.name,
                           fullName: "\(usageSample.name) / \(layoutSample.name)",
                           buttonType: layoutSample.makeButtonType(usageSample.usage))
                }
            )
        }
    }()

    private let gridColumns = [GridItem(.flexible(), spacing: 8.0), GridItem(.flexible(), spacing: 8.0)]

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 28.0) {
                    ForEach(usageGroups) { group in
                        usageGroupView(group)
                    }
                }
                .padding(.horizontal, 16.0)
                .padding(.vertical, 24.0)
            }
            .background(Color.primary04)

            sheetView
        }
        .navigationBarTitle("BottomSheet", displayMode: .inline)
    }
}

private extension BottomSheetTestView {
    private func usageGroupView(_ group: UsageGroup) -> some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text(group.name)
                .font(.b1sb15)
                .foregroundStyle(Color.g100)

            Rectangle()
                .fill(Color.g20)
                .frame(height: 1.0)

            LazyVGrid(columns: gridColumns, spacing: 8.0) {
                ForEach(group.samples) { sample in
                    ButtonView(
                        viewModel: .init(type: .btnOutlineBgSemiMedium01, title: sample.layoutName),
                        action: { present(sample) }
                    )
                }
            }
        }
    }

    var sheetView: some View {
        DealiSheetView(
            title: selectedSample?.fullName,
            showCloseButton: true,
            fixedHeight: 320.0,
            buttonType: selectedSample?.buttonType ?? .hidden,
            onConfirm: { print("confirm 클릭") },
            onCancel: { print("cancel 클릭") }
        ) {
            Text("하단 버튼의 사용처 / 용도 / 배치 조합 확인용 바텀시트입니다.")
                .font(.b2r14)
                .foregroundStyle(Color.g80)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 16.0)
        }
        .environmentObject(sheetState)
    }

    private func present(_ sample: Sample) {
        selectedSample = sample
        sheetState.isPresented = true
    }
}

#Preview {
    NavigationView {
        BottomSheetTestView()
    }
}

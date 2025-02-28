//
//  GoodsThumnailTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/28/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI

struct GoodsThumnailTestView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    final class ViewModel: ObservableObject {
        @Published var goodsName: String = ""
        @Published var zzimCount: Int = 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let image = UIImage.dealiIcon(named: "ic_empty40")?.withTintColor(.g20) {
                Image(uiImage: image)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.gray)
                    )
            } else {
                // placeholder
                EmptyView()
            }
            
            Text("건물명 / 스토어명")
                .font(Font(UIFont.b4r12))
                .background(Color.red)
                .padding(.leading, 4)
            
            Text(viewModel.goodsName).background(Color.yellow)
                .font(Font(UIFont.b4r12))
                .padding(.leading, 4)
            
            Text("₩3,000").background(Color.green)
                .font(Font(UIFont.b4sb12))
                .padding(.leading, 4)
            
            HStack(spacing: 4) {
                let starImage = UIImage.dealiIcon(named: "ic_star_filled")!.withTintColor(UIColor.g40).resize(CGSize(width: 16, height: 16))
                Image(uiImage: starImage)
                Text(String(viewModel.zzimCount))
                    .font(Font(UIFont.b4r12))
                    .background(Color.orange)
                
                Spacer()
            }
        }
    }
    
    @discardableResult
    func setGoodsInfo(_ goodsName: String, zzimCount: Int) -> Self {
        viewModel.goodsName = goodsName
        viewModel.zzimCount = zzimCount
        return self
    }
    
    public init() {
        self.viewModel = ViewModel()
    }
}

#Preview {
    GoodsThumnailTestView()
}

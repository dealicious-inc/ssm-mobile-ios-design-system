//
//  BottomSheetTitleView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/27/25.
//

import SwiftUI

struct BottomSheetTitleView: View {
    @State private var text: String?
    @State private var isDismissButtonHidden: Bool
    var onDismiss: (() -> Void)?
    
    init(text: String?,
         isDismissButtonHidden: Bool,
         onDismiss: (() -> Void)? = nil
    ) {
        self.text = text
        self.isDismissButtonHidden = isDismissButtonHidden
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        HStack {
            if let text = self.text {
                Text(text)
                    .font(Font(UIFont.sh2sb18))
                    .foregroundStyle(Color(.g100))
            }
            
            Spacer()
            
            if !isDismissButtonHidden {
                Button {
                    self.onDismiss?()
                } label: {
                    Image.dealiIcon(named: "ic_x")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                }
            }
        }
    }
}

#Preview {
    BottomSheetTitleView(text: "Title", isDismissButtonHidden: false) {
        
    }
}

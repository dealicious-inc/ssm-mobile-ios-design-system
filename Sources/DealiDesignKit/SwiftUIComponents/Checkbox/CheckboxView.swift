//
//  CheckboxView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 2/27/25.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool
    @State private var status = CheckboxStatus(isEnable: true, isSelected: false)
    
    var label: String = "Text"
    
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
            self.status.changeStatus()
            
        }) {
            HStack(spacing: 8.0) {
                Image(self.status.imageName)
                    .resizable()
                    .frame(width: 24.0, height: 24.0)
                
                Text(label)
                    .font(Font(UIFont.b2r14))
                    .foregroundStyle(Color(self.status.textColor))
            }
        }
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxView(isChecked: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}

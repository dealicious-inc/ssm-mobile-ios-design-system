//
//  NoticeView.swift
//  DealiDesignKit
//
//  Created by 이남준 on 3/10/25.
//

import SwiftUI

struct NoticeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage: .dealiIcon(named: "ic_notice")!)
                    .resizable()
                    .frame(width: 16.0, height: 16.0)
                
                Text("Hello World")
                    .font(Font(UIFont.b2sb14 as CTFont))
                
                Spacer()
            }
                
        }
        .padding(16.0)
        .background(Color(.g10))
        .cornerRadius(10.0)
    }
}

#Preview {
    NoticeView()
}

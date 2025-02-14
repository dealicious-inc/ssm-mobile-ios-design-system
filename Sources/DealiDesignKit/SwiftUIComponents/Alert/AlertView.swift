//
//  AlertView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/14/25.
//

import SwiftUI

public struct AlertView: View {
    public var body: some View {
        VStack(spacing: 20) {
            Text("Alert 1")
                .font(.headline)
                .padding()
            
            Button("Alert 1") {
                print("Alert 1")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Text("Alert 2")
                .font(.headline)
                .padding()
            
            Button("Alert 2") {
                print("Alert 2")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .navigationBarTitle("Alert", displayMode: .inline)
        
        
    }
    
    public init() {}
}

#Preview {
    AlertView()
}


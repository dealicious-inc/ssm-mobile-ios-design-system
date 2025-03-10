//
//  TooltipView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 3/10/25.
//

import SwiftUI

public struct TooltipView: View {
    public var label: String
    public var tailPosition: ETooltipTailPosition = .bottomCenter
    
    public var body: some View {
        Text(self.label)
            .font(Font(UIFont.b3sb13))
            .foregroundColor(Color(uiColor: .primary04))
            .padding(.vertical, 12.0)
            .padding(.horizontal, 16.0)
            .background(Color(uiColor: .secondary01))
            .clipShape(RoundedRectangle(cornerRadius: 6.0))
       
    }
}

public enum ETooltipTailPosition {
    case bottomCenter
    case bottomLeft
    case bottomRight
    case topCenter
    case topLeft
    case topRight
}

struct TooltipView_Previews: PreviewProvider {
    static var previews: some View {
        TooltipView(label: "신상마켓")
    }
}

//
//  SwiftUIBaseView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/14/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit//.UIView
import SwiftUI
import RxSwift

import DealiDesignKit

struct SwiftUIBaseView: View {
    let components: [Component] = [Component(title: "Alert", linkView: AlertTestView())]
    
    
    var body: some View {
        if #available(iOS 16.0, *) {
                List(components) { component in
                    NavigationLink(component.title) {
                        component.linkView
                    }
                }
                .navigationBarTitle("SwiftUI Base Components", displayMode: .inline)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    SwiftUIBaseView()
}

struct ComponentView: View {
    let component: Component
    
    var body: some View {
        Text(component.title)
    }
}

struct Component: Identifiable {
    let id = UUID()
    let title: String
    let linkView: AnyView
    
    init<V: View>(title: String, linkView: V) {
        self.title = title
        self.linkView = AnyView(linkView)
    }
}

private class RepresentableBundle {}

public extension View {
    ///SwiftUI View를 UIKit View로 변환합니다.
    func UIKit() -> UIView {
        let view: UIView = UIHostingController(rootView: self).view
        view.backgroundColor = .clear
        return view
    }
}

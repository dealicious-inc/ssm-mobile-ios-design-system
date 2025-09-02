//
//  GradientColorItemView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 12/30/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import SwiftUI


final class GradientColorItemView: UIView {
    
    let textLabel = UILabel()
    let gradient: GradientConfigurable
    
    init(gradient: GradientConfigurable, name: String) {
        self.gradient = gradient
        self.textLabel.text = name
     
        super.init(frame: .zero)
    
        self.addSubview(textLabel)
        textLabel.then {
            $0.textColor = .primary04
            $0.font = .b1sb15
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func draw(_ rect: CGRect) {
        self.setSystemGradient(gradient)
    }
}

struct RepresentedGradientColorItemView: UIViewRepresentable {
    typealias UIViewType = GradientColorItemView
    var gradientData: GradientColorData

    func makeUIView(context: Context) -> GradientColorItemView {
        let view = GradientColorItemView(
            gradient: gradientData.gradient,
            name: gradientData.name
        )
        return view
    }
    
    func updateUIView(_ uiView: GradientColorItemView, context: Context) {
    }
}

struct GradientColorData {
    var name: String
    var gradient: any GradientConfigurable
    
    init(name: String, gradient: any GradientConfigurable) {
        self.name = name
        self.gradient = gradient
    }
    
}

#Preview {
    RepresentedGradientColorItemView(
        gradientData: GradientColorData(
            name: "mbs gradient01",
            gradient: MbsGradient.gradient01
        )
    )
}

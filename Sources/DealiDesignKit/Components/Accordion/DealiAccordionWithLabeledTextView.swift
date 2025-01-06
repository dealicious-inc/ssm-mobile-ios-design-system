//
//  DealiAccordionWithLabeledTextView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 1/2/25.
//

import UIKit

final public class DealiAccordionWithLabeledTextView: DealiAccordionView {
    
    /// accordion View에 들어가는 LabeledText Model array 항목
    public var accordionLabeledTextModelArray: [DealiAccordionLabeledTextModel] = [] {
        didSet {
            var itemViewArray: [UIView] = []
            
            for (_, model) in self.accordionLabeledTextModelArray.enumerated() {
                let labeledTextGroupView = DealiLabeledTextGroupView(preset: model.preset)
                labeledTextGroupView.do {
                    $0.title = model.title
                    $0.titleImageName = model.titleImageName
                    $0.configure(modelArray: model.modelArray)
                }
                itemViewArray.append(labeledTextGroupView)
            }
            
            self.accordionItemViewArray = itemViewArray
        }
    }
}

public struct DealiAccordionLabeledTextModel {
    var preset: DealiLabeledTextPreset = .labeledTextBullet01
    var modelArray: [DealiLabeledTextModel] = []
    var title: String?
    var titleImageName: String?
    
    public init(preset: DealiLabeledTextPreset, modelArray: [DealiLabeledTextModel], title: String? = nil, titleImageName: String? = nil) {
        self.preset = preset
        self.modelArray = modelArray
        self.title = title
        self.titleImageName = titleImageName
    }
}

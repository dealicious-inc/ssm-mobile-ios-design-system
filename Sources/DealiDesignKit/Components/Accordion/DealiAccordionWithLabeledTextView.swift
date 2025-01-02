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
                let labeledTextGroupView = DealiLabeledTextGroupView(preset: model.labeledPreset)
                labeledTextGroupView.do {
                    $0.title = model.labeledTitle
                    $0.titleImageName = model.labeledTitleImageName
                    $0.configure(modelArray: model.labeledModelArray)
                }
                itemViewArray.append(labeledTextGroupView)
            }
            
            self.accordionItemViewArray = itemViewArray
        }
    }
}

public struct DealiAccordionLabeledTextModel {
    var labeledPreset: DealiLabeledTextPreset = .labeledTextBullet01
    var labeledModelArray: [DealiLabeledTextModel] = []
    var labeledTitle: String?
    var labeledTitleImageName: String?
    
    public init(labeledPreset: DealiLabeledTextPreset, labeledModelArray: [DealiLabeledTextModel], labeledTitle: String? = nil, labeledTitleImageName: String? = nil) {
        self.labeledPreset = labeledPreset
        self.labeledModelArray = labeledModelArray
        self.labeledTitle = labeledTitle
        self.labeledTitleImageName = labeledTitleImageName
    }
}

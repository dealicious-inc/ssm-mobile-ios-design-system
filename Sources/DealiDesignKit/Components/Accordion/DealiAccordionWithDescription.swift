//
//  DealiAccordionWithDescription.swift
//  
//
//  Created by 이창호 on 10/21/24.
//

import UIKit

final public class DealiAccordionWithDescription: DealiAccordion {

    public var descriptionModelArray: [DealiDescriptionItemModel] = [] {
        didSet {
            var descriptionItemViewArray: [DealiDescriptionItem] = []
            for descriptionModel in self.descriptionModelArray {
                let descriptionItemView = DealiDescriptionItem()
                descriptionItemView.do {
                    $0.configure(model: descriptionModel)
                }
                descriptionItemViewArray.append(descriptionItemView)
            }
            
            self.accordionItemViewArray = descriptionItemViewArray
        }
    }
    
    override public init() {
        super.init()
        
        self.accordionItemSpacing = 8.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

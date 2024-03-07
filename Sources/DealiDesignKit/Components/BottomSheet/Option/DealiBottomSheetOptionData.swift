//
//  DealiBottomSheetOptionData.swift
//
//
//  Created by JohyeonYoon on 3/7/24.
//

import Foundation

public struct DealiBottomSheetOptionData {
    var optionName: String?
    var isSelected: Bool = false
    var contentText: String?
    var imageName: String?
    
    public init(optionName: String?, isSelected: Bool = false) {
        self.optionName = optionName
        self.isSelected = isSelected
    }
    
    public init(optionName: String?, isSelected: Bool = false, imageName: String?) {
        self.optionName = optionName
        self.isSelected = isSelected
        self.imageName = imageName
    }
}

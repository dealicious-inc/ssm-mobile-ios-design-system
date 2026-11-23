//
//  DealiBottomSheetOptionData.swift
//
//
//  Created by JohyeonYoon on 3/7/24.
//

import Foundation

public struct DealiBottomSheetOptionData {
    public var isSelected: Bool = false
    public var optionName: String?
    var contentText: String?
    var imageName: String?
    /// E2E 테스트 식별자. 항목마다 역할이 다르면 전체 문자열을 넣는다. nil이면 시트 루트로 `<루트>__item`을 붙인다
    public var testIdentifier: String?
    
    public init(optionName: String?, isSelected: Bool = false, testIdentifier: String? = nil) {
        self.optionName = optionName
        self.isSelected = isSelected
        self.testIdentifier = testIdentifier
    }
    
    public init(optionName: String?, isSelected: Bool = false, imageName: String?, testIdentifier: String? = nil) {
        self.optionName = optionName
        self.isSelected = isSelected
        self.imageName = imageName
        self.testIdentifier = testIdentifier
    }
}

//
//  DealiControl+DepthChip.swift
//  DealiDesignKit
//
//  Created by 이창호 on 10/15/26.
//

import UIKit

public extension DealiControl {
    static func chipFilledDepthLarge01() -> DealiDepthChip {
        return DealiDepthChip(configuration: DepthChipConfig(size: .large))
    }

    static func chipFilledDepthMedium01() -> DealiDepthChip {
        return DealiDepthChip(configuration: DepthChipConfig(size: .medium))
    }

    static func chipFilledDepthSmall01() -> DealiDepthChip {
        return DealiDepthChip(configuration: DepthChipConfig(size: .small))
    }
}

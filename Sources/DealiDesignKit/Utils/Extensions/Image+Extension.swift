//
//  Image+Extension.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 3/12/25.
//

import SwiftUI

public extension Image {
    
    static func dealiIcon(named: String) -> Image {
        return Image(named, bundle: .module)
    }
}

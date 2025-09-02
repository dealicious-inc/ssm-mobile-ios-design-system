//
//  File.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 5/26/25.
//

import SwiftUI

protocol FontProviding {
    func bolder() -> Self
    func thinner() -> Self
}

extension Font: FontProviding {
    func bolder() -> Self {
        return self.weight(.semibold)
    }
    
    func thinner() -> Self {
        return self.weight(.regular)
    }
}

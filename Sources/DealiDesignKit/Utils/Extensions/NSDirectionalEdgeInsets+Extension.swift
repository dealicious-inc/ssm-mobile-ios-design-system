//
//  NSDirectionalEdgeInsets+Extension.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 12/13/24.
//

import UIKit

extension NSDirectionalEdgeInsets {
    func toUIEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: self.top, left: self.leading, bottom: self.bottom, right: self.trailing)
    }
}

//
//  FontProvider.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//

import UIKit

protocol FontProvider {
    var systemFont: UIFont { get }
    func makeBolder() -> UIFont
}

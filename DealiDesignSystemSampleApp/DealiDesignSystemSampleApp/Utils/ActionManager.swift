//
//  ActionManager.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/10/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import Foundation

typealias ActionClosure = () -> Void

final class ActionManager: Sendable {
    
    static let shared = ActionManager()
    private init() { }
    
    func performAction<Item: Hashable>(for item: Item, action: @escaping ActionClosure) {
        action()
    }
    
}

//
//  ComponentConfig.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/22/25.
//

import Foundation

protocol ComponentVariant: Hashable, CaseIterable { }
protocol ComponentSize: Hashable, CaseIterable { }
protocol ComponentState: Hashable, CaseIterable { }

protocol ComponentStyleKey: Hashable { }
protocol ComponentStyle { }

protocol ComponentStyleProvider {
    associatedtype Key: Hashable
    associatedtype Style
    
    func style(for key: Key) -> Style
}

struct ComponentConfig<V: ComponentVariant, S: ComponentSize, T: ComponentState> {
    let variant: V
    let size: S
    let state: T
    
    let styleProvider: any ComponentStyleProvider
}

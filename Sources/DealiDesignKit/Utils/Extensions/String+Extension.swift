//
//  File.swift
//
//
//  Created by 윤조현 on 2023/11/13.
//

import Foundation

public extension String {
    func index(from: Int) -> Index {
        guard self.count > from else { return self.index(startIndex, offsetBy: 0) }
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        let substring = String(self[fromIndex...])
        return substring
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        let newStr = String(self[..<toIndex])
        return newStr
    }
}

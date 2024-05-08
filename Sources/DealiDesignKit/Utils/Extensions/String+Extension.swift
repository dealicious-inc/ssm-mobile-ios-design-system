//
//  File.swift
//  
//
//  Created by 조서현 on 12/14/23.
//
import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func trimming() -> String {
        return self.components(separatedBy: [" "]).joined().trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

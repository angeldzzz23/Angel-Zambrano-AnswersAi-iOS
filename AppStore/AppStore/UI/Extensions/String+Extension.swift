//
//  String+Extension.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import Foundation

extension String {
    
    func boolValue() -> Bool? {
        switch lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    var uppercasedFirstLetter: String {
        guard !self.isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
    
}


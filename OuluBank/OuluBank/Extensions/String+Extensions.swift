//
//  String+Extensions.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/3/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isSSN: Bool {
        let ssnPattern = #"^(?!000|666|9\d{2})[0-8]\d{2}-(?!00)\d{2}-(?!0000)\d{4}$"#
        
        let regex = try? NSRegularExpression(pattern: ssnPattern)
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex?.firstMatch(in: self, options: [], range: range) != nil
    }
}



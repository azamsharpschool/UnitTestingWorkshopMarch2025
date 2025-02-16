//
//  StringExtensionsTests.swift
//  OuluBankTests
//
//  Created by Mohammad Azam on 2/3/25.
//

import Testing
@testable import OuluBank

struct StringExtensionsTests {

    @Test func isSSNWithValidSSNReturnsTrue() {
        
        let validSSNs: [String] = [
            "123-45-6789",
            "123-65-4321",
            "234-56-7890",
            "678-90-1234",
            "321-54-9876"
        ]
        
        for ssn in validSSNs {
            #expect(ssn.isSSN)
        }

    }
    
    @Test func isSSNWithInvalidSSNReturnsFalse() {
        
        let invalidSSNs: [String] = [
            "123456789",       // Missing dashes
            "123-45-678",      // Too short
            "123-45-67890",    // Too long
            "000-12-3456",     // Invalid prefix (000)
            "666-12-3456",     // Invalid prefix (666)
            "900-12-3456",     // Invalid prefix (900-999)
            "123-00-6789",     // Invalid middle digits (00)
            "123-45-0000",     // Invalid last four digits (0000)
            "12-345-6789",     // Incorrect format
            "123-4a-6789",     // Contains letters
            "123 - 45 - 6789"  // Spaces between numbers
        ]
        
        for ssn in invalidSSNs {
            #expect(!ssn.isSSN)
        }

    }

}

//
//  APRServiceTests.swift
//  OuluBankR1Tests
//
//  Created by Mohammad Azam on 2/15/25.
//

import Testing
@testable import OuluBankR1

struct APRServiceTests {
    
    // Credit score > 650 is considered high credit score
    @Test func getAPR_ReturnsAPRForHighCreditScore_WhenSSNIsValid() async throws {
        
        let validSSN = "123-45-6789"
        let expectedAPRRange = 1.0...3.0 // Use Double for APR range
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        do {
            let apr = try await aprService.getAPR(ssn: validSSN)
            #expect(expectedAPRRange.contains(apr), "APR should be within the range \(expectedAPRRange)")
        } catch {
            #expect(Bool(false))
        }
    }
    
    // Credit score < 650 is considered low credit score
    @Test func getAPR_ReturnsAPRForLowCreditScore_WhenSSNIsValid() async throws {
        
        let validSSN = "888-65-4321"
        let expectedAPRRange = 6.0...10.0 // Use Double for APR range
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        do {
            let apr = try await aprService.getAPR(ssn: validSSN)
            #expect(expectedAPRRange.contains(apr), "APR should be within the range \(expectedAPRRange)")
        } catch {
            #expect(Bool(false))
        }
    }
    
    // Credit score does not exist
    @Test func getAPR_ThrowsErrorWhenCreditScoreDoesNotExist_AndWhenSSNIsValid() async throws {
        
        let validSSN = "287-65-4321" // valid SSN
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        
        await #expect("Error not thrown even though credit score does not exist.", performing: {
            try await aprService.getAPR(ssn: validSSN)
        }, throws: { error in
            
            if case .noCreditScoreFound = error as? CreditScoreServiceError {
                return true
            }
            
            return false
            
        })
    }
    
    
    // Credit score is undefined
    @Test func getAPR_ThrowsErrorWhenCreditScoreIsUndefined_AndWhenSSNIsValid() async throws {
        
        let validSSN = "111-11-1111" // valid SSN
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        
        await #expect("Error not thrown even though credit score does not exist.", performing: {
            try await aprService.getAPR(ssn: validSSN)
        }, throws: { error in
            
            if case .noCreditScoreFound = error as? CreditScoreServiceError {
                return true
            }
            
            return false
            
        })
    }
    
}

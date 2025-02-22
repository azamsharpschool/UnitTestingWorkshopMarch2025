//
//  APRServiceTests.swift
//  OuluBankR1Tests
//
//  Created by Mohammad Azam on 2/15/25.
//

import Testing
@testable import OuluBankR1

struct APRServiceTests {
    
    @Test(arguments: [("123-45-6789", 1.0...3.0), ("888-65-4321", 6.0...10.0)])
    func apr_is_within_expected_range_for_valid_ssn(params: (String, ClosedRange<Double>)) async {
        
        let (ssn, expectedAPRRange) = params
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        guard let apr = try? await aprService.getAPR(ssn: ssn) else {
            Issue.record("apr Service did not return apr")
            return
        }
        
        #expect(expectedAPRRange.contains(apr), "APR should be within the range \(expectedAPRRange)")
        
    }
    
    @Test(arguments: ["111-11-1111"])
    func apr_calculation_fails_for_ssn_with_no_credit_score(ssn: String) async {
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        
        await #expect("Error not thrown even though credit score does not exist.", performing: {
            try await aprService.getAPR(ssn: ssn)
        }, throws: { error in
            
            if case .noCreditScoreFound = error as? CreditScoreServiceError {
                return true
            }
            
            return false
        })
    }
    
    
    /*
    // Credit score > 650 is considered high credit score
    @Test
    func apr_is_calculated_for_high_credit_score() async throws {
        
        let validSSN = "123-45-6789"
        let expectedAPRRange = 1.0...3.0 // Use Double for APR range
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
        
        guard let apr = try? await aprService.getAPR(ssn: validSSN) else {
            Issue.record("apr Service did not return apr")
            return
        }
        #expect(expectedAPRRange.contains(apr), "APR should be within the range \(expectedAPRRange)")
       
    }
    
    // Credit score < 650 is considered low credit score
    @Test
    func apr_is_calculated_for_low_credit_score() async throws {
        
        let validSSN = "888-65-4321"
        let expectedAPRRange = 6.0...10.0 // Use Double for APR range
        
        let aprService = APRService(creditScoreService: MockCreditScoreService())
       
        guard let apr = try? await aprService.getAPR(ssn: validSSN) else {
            Issue.record("apr Service did not return apr")
            return
        }
        #expect(expectedAPRRange.contains(apr), "APR should be within the range \(expectedAPRRange)")
     
    }
    
    // Credit score does not exist
    @Test
    func getAPR_ThrowsErrorWhenCreditScoreDoesNotExist_AndWhenSSNIsValid() async throws {
        
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
    } */
    
    
    // Credit score is undefined
    /*
    @Test
    func getAPR_ThrowsErrorWhenCreditScoreIsUndefined_AndWhenSSNIsValid() async throws {
        
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
    } */
    
}

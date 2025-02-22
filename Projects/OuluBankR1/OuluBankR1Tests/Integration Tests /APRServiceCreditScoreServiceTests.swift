//
//  APRServiceCreditScoreServiceTests.swift
//  OuluBankR1Tests
//
//  Created by Mohammad Azam on 2/15/25.
//

import Testing
@testable import OuluBankR1

struct APRServiceCreditScoreServiceTests {

    @Test func apr_service_calls_get_credit_score_on_credit_score_service() async throws {
        
        let validSSN = "123-45-6789"
        
        var mockCreditScoreService = MockCreditScoreService()
        
        try await confirmation("APRService did not call GetCreditScore on CreditScoreService", expectedCount: 1) { confirmation in
            
            mockCreditScoreService.onGetCreditScore = { ssn in
                confirmation()
                return CreditScore(score: 500, lastUpdated: "02/02/2025", reportedBy: "Experian")
            }
            
            let aprService = APRService(creditScoreService: mockCreditScoreService)
            let _ = try await aprService.getAPR(ssn: validSSN)
        
        }   
    }
    
    @Test(arguments: ["", "abc-sd-sscx"])
    func apr_service_does_not_call_get_credit_score_with_invalid_ssn(invalidSSN: String) async throws {
        
        var mockCreditScoreService = MockCreditScoreService()
        
        await confirmation("APRService called CreditCardService even with invalid SSN.", expectedCount: 0) { confirmation in
            
            mockCreditScoreService.onGetCreditScore = { ssn in
                confirmation()
                return CreditScore(score: 500, lastUpdated: "02/02/2025", reportedBy: "Experian")
            }
            
            let aprService = APRService(creditScoreService: mockCreditScoreService)
            
            let _ = try? await aprService.getAPR(ssn: invalidSSN)
        }
    }

}

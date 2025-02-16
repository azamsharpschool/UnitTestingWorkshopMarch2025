//
//  APRServiceTests.swift
//  OuluBankTests
//
//  Created by Mohammad Azam on 2/2/25.
//

import Testing
@testable import OuluBank

struct APRServiceTests {

    @Test func aprWithGoodCreditScore() async {
        
        var mockCreditScoreService = MockCreditScoreService()
        
        mockCreditScoreService.onGetCreditScore = { _ in
            return CreditScore(score: 720, lastUpdated: "02/02/2025", reportedBy: "Experian")
        }
        
        let aprService = APRService(creditScoreService: mockCreditScoreService)
        do {
            let apr = try await aprService.getAPR(ssn: "123-45-6789")
            #expect(apr == 3.124)
        } catch {
            #expect(Bool(false)) // test always fail
        }
    }
    
    @Test func aprWithBadCreditScore() async throws {
        
        var mockCreditScoreService = MockCreditScoreService()
        
        mockCreditScoreService.onGetCreditScore = { _ in
            return CreditScore(score: 500, lastUpdated: "02/02/2025", reportedBy: "Experian")
        }
        
        let aprService = APRService(creditScoreService: mockCreditScoreService)
        let apr = try await aprService.getAPR(ssn: "987-65-4321")
        #expect(apr == 6.24)
    }
    
    // test when no credit score is found
    @Test func getAPRthrowsErrorWhenNoCreditScoreFound() async throws {
        
        var mockCreditScoreService = MockCreditScoreService()
        
        mockCreditScoreService.onGetCreditScore = { _ in
            return nil
        }
       
        await #expect(throws: APRServiceError.noCreditScoreFound, "Error not thrown for invalid ssn", performing: {
         
            let aprService = APRService(creditScoreService: mockCreditScoreService)
            let apr = try await aprService.getAPR(ssn: "111-11-1111")
        })
        
    }
    
    @Test func aprServiceCallsGetCreditScoreOnCreditScoreService() async throws {
        
        var mockCreditScoreService = MockCreditScoreService()
        
        try await confirmation("APRService did not call GetCreditScore on CreditScoreService", expectedCount: 1) { confirmation in
            
            mockCreditScoreService.onGetCreditScore = { ssn in
                confirmation() 
                return CreditScore(score: 500, lastUpdated: "02/02/2025", reportedBy: "Experian")
            }
            
            let aprService = APRService(creditScoreService: mockCreditScoreService)
            let apr = try await aprService.getAPR(ssn: "123-45-6789")
            #expect(apr > 0)
        }
        
    }

}

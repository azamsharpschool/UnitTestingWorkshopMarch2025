//
//  MockCreditScoreService.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

import Foundation
@testable import OuluBank

struct MockCreditScoreService: CreditScoreServiceProtocol {
    
    var onGetCreditScore: ((String) -> CreditScore?)?
    
    func getCreditScore(ssn: String, completion: (CreditScore?) -> Void) {
        completion(CreditScore(score: 720, lastUpdated: "02/02/2025", reportedBy: "Experian"))
    }
    
    func getCreditScore(ssn: String) async throws -> CreditScore? {
        
        return onGetCreditScore?(ssn)
        
        /*
        // good score
        if ssn == "123-45-6789" {
            return CreditScore(score: 720, lastUpdated: "02/02/2025", reportedBy: "Experian")
        } else if ssn == "987-65-4321" {
            return CreditScore(score: 500, lastUpdated: "02/02/2025", reportedBy: "Experian")
        } else {
            return nil
        }
        */
    }
}

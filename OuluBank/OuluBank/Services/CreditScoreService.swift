//
//  CreditScoreService.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

import Foundation

protocol CreditScoreServiceProtocol {
    func getCreditScore(ssn: String) async throws -> CreditScore?
    func getCreditScore(ssn: String, completion: (CreditScore?) -> Void)
}

// UNMANAGED DEPENDENCY
struct CreditScoreService: CreditScoreServiceProtocol {
    
    func getCreditScore(ssn: String, completion: (CreditScore?) -> Void) {
        
    }
    
    func getCreditScore(ssn: String) async throws -> CreditScore? {
        
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://island-bramble.glitch.me/api/credit-score/\(ssn)")!)
        
        let creditScore = try JSONDecoder().decode(CreditScore.self, from: data)
        return creditScore
    }
    
}

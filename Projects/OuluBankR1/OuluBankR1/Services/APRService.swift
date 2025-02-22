//
//  APRService.swift
//  OuluBankR1
//
//  Created by Mohammad Azam on 2/15/25.
//

import Foundation

enum CreditScoreServiceError: Error, LocalizedError {
    case noCreditScoreFound
    
    // Provide localized error descriptions
    var errorDescription: String? {
        switch self {
        case .noCreditScoreFound:
            return NSLocalizedString(
                "No credit score was found for the provided SSN.",
                comment: "Error message when no credit score is found."
            )
       
        }
    }
}

enum APRServiceError: Error, LocalizedError {
    
    case invalidSSN

    // Provide localized error descriptions
    var errorDescription: String? {
        switch self {
        case .invalidSSN:
            return NSLocalizedString(
                "The provided SSN is invalid. Please enter a valid SSN.",
                comment: "Error message when the SSN is invalid."
            )
        }
    }
}

struct APRService {
    
    let creditScoreService: CreditScoreServiceProtocol
    
    func getAPR(ssn: String) async throws -> Double {
        
        if !ssn.isSSN {
            throw APRServiceError.invalidSSN
        }
        
        guard let creditScore = try await creditScoreService.getCreditScore(ssn: ssn) else {
            throw CreditScoreServiceError.noCreditScoreFound
        }
        
        // calculate the apr based on credit score
        if let score = creditScore.score {
            if score > 650 {
                return Double.random(in: 1...3)
            } else {
                return Double.random(in: 6...10)
            }
        } else {
            throw CreditScoreServiceError.noCreditScoreFound
        }
    }
    
}

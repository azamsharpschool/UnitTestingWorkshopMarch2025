//
//  APRService.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

import Foundation

enum APRServiceError: Error {
    case noCreditScoreFound
}

protocol APRServiceProtocol {
    func getAPRHistory() async throws -> [APRHistory]
    func getAPR(ssn: String) async throws -> Double
}

struct MockAPRService: APRServiceProtocol {
    
    func getAPR(ssn: String) async throws -> Double {
        return 3.142
    }
    
    func getAPRHistory() async throws -> [APRHistory] {
        guard let url = Bundle.main.url(forResource: "apr-history", withExtension: "json") else {
            fatalError("apr-history was not found.")
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(APRHistory.dateFormatter)
        
        return try decoder.decode([APRHistory].self, from: data)
    }
}

struct APRService: APRServiceProtocol {
    
    private let creditScoreService: CreditScoreServiceProtocol
    
    init(creditScoreService: CreditScoreServiceProtocol) {
        self.creditScoreService = creditScoreService
    }
    
    func getAPRHistory() async throws -> [APRHistory] {
        
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://island-bramble.glitch.me/api/apr-history")!)
        return try JSONDecoder().decode([APRHistory].self, from: data)
    }
    
    func getAPR(ssn: String) async throws -> Double {
        
        guard let creditScore = try await creditScoreService.getCreditScore(ssn: ssn) else {
            throw APRServiceError.noCreditScoreFound
        }
        
        //let creditScore = CreditScore(score: 700, lastUpdated: "02/08/2025", reportedBy: "Experian")
        
        if creditScore.score > 650 {
            return 3.124
        } else {
            return 6.24
        }
    }
}

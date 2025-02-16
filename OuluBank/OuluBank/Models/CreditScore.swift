//
//  CreditScore.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

import Foundation

struct CreditScore: Decodable {
    let score: Int
    let lastUpdated: String
    let reportedBy: String
}

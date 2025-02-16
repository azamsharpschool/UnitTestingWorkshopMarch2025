//
//  MockAccount.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

// bad test
class MockAccount {
    var balance = 500.0
    
    init(balance: Double = 500.0) {
        self.balance = balance
    }
    
    func deposit(_ amount: Double) {
        balance += amount
    }
}

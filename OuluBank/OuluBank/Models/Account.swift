//
//  Account.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

final class Account {
    
    let accountNumber: String
    var balance: Double
    
    init(accountNumber: String, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func deposit(_ amount: Double) {
        self.balance += amount
    }
    
    func withdraw(_ amount: Double) {
        
        if amount > self.balance {
            let overdraftAmount = amount - balance
            let overdraftFee = overdraftAmount * 0.10
            balance -= (amount + overdraftFee) // Apply fee
        } else {
            self.balance -= amount
        }
    }
}

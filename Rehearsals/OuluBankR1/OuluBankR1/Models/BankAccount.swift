//
//  BankAccount.swift
//  OuluBankR1
//
//  Created by Mohammad Azam on 2/13/25.
//

import Foundation

enum DepositType {
    case check
    case cash
    case transfer 
}

enum WithdrawType {
    case check
}

enum BankAccountError: Error {
    case invalidAmount
}

enum TransactionType: Error {
    case deposit
    case withdraw
}

struct Transaction {
    let amount: Double
    let transactionType: TransactionType
}

class BankAccount {
    
    var accountNumber: String
    private(set) var balance: Double
    private(set) var transactions: [Transaction] = []
    
    init(accountNumber: String, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    private func calculatePenalty(overdraftAmount: Double) -> Double {
        let penaltyPercentage = 0.10
        return overdraftAmount * penaltyPercentage
    }
    
    func withdraw(amount: Double, withdrawType: WithdrawType) {
        
        var finalAmount: Double = 0.0
        
        if amount > balance {
            
            let overdraftAmount = amount - balance
            let penalty = calculatePenalty(overdraftAmount: overdraftAmount)
            finalAmount = penalty
            self.balance -= penalty
            
        } else {
            self.balance -= amount
            finalAmount = amount
        }
        
        self.transactions.append(Transaction(amount: finalAmount, transactionType: .withdraw))
    }
    
    func deposit(amount: Double, depositType: DepositType) throws {
        
        let transferFeePercentage = 0.02
        
        if amount < 0 {
            throw BankAccountError.invalidAmount
        }
        
        var finalAmount: Double = 0.0
        
        switch depositType {
            case .check, .cash:
                finalAmount = amount
                
            case .transfer:
                let fee = amount * transferFeePercentage
                finalAmount = (amount - fee)
        }
        
        self.balance += finalAmount
        self.transactions.append(Transaction(amount: finalAmount, transactionType: .deposit))
    }
    
}

//
//  BankAccount.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/7/25.
//

import Foundation

enum DepositType {
    case check
    case cash
}

enum WithdrawType {
    case check
    case atm
}

enum TransactionType {
    case deposit
    case withdraw
}

enum BankAccountError: Error {
    case invalidAmount(Double)
}

struct Transaction {
    let amount: Double
    let transactionType: TransactionType
}

struct PenaltyService {
    
    func calculatePenalty(overDraftAmount: Double) -> Double {
        overDraftAmount * 0.10
    }
}

class BankAccount {
    
    var accountNumber: String
    private(set) var balance: Double
    var transactions: [Transaction] = []
    
    let penaltyService: PenaltyService
    
    init(accountNumber: String, balance: Double, penaltyService: PenaltyService = PenaltyService()) {
        self.accountNumber = accountNumber
        self.balance = balance
        self.penaltyService = penaltyService 
    }
    
    func withdraw(amount: Double, withdrawType: WithdrawType) {
        
        if amount > balance {
            let overDraftAmount = amount - balance
            let penalty = penaltyService.calculatePenalty(overDraftAmount: overDraftAmount)
            self.balance -= penalty
        } else {
            self.balance -= amount
        }
        
        self.transactions.append(Transaction(amount: amount, transactionType: .withdraw))
    }
    
    func deposit(amount: Double, depositType: DepositType) throws {
        
        if amount < 0 {
            throw BankAccountError.invalidAmount(amount)
        }
        
        self.balance += amount
        self.transactions.append(Transaction(amount: amount, transactionType: .deposit))
    }
}

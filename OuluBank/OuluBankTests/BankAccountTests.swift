//
//  BankAccountTests.swift
//  OuluBankTests
//
//  Created by Mohammad Azam on 2/7/25.
//

import Testing
@testable import OuluBank

struct BankAccountTests {

    @Test func depositAmountIncreasesBalance() throws {
        let bankAccount = BankAccount(accountNumber: "1234", balance: 500)
        try bankAccount.deposit(amount: 100, depositType: .check)
        #expect(bankAccount.balance == 600)
    }
    
    @Test func depositAddsTransactionToHistory() throws {
        
        let bankAccount = BankAccount(accountNumber: "1234", balance: 500)
        try bankAccount.deposit(amount: 100, depositType: .check)
        
        #expect(bankAccount.transactions.count == 1)
        #expect(bankAccount.transactions[0].amount == 100)
        #expect(bankAccount.transactions[0].transactionType == .deposit)
    }
    
    @Test func withWithdrawingFundsTransactionAddedToHistory() {
        
        let bankAccount = BankAccount(accountNumber: "1234", balance: 500)
        bankAccount.withdraw(amount: 100, withdrawType: .check)
        
        #expect(bankAccount.transactions[0].amount == 100)
        #expect(bankAccount.transactions[0].transactionType == .withdraw)
    }
    
    @Test func whenWithdrawingFundsAndInsufficientBalanceThenChargePenalty() {
        
        let bankAccount = BankAccount(accountNumber: "1234", balance: 500)
        bankAccount.withdraw(amount: 1000, withdrawType: .check)

        #expect(bankAccount.balance == 450, "Balance is not correct.")
    }
    
    @Test func depositNegativeAmountThrowsError() {
        
        let bankAccount = BankAccount(accountNumber: "1234", balance: 500)
        
        #expect("Invalid amount.", performing: {
            try bankAccount.deposit(amount: -100, depositType: .check)
        }, throws: { error in
            
            if case let .invalidAmount(amount) = error as? BankAccountError {
                return amount == -100
            }
            return false
            
        })
    }

}

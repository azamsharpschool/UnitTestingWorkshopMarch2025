//
//  OuluBankR1Tests.swift
//  OuluBankR1Tests
//
//  Created by Mohammad Azam on 2/13/25.
//

import Testing
@testable import OuluBankR1

struct OuluBankR1Tests {

    let bankAccount: BankAccount
    
    init() {
        bankAccount = BankAccount(accountNumber: "123456", balance: 500)
    }
    
    /*
    @Test func deposit_positiveAmount_using_check_increasesBalance()  {
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        bankAccount.deposit(amount: 200, depositType: .check)
        
        #expect(bankAccount.balance == 700)
    }
    
    @Test func deposit_positiveAmount_using_cash_increasesBalance() async throws {
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        bankAccount.deposit(amount: 200, depositType: .cash)
        
        #expect(bankAccount.balance == 700)
    }
    
    @Test func deposit_positiveAmount_using_transfer_increasesBalance() async throws {
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        bankAccount.deposit(amount: 200, depositType: .transfer)
        
        #expect(bankAccount.balance == 700)
    } */
    
    @Test(arguments: [DepositType.check, DepositType.cash])
    func deposit_UsingCheckOrCash_ShouldIncreaseBalanceByExactAmount(_ depositType: DepositType) {
        
       // let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        do {
            try bankAccount.deposit(amount: 200, depositType: depositType)
            #expect(bankAccount.balance == 700)
        } catch {
            #expect(Bool(false))
        }
    }
    
    @Test
    func deposit_usingTransferType_chargesFee_andUpdatesBalanceCorrectly() {
        
       // let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        let feePercentage = 0.02 // 2%
        let depositAmount = 200.0
        let expectedBalance = 500 + depositAmount * (1 - feePercentage)  // 2% fee added to the balance of $700
        
        do {
            try bankAccount.deposit(amount: depositAmount, depositType: .transfer)
            #expect(bankAccount.balance == expectedBalance)
        } catch {
            #expect(Bool(false))
        }
    }
    
    @Test
    func depositNegativeAmount_ShouldThrowException() {
        
        //let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        #expect(throws: BankAccountError.invalidAmount, performing: {
            try bankAccount.deposit(amount: -10, depositType: .check)
        })
    }
    
    @Test
    func deposit_ShouldAddTransactionToHistory() {
        
        //let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        do {
            try bankAccount.deposit(amount: 10, depositType: .check)
            
            #expect(bankAccount.transactions.count == 1, "Transactions should be 1 after deposit.")
            #expect(bankAccount.transactions[0].amount == 10, "Transaction amount is not matching.")
            #expect(bankAccount.transactions[0].transactionType == TransactionType.deposit, "Transaction deposit type is not matching.")
            
        } catch {
            #expect(Bool(false))
        }
    }
    
    @Test
    func withdraw_WhenInsufficientBalance_ShouldChargePenalty() {
        
        //let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        bankAccount.withdraw(amount: 600, withdrawType: .check)
        
        #expect(bankAccount.balance == 490) 
        
    }
    
}

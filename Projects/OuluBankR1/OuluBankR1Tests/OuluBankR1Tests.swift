//
//  OuluBankR1Tests.swift
//  OuluBankR1Tests
//
//  Created by Mohammad Azam on 2/13/25.
//

import Testing
@testable import OuluBankR1

struct OuluBankR1Tests {

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
    func depositing_using_check_or_cash_increases_bank_balance(_ depositType: DepositType) {
        
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        try? bankAccount.deposit(amount: 200, depositType: depositType)
        #expect(bankAccount.balance == 700)
    }
    
    @Test
    func depositing_using_a_transfor_type_charges_a_fee() {
        
        // arrange
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        let feePercentage = 0.02 // 2%
        let depositAmount = 200.0
        let expectedBalance = 500 + depositAmount * (1 - feePercentage)  // 2% fee added to the balance of $700
        
        try? bankAccount.deposit(amount: depositAmount, depositType: .transfer)
        #expect(bankAccount.balance == expectedBalance)
    }
    
    @Test
    func depositing_negative_amount_is_invalid() {
        
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        #expect(throws: BankAccountError.invalidAmount, performing: {
            try bankAccount.deposit(amount: -10, depositType: .check)
        })
    }
    
    @Test
    func withdrawing_with_insufficient_balance_results_in_penalty() {
        
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        bankAccount.withdraw(amount: 600, withdrawType: .check)
        
        #expect(bankAccount.balance == 490)
    }
    
    @Test
    func deposited_amount_is_added_to_transaction_history() {
        
        let bankAccount = BankAccount(accountNumber: "123456", balance: 500)
        
        
        try? bankAccount.deposit(amount: 10, depositType: .check)
        
        #expect(bankAccount.transactions.count == 1, "Transactions should be 1 after deposit.")
        #expect(bankAccount.transactions[0].amount == 10, "Transaction amount is not matching.")
        #expect(bankAccount.transactions[0].transactionType == TransactionType.deposit, "Transaction deposit type is not matching.")
        
    }
    
}

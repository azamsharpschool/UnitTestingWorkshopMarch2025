//
//  OuluBankTests.swift
//  OuluBankTests
//
//  Created by Mohammad Azam on 2/2/25.
//

import Testing
@testable import OuluBank

struct OuluBankTests {

    @Test func initializeBankAccountSuccessfully() {
        let bankAccount = Account(accountNumber: "1234", balance: 100)
        #expect(bankAccount.accountNumber == "1234")
        #expect(bankAccount.balance == 100)
    }
    
    
    @Test func depositMoneyToTheAccount() {
        let account = Account(accountNumber: "123456", balance: 500)
        account.deposit(100)
        #expect(600 == account.balance)
    }
    
    @Test func withdrawMoneyFromTheAccount() {
        let account = Account(accountNumber: "123456", balance: 500)
        account.withdraw(100)
        #expect(400 == account.balance)
    }
    
    @Test func withdrawWithOverdraftFee() {
        let account = Account(accountNumber: "123456", balance: 500)
        account.withdraw(1000)
        #expect(-550 == account.balance)
    }
    
    // bad test
    @Test func testMockAccountDeposit() async throws {
        let mock = MockAccount()
        mock.deposit(100)
        #expect(mock.balance == 600)
    }
}

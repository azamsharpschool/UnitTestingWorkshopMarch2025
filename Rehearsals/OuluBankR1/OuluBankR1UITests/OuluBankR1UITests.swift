//
//  OuluBankR1UITests.swift
//  OuluBankR1UITests
//
//  Created by Mohammad Azam on 2/15/25.
//

import XCTest

final class OuluBankR1UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["UITEST"]
        app.launch()
    }
    
    func test_calculate_apr_when_provided_with_a_valid_ssn() {
       
        let ssnTextField = app.textFields["ssnTextField"]
        ssnTextField.tap()
        ssnTextField.typeText("123-45-6789")
        
        let calculateAPRButton = app.buttons["calculateAPRButton"]
        calculateAPRButton.tap()
        
        let aprText = app.staticTexts["aprText"]
        let aprTextExists = aprText.waitForExistence(timeout: 5)
        
        XCTAssertTrue(aprTextExists, "APR text should exist on the screen.")
        XCTAssertNotEqual(aprText.label, "", "APR text should not be empty.")
    }
    
    func test_displays_error_message_when_credit_score_was_not_found_for_the_provided_ssn() {
        
        let expectedErrorMessage = "No credit score was found for the provided SSN."
        
        let ssnTextField = app.textFields["ssnTextField"]
        ssnTextField.tap()
        ssnTextField.typeText("211-11-1111") // credit score does not exist for this person
        
        let calculateAPRButton = app.buttons["calculateAPRButton"]
        calculateAPRButton.tap()
        
        let messageText = app.staticTexts["messageText"]
        let messageTextExists = messageText.waitForExistence(timeout: 5)
        
        XCTAssertTrue(messageTextExists, "Message text should not be empty.")
        XCTAssertEqual(messageText.label, expectedErrorMessage, "Message text is empty. ")
    }
}

//
//  ValidatorTest.swift
//  KrelloTests
//
//  Created by Kai Kim on 2022/05/05.
//

import XCTest
@testable import Krello

class ValidatorTest: XCTestCase {

    var sut: Validator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_SuccessValidation_OnEmail() throws {
        // Given
        let testEmail = "wwww133@naver.com"

        // When
        let pass = sut.isValidFormat(testEmail, for: .email)

        // Then
        XCTAssertEqual(SuccessMessage.validated(.email).description, pass.description)
    }

    func test_FailureValidation_OnEmail() throws {
        // Given
        let testEmail = "wwww133"

        // When
        let fail = sut.isValidFormat(testEmail, for: .email)

        // Then
        XCTAssertEqual(FailureMessage.invalidFormat(.email).description, fail.description)
    }

    func test_SuccessValidation_OnPassword() throws {
        // Given
        let testPassword = "1234567aA!@"

        // When
        let pass = sut.isValidFormat(testPassword, for: .password)

        // Then
        XCTAssertEqual(SuccessMessage.validated(.password).description, pass.description)
    }

    func test_FailureValidation_OnPassword() throws {
        // Given
        let testPassword = "123123"

        // When
        let fail = sut.isValidFormat(testPassword, for: .password)

        // Then
        XCTAssertEqual(FailureMessage.invalidFormat(.password).description, fail.description)

    }

    func test_SuccessValidation_OnUserName() throws {
        // Given
        let testUserName = "김태경"

        // When
        let pass = sut.isValidFormat(testUserName, for: .userName)

        // Then
        XCTAssertEqual(SuccessMessage.validated(.userName).description, pass.description)

    }

    func test_FailureValidation_OnUserName() throws {
        // Given
        let testUserName = "김"

        // When
        let fail = sut.isValidFormat(testUserName, for: .userName)

        // Then
        XCTAssertEqual(FailureMessage.invalidFormat(.userName).description, fail.description)

    }

    func test_SuccessValidation_PasswordConfirmation() throws {
        // Given
        let password = "12345678A"
        let confirmPassword = "12345678A"

        // When
        let pass = sut.isMatched(password: password, confirmPassword: confirmPassword)
        // Then
        XCTAssertEqual(SuccessMessage.passwordMatched.description, pass.description)

    }

    func test_FailureValidation_PasswordConfirmation() throws {
        // Given
        let password = "12345678A"
        let confirmPassword = "12345678"

        // When
        let fail = sut.isMatched(password: password, confirmPassword: confirmPassword)

        // Then
        XCTAssertEqual(FailureMessage.passwordNotMatched.description, fail.description)

    }

    func test_FailureValidation_PasswordConfirmation_ForEmptyCase() throws {
        // Given
        let password = ""
        let confirmPassword = ""

        // When
        let fail = sut.isMatched(password: password, confirmPassword: confirmPassword)

        // Then
        XCTAssertEqual(FailureMessage.itemEmpty.description, fail.description)

    }

    func test_FailureValidation_PasswordConfirmation_ForEmptySpaceCase() throws {
        // Given
        let password = "      "
        let confirmPassword = "      "

        // When
        let fail = sut.isMatched(password: password, confirmPassword: confirmPassword)

        // Then
        XCTAssertEqual(SuccessMessage.passwordMatched.description, fail.description)
    }

}

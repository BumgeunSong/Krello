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
        switch pass {
        case .success(let bool):
            XCTAssertTrue(bool)
        case .failure:
            XCTFail()
        }
    }

    func test_FailureValidation_OnEmail() throws {
        // Given
        let testEmail = "wwww133"

        // When
        let fail = sut.isValidFormat(testEmail, for: .email)

        // Then
        switch fail {
        case .failure(let value):
            XCTAssertEqual(ValidationFailure.invalidFormat(.email).description, value.description)
        case .success:
            XCTFail()
        }
    }

    func test_SuccessValidation_OnPassword() throws {
        // Given
        let testPassword = "1234567aA!@"

        // When
        let pass = sut.isValidFormat(testPassword, for: .password)

        // Then
        switch pass {
        case .success(let bool):
            XCTAssertTrue(bool)
        case .failure:
            XCTFail()
        }
    }

    func test_FailureValidation_OnPassword() throws {
        // Given
        let testEmail = "123123"

        // When
        let fail = sut.isValidFormat(testEmail, for: .password)

        // Then
        switch fail {
        case .failure(let value):
            XCTAssertEqual(ValidationFailure.invalidFormat(.password).description, value.description)
        case .success:
            XCTFail()
        }
    }

    func test_SuccessValidation_OnUserName() throws {
        // Given
        let testEmail = "김태경"

        // When
        let pass = sut.isValidFormat(testEmail, for: .userName)

        // Then
        switch pass {
        case .success(let bool):
            XCTAssertTrue(bool)
        case .failure:
            XCTFail()
        }
    }

    func test_FailureValidation_OnUserName() throws {
        // Given
        let testEmail = "김"

        // When
        let fail = sut.isValidFormat(testEmail, for: .userName)

        // Then
        switch fail {
        case .failure(let value):
            XCTAssertEqual(ValidationFailure.invalidFormat(.userName).description, value.description)
        case .success:
            XCTFail()
        }
    }

}

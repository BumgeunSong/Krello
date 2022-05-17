//
//  AuthenticationTest.swift
//  KrelloTests
//
//  Created by Kai Kim on 2022/05/08.
//

import XCTest
import FirebaseAuth
@testable import Krello

private class AuthenticationFailureEngineMock: AuthenticationEngine {

    func registerUser(info: AuthenticationInfo, completion: @escaping (Result<AuthDataResult, AuthErrorCode>) -> Void) {
        let errorCode: AuthErrorCode = AuthErrorCode(.emailAlreadyInUse)
        completion(.failure(errorCode))
    }

    func login(info: AuthenticationInfo, completion: @escaping (Result<AuthDataResult, AuthErrorCode>) -> Void) {
        let errorCode: AuthErrorCode = AuthErrorCode(.wrongPassword)
        completion(.failure(errorCode))
    }

    func resignUser(completion: @escaping (Result<Bool, AuthErrorCode>) -> Void) {
        let errorCode: AuthErrorCode = AuthErrorCode(.nullUser)
        completion(.failure(errorCode))
    }

}

class AuthenticationTest: XCTestCase {
    var sut: AuthenticationManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthenticationManager(authenticationEngine: AuthenticationFailureEngineMock())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_EmailDuplication() throws {
        let userInfo = AuthenticationInfo(email: "", password: "")
        sut.signUp(info: userInfo) { result in
            switch result {
            case .success:
                XCTFail("There should only be failure with email duplication error")
            case .failure(let error):
                XCTAssertEqual(AuthErrorCode.emailAlreadyInUse, error.code)
            }
        }
    }

    func test_InvalidPassword() throws {
        let userInfo = AuthenticationInfo(email: "", password: "")
        sut.login(info: userInfo) { result in
            switch result {
            case .success:
                XCTFail("There should only be failure with Wrong Password error")
            case .failure(let error):
                XCTAssertEqual(AuthErrorCode.wrongPassword, error.code)
            }
        }
    }

    func test_ResignFailure() throws {
        sut.resignUser { result in
            switch result {
            case .success:
                XCTFail("There should only be failure with Null User error")
            case .failure(let error):
                XCTAssertEqual(AuthErrorCode.nullUser, error.code)
            }
        }
    }

}

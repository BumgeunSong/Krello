//
//  AuthenticationManagerTest.swift
//  KrelloTests
//
//  Created by Kai Kim on 2022/05/06.
//

import XCTest
import OSLog
@testable import Krello
class AuthenticationManagerIntegrationTest: XCTestCase {
    var sut: AuthenticationManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthenticationManager()
    }

    override func tearDownWithError() throws {

        sut = nil
        try super.tearDownWithError()

    }

    func test_CreateUser() throws {
        // Given
        let userInfo = AuthenticationInfo(email: "wwww1324@naver.com", password: "12345678A")
        let registerExpect = XCTestExpectation(description: "회원생성메소드 실행 완료")
        // When
        sut.signUp(info: userInfo) { result in
            switch result {
            case .success(let auth):
                os_log(.default, log: .default, "%@", auth.description)
            case .failure(let error):
                os_log(.default, log: .default, "%@", error.localizedDescription)
            }
            registerExpect.fulfill()
        }

        wait(for: [registerExpect], timeout: 2)

    }

    func test_Login_Resign_User() throws {
        // Given
        let userInfo = AuthenticationInfo(email: "wwww1324@naver.com", password: "12345678A")
        let logInExpect = XCTestExpectation(description: "회원 로그인 실행 완료")

        // When
        sut.login(info: userInfo) {result in
            switch result {
            case .success(let auth):
                os_log(.default, log: .default, "%@", auth.description)
            case .failure(let error):
                os_log(.default, log: .default, "%@", error.localizedDescription)
            }
            logInExpect.fulfill()
        }

        wait(for: [logInExpect], timeout: 2)
    }

    func test_ResignUser() throws {
        // Given
        let resignExpect = XCTestExpectation(description: "회원 삭제 실행 완료")

        // When
        sut.resignUser {result in
            switch result {
            case .success:
                os_log(.default, log: .default, "%@", "회원 삭제 성공")
            case .failure:
                XCTFail("ID should be deleted")
            }
            resignExpect.fulfill()
        }
        wait(for: [resignExpect], timeout: 5)
    }
}

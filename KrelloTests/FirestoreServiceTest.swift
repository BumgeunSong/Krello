//
//  FirestoreServiceTest.swift
//  KrelloTests
//
//  Created by Sujin Jin on 2022/05/10.
//

import XCTest
@testable import Krello

class FirestoreServiceTest: XCTestCase {

    var sut: FirestoreService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FirestoreService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_fetchLogs() {
        let expectation = XCTestExpectation(description: #function)
        sut.fetchLogs(boardUid: "gVH4Hbz0HQ14Jbbqfqrz") { result in
            switch result {
            case .success(let logs):
                XCTAssertNotNil(logs)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchBoards_withUserUid_shouldResponseBoards() {
        let expectation = XCTestExpectation(description: #function)
        sut.fetchBoards(userUid: "P3OuBRgwk2gZojfq8dmgkicz2fA2") { result in
            switch result {
            case .success(let boards):
                XCTAssertNotNil(boards)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchUser_shouldResponseUserData() {
        let expectation = XCTestExpectation(description: #function)
        sut.fetchUser(email: "bb@email.net") { result in
            switch result {
            case .success(let datas):
                XCTAssertNotNil(datas)
            case .failure:
                XCTFail("Failed fetch user")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchUserAll_sholudResponseUserList() {
        let expectation = XCTestExpectation(description: #function)
        sut.fetchAllUsers { result in
            switch result {
            case .success(let datas):
                XCTAssertNotNil(datas)
            case .failure:
                XCTFail("Failed fetch users")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

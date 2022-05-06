//
//  LoginViewTest.swift
//  KrelloTests
//
//  Created by Sujin Jin on 2022/05/06.
//

import XCTest
@testable import Krello

class LoginViewTest: XCTestCase {

    var sut: LoginView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginView()
    }

    override func tearDownWithError() throws {
        executeRunLoop()
        sut = nil
        try super.tearDownWithError()
    }

    func test_loginButtonAction_touchUpInside() throws {
        // Given:
        let tapExpectation = expectation(description: #function)
        sut.didTapLoginButton = {
            tapExpectation.fulfill()
        }

        // When:
        tap(sut.loginButton)

        // Then:
        wait(for: [tapExpectation], timeout: 0.1)
    }

    func test_signButtonAction_touchUpInside() throws {
        // Given:
        let tapExpectation = expectation(description: #function)
        sut.didTapSignupButton = {
            tapExpectation.fulfill()
        }

        // When:
        tap(sut.signupButton)

        // Then:
        wait(for: [tapExpectation], timeout: 0.1)
    }

    func test_emailTextField_whenShouldReturn_shouldMoveInputFocusToPasswordTextField() {
        putInViewHierarchy(sut)

        shouldReturn(in: sut.emailTextField)

        XCTAssertTrue(sut.passwordTextField.isFirstResponder)
    }
    // MARK: - helper methods
    func tap(_ button: UIButton) {
        button.sendActions(for: .touchUpInside)
    }

    func executeRunLoop() {
        RunLoop.current.run(until: Date())
    }

    func putInViewHierarchy(_ view: UIView) {
        let window = UIWindow()
        window.addSubview(view)
    }

    @discardableResult func shouldReturn(in textField: UITextField) -> Bool? {
        textField.delegate?.textFieldShouldReturn?(textField)
    }
}

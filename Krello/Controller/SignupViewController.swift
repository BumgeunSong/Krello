//
//  SignUpViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class SignupViewController: UIViewController {

    private let signupView = SignupFormView()
    private let validator = Validator()
    private let authenticationManager = AuthenticationManager()
    private var alert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = signupView
        processFieldEmptyValidtion()
        processRegexValidation()
        processPasswordConfirmation()
        processSignup()
        signupView.didTapCloseButton = { [weak self] in
            self?.dismiss(animated: true)
        }
    }

    private func processFieldEmptyValidtion() {
        signupView.validateEmptyFields = {[weak self] textField in
        guard let text = textField.text, let self = self else {return nil}
        return  self.validator.validateEmpty(text)
        }
    }

    private func processRegexValidation () {
        signupView.validateRegexFields = { [weak self] textField in
            guard let item = textField.item, let text = textField.text, let self = self else {return nil}
            return self.validator.isValidFormat(text, for: item)
        }
    }

    private func processPasswordConfirmation() {
        signupView.validatePasswordConfirmation = { [weak self] password, passwordConfirmationTextField in
            guard let self = self else {return nil}
            let result = self.validator.isMatched(password: password, confirmPassword: passwordConfirmationTextField.text)
            return result}
    }

    private func processSignup() {
        signupView.didTapSignupButton = { [weak self] email, password, userName in
            guard let self = self else {return}
            print("\(email):\(password):\(userName)")
            let userInfo = AuthenticationInfo(email: email, password: password)
            self.authenticationManager.signUp(info: userInfo) { result in
                switch result {
                case .success(let user):
                    //TODO: Alert 띄우기
                    print(user)
                case .failure(let error):
                    //TODO: 서버와 연결이 끊기면 Alert 띄우기 
                    print(error)
                }
            }
        }
    }

}
// Add this to see preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct SignupViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // This is viewController you want to see.
            return SignupViewController()
        }
        .previewDevice("iPhone 12")
    }
}
#endif

//
//  SignUpViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class SignupViewController: UIViewController {

    let signupView = SignupFormView()
    let validator = Validator()

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
        signupView.didTapSignupButton = { email, password in
            print("\(email):\(password)")
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

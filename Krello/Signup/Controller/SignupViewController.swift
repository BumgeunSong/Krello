//
//  SignUpViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit
import FirebaseAuth
class SignupViewController: UIViewController {

    private let signupView = SignupFormView()
    private let validator = Validator()
    private let authenticationManager = AuthenticationManager()
    private var emails: Set<String>?
    private let firestoreService = FirestoreService()
    var didSuccessSignup: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = signupView

        self.firestoreService.fetchAllUsers { result in
            switch result {
            case .success(let users):
                self.emails = Set(users.map { $0.email })
                self.processEmailDuplication()
            case .failure(let errors):
                print(errors)
            }
        }

        processFieldEmptyValidation()
        processRegexValidation()
        processPasswordConfirmation()
        processSignup()
        signupView.didTapCloseButton = { [weak self] in
            self?.dismiss(animated: true)
        }
    }

    private func processEmailDuplication() {
        guard let emails = emails else {return}
        signupView.validateDuplicatedEmail = {[weak self] textField in
            print(emails)
            guard let text = textField.text, let self = self else {return nil}
            return self.validator.validateDuplication(text, emailList: emails)
        }

    }

    private func processFieldEmptyValidation() {
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
            let userInfo = AuthenticationInfo(email: email, password: password)
            self.authenticationManager.signUp(info: userInfo) { result in
                switch result {
                case .success(let user):
                    self.firestoreService.insertUser(uid: user.uid, email: email, userName: userName) {
                        print("success!")

                        self.dismiss(animated: true) {
                            self.didSuccessSignup?(user.uid)
                        }
                    }
                case .failure(let error):
                    // TODO: ????????? ????????? ????????? Alert ?????????
                    let alert = UIAlertController(title: "\(error)", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "??????", style: .default, handler: {_ in
                        self.dismiss(animated: true)
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true)
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

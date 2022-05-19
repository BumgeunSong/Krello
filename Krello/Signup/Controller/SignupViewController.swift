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
    private let firestoreService = FirestoreService()
    private var emails: Set<String>?
    private var coordinator: SceneCoordinator?

    init(coordinator: SceneCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            self?.coordinator?.dismissPresented()
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

                        // TODO: dismiss 도 coordinator 에서 하도록 변경할 것
                        self.dismiss(animated: false) {
                            self.coordinator?.performTransition(to: .boardList(uid: user.uid), style: .root)
                        }
                    }
                case .failure(let error):
                    // TODO: 서버와 연결이 끊기면 Alert 띄우기
                    let alert = UIAlertController(title: "\(error)", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: {_ in
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
            return SignupViewController(coordinator: nil)
        }
        .previewDevice("iPhone 12")
    }
}
#endif

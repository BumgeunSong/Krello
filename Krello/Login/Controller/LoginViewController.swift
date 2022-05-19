//
//  LoginViewController.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let authenticationManager =  AuthenticationManager()
    var coordinator: ApplicationCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView

        processLogin()
        processSignUp()
    }

    private func processLogin() {
        loginView.didTapLoginButton = { [weak self] email, password in

            let userInfo = AuthenticationInfo(email: email, password: password)

            self?.authenticationManager.login(info: userInfo) { [weak self] authResult in
                switch authResult {
                case .success(let user):
                    self?.coordinator?.performTransition(to: .board(uid: user.uid), style: .root)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func processSignUp() {
        loginView.didTapSignupButton = { [weak self] in
            self?.coordinator?.performTransition(to: .signup, style: .present)
        }
    }
}

// Add this to see preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct LoginViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // This is viewController you want to see.
            return LoginViewController()
        }
        .previewDevice("iPhone 12")
    }
}
#endif

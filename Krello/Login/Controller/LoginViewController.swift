//
//  LoginViewController.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let authenticationManager =  AuthenticationManager()
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
            return LoginViewController(coordinator: nil)
        }
        .previewDevice("iPhone 12")
    }
}
#endif

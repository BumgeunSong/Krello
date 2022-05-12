//
//  LoginViewController.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView

        loginView.didTapLoginButton = { [weak self] in
            let destinationVC = BoardListViewController()
            let navigationViewController = UINavigationController(rootViewController: destinationVC)
            navigationViewController.modalPresentationStyle = .fullScreen
            self?.present(navigationViewController, animated: true)
        }

        loginView.didTapSignupButton = {
            print("가입버튼 눌러버렸다")
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

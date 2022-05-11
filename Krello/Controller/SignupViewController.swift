//
//  SignUpViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class SignupViewController: UIViewController {

    let loginView = SignupFormView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        // Do any additional setup after loading the view.
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

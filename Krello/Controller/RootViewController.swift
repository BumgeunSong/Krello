//
//  ViewController.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/03.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

}

// Add this to see preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // This is viewController you want to see.
            return RootViewController()
        }
        .previewDevice("iPhone 12")
    }
}
#endif

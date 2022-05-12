//
//  Preview.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/04.
//

import UIKit
import SwiftUI

@available(iOS 13, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    func makeUIViewController(context: Context) -> ViewController { viewController }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

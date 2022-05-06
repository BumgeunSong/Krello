//
//  UIStackView+Extension.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

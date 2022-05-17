//
//  UIVIew+Extension.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

extension UIView {
    func addSubview(_ subview: UIView, anchors: [LayoutAnchor]) {
        translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.activate(anchors: anchors, relativeTo: self)
    }

    func activate(anchors: [LayoutAnchor], relativeTo: UIView) {
        let constraints = anchors.map {
            NSLayoutConstraint(from: self, to: relativeTo, anchor: $0)
        }
        NSLayoutConstraint.activate(constraints)
    }
}

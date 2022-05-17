//
//  LayoutAnchor+Extension.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

enum LayoutAnchor {
    case constant(attribute: NSLayoutConstraint.Attribute,
                  relation: NSLayoutConstraint.Relation,
                  constant: CGFloat)

    case relative(fromAttribute: NSLayoutConstraint.Attribute,
                  relation: NSLayoutConstraint.Relation,
                  toAttribute: NSLayoutConstraint.Attribute,
                  multiplier: CGFloat,
                  constant: CGFloat)

}

extension LayoutAnchor {
    // ...
}

extension NSLayoutConstraint {
    convenience init(from: UIView, to: UIView, anchor: LayoutAnchor) {
        switch anchor {
        case .constant(let attribute, let relation, let constant):
            self.init(item: from,
                      attribute: attribute,
                      relatedBy: relation,
                      toItem: nil,
                      attribute: attribute,
                      multiplier: 1,
                      constant: constant)
        case .relative(let fromAttribute, let relation, let toAttribute, let multiplier, let constant):
            self.init(item: from,
                      attribute: fromAttribute,
                      relatedBy: relation,
                      toItem: to,
                      attribute: toAttribute,
                      multiplier: multiplier,
                      constant: constant)
        }
    }
}

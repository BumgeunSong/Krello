//
//  InvalidationLabel.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class ValidationLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init? (coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 17)
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
    }

    func setInvalidatedLabel(message: String) {
        self.text = message
        self.textColor = .systemRed
    }

    func setValidatedLabel(message: String) {
        self.text = message
        self.textColor = .krelloGray
    }

}

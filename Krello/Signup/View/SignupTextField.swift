//
//  signupTextField.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class SignupTextField: PaddedTextField {

    private(set) var isValidated: Bool = false
    private(set) var item: Validator.SignupField?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(placeHolder: String? = nil, item: Validator.SignupField?) {
        self.init(frame: .zero)
        self.item = item
        self.placeholder = placeHolder
        setup()
    }

    private func setup() {
        self.setAllPaddingPoints(8)
        self.backgroundColor = .white
        self.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.textContentType = .oneTimeCode
        self.autocorrectionType = .no
    }

    func configureValidation(status: Bool) {
        self.isValidated = status
    }

}

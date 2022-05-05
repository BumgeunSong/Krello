//
//  LoginView.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/05.
//

import UIKit

class PaddedTextField: UITextField {

    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setAllPaddingPoints(_ amount: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
}

class LoginView: DefaultView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createdSubviews()
    }

    func createdSubviews() {
        backgroundColor = .krelloBlue

        let loginStackView = makeStackView(36)
        let textFieldStackView = makeStackView(16)
        let buttonStackView = makeStackView(16)

        addSubview(loginStackView)

        NSLayoutConstraint.activate([
            loginStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            loginStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            loginStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])

        loginStackView.addArrangedSubviews([
            appNameLabel,
            textFieldStackView,
            buttonStackView
        ])

        textFieldStackView.addArrangedSubviews([
            emailTextField,
            passwordTextField
        ])

        buttonStackView.addArrangedSubviews([
            loginButton,
            signupButton
        ])
    }

    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Krello"
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    let emailTextField: UITextField = {
        let textField = PaddedTextField()
        textField.placeholder = "email"
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.setLeftPaddingPoints(8)
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = PaddedTextField()
        textField.backgroundColor = .white
        textField.placeholder = "password"
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.setLeftPaddingPoints(8)
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .krelloGreen
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    let signupButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .krelloGray
        button.setTitle("회원 가입", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    func makeStackView(_ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

}

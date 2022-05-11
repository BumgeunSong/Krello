//
//  SignupFormView.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class SignupFormView: DefaultView {
    var didTapSignupButton: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .krelloBlue
        configureHeader()
        configureFieldStackView()
        configureContainerStackView()
    }

    private func configureHeader() {
        signupHeader.addSubview(closeButton)
        signupHeader.addSubview(signupLabel)
        self.addSubview(signupHeader)
        let topBottomInset = CGFloat(10.0)
        let leadingInset = CGFloat(20.0)
        NSLayoutConstraint.activate([

            signupHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            signupHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            signupHeader.topAnchor.constraint(equalTo: self.topAnchor),

            closeButton.leadingAnchor.constraint(equalTo: signupHeader.leadingAnchor, constant: leadingInset),
            closeButton.topAnchor.constraint(equalTo: signupHeader.topAnchor, constant: topBottomInset),
            closeButton.bottomAnchor.constraint(equalTo: signupHeader.bottomAnchor, constant: -topBottomInset),
            closeButton.widthAnchor.constraint(equalToConstant: 20),

            signupLabel.widthAnchor.constraint(equalToConstant: 100),
            signupLabel.topAnchor.constraint(equalTo: signupHeader.topAnchor, constant: topBottomInset),
            signupLabel.bottomAnchor.constraint(equalTo: signupHeader.bottomAnchor, constant: -topBottomInset),
            signupLabel.centerXAnchor.constraint(equalTo: signupHeader.centerXAnchor, constant: 10),
            signupLabel.centerYAnchor.constraint(equalTo: signupHeader.centerYAnchor)
        ])

    }

    // MARK: StackView
    private func configureFieldStackView() {
        emailFieldStackView.addArrangedSubviews([emailTextField, emailValidationLabel])
        passwordFieldStackView.addArrangedSubviews([passwordTextField, passwordValidationLabel])
        passwordConfirmFieldStackView.addArrangedSubviews([passwordConfirmTextField, passwordConfirmValidationLabel])
        userNameFieldStackView.addArrangedSubviews([ userNameTextField, userNameValidationLabel])

    }
    private func configureContainerStackView() {
        let containerStackView = makeStackView(20)
        containerStackView.addArrangedSubviews([emailFieldStackView, passwordFieldStackView, passwordConfirmFieldStackView, userNameFieldStackView, signupButton])
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerStackView)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: signupHeader.bottomAnchor, constant: 20),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func makeStackView(_ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    // MARK: Header
    let signupHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .krelloGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()

    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: TextFields
    let emailTextField: UITextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Email address"
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.setLeftPaddingPoints(8)
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = PaddedTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.setLeftPaddingPoints(8)
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()

    let passwordConfirmTextField: UITextField = {
        let textField = PaddedTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Confirm password"
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.setLeftPaddingPoints(8)
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()

    let userNameTextField: UITextField = {
        let textField = PaddedTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Name"
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.setLeftPaddingPoints(8)
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()

    // MARK: InvalidMessage Labels
    lazy var emailValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "")
        label.textColor = .clear
        return label
    }()

    lazy var passwordValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "")
        label.textColor = .clear
        return label
    }()

    lazy var passwordConfirmValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "")
        label.textColor = .clear
        return label
    }()

    lazy var userNameValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "")
        label.textColor = .clear
        return label
    }()

    // MARK: signUpButton
    let signupButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .krelloGreen
        button.setTitle("회원 가입", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: StackViews

    let emailFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()

    let passwordFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()

    let passwordConfirmFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()

    let userNameFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
}

extension SignupFormView {
    @objc func didTapCloseButton() {

    }
}

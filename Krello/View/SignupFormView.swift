//
//  SignupFormView.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/11.
//

import UIKit

class SignupFormView: DefaultView {
    var didTapSignupButton: ((_ email: String, _ password: String) -> Void)?
    var didTapCloseButton: (() -> Void)?
    var validateRegexFields: ((SignupTextField) -> (ValidationMessage?))?
    var validateEmptyFields: ((SignupTextField) -> (ValidationMessage?))?
    var validatePasswordConfirmation: ((String, SignupTextField) -> (ValidationMessage?))?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .krelloBlue
        configureHeader()
        configureFieldStackView()
        configureContainerStackView()
        configureActions()
        setupKeyboardActions()
        setTextFieldDelegate()
    }

    private func setTextFieldDelegate() {
        emailTextField.delegate = self
        passwordConfirmTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.delegate = self
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
        let containerStackView = makeStackView(10)
        containerStackView.addArrangedSubviews([emailFieldStackView, passwordFieldStackView, passwordConfirmFieldStackView, userNameFieldStackView, signupButton])
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerStackView)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: signupHeader.bottomAnchor, constant: 30),
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

    // MARK: Actions
    private func configureActions() {
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        emailTextField.addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingDidEnd)
        userNameTextField.addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingDidEnd)
        passwordConfirmTextField.addTarget(self, action: #selector(passwordConfimrationTextFieldDidChange), for: .editingDidEnd)

        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    private func setupKeyboardActions() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
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
        return button
    }()

    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: TextFields
    let emailTextField: SignupTextField = {
        let textField = SignupTextField(placeHolder: "Email address", item: .email)
        return textField
    }()

    let passwordTextField: SignupTextField = {
        let textField = SignupTextField(placeHolder: "Password", item: .password)
        textField.isSecureTextEntry = true
        return textField
    }()

    let passwordConfirmTextField: SignupTextField = {
        let textField = SignupTextField(placeHolder: "Confirm password", item: nil)
        textField.isSecureTextEntry = true
        return textField
    }()

    let userNameTextField: SignupTextField = {
        let textField = SignupTextField(placeHolder: "Name", item: .userName)
        return textField
    }()

    // MARK: InvalidMessage Labels
    let emailValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "empty")
        label.textColor = .clear
        return label
    }()

    let passwordValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "empty")
        label.textColor = .clear
        return label
    }()

    let passwordConfirmValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "empty")
        label.textColor = .clear
        return label
    }()

    let userNameValidationLabel: ValidationLabel = {
        let label = ValidationLabel(text: "empty")
        label.textColor = .clear
        return label
    }()

    // MARK: signUpButton
    let signupButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("가입하기", for: .normal)
        button.setTitleColor(UIColor.krelloBlackOpaque, for: .normal)
        button.backgroundColor = .opaqueSeparator.withAlphaComponent(0.1)
        button.layer.cornerRadius = 10
        button.isEnabled = false
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
    @objc func didTapClose() {
        didTapCloseButton?()
    }

    @objc func didTapSignUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        didTapSignupButton?(email, password)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }

    @objc func textFieldDidFinishChange(_ textField: SignupTextField) {
        guard let validationMessage = validateEmptyFields?(textField) else {return}
        updateValidationStatus(on: textField, with: validationMessage)
    }

    @objc func textFieldDidChange(_ textField: SignupTextField) {
        guard let validationMessage = validateRegexFields?(textField) else {return}
        updateValidationStatus(on: textField, with: validationMessage)
    }

    @objc func passwordConfimrationTextFieldDidChange(_ textField: SignupTextField) {
        guard  let password = passwordTextField.text, let validationMessage = validatePasswordConfirmation?(password, textField) else {return}
        updateValidationStatus(on: textField, with: validationMessage)
    }

    private func updateValidationStatus(on textField: SignupTextField, with message: ValidationMessage) {
        guard let currentStackView = textField.superview as? UIStackView, let label = currentStackView.arrangedSubviews.last as? ValidationLabel else {return}
        if message.resultType == .pass {
            label.setValidatedLabel(message: message.description)
            textField.configureValidation(status: true)
        } else {
            label.setInvalidatedLabel(message: message.description)
            textField.configureValidation(status: false)
        }
        configureSignupButton()
    }

    private func configureSignupButton() {
        let invalidatedTextFields = [emailTextField, passwordTextField, passwordConfirmTextField, userNameTextField].filter({$0.isValidated == false})

        if invalidatedTextFields.isEmpty {
            signupButton.isEnabled = true
            signupButton.setTitleColor(UIColor.krelloBlue, for: .normal)
            signupButton.backgroundColor = .krelloGreen
        } else {
            signupButton.isEnabled = false
            signupButton.setTitleColor(UIColor.krelloBlackOpaque, for: .normal)
            signupButton.backgroundColor = .opaqueSeparator.withAlphaComponent(0.1)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignupFormView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

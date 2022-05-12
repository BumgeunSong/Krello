//
//  Validator.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/05.
//

import Foundation

struct Validator {

    enum SignupField: String {
        case email = "이메일"
        case password = "비밀번호"
        case userName = "이름"
        var regex: String {
            switch self {
            case .email:
                return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            case .password:
                return "[A-Za-z0-9!_@$%^&+=]{8,20}"
            case .userName:
                return "[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]{2,20}"
            }
        }
    }

    func isValidFormat(_ input: String, for item: SignupField) -> ValidationMessage {
        if validate(input, regex: item.regex) {
            return .validated(item)
        } else {
            return .invalidFormat(item)
        }
    }

    private func validate(_ input: String, regex: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
    }

    func isMatched(password: String, confirmPassword: String) -> ValidationMessage {
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedConfirmPassword = confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedPassword.isEmpty && !trimmedConfirmPassword.isEmpty else { return .passwordEmpty}

        if trimmedPassword == trimmedConfirmPassword {
            return .passwordMatched
        } else {
            return .passwordNotMatched
        }
    }

}
enum ValidationResult {
    case pass
    case fail
}

enum ValidationMessage {
    case invalidFormat(_ item: Validator.SignupField)
    case passwordNotMatched
    case passwordMatched
    case passwordEmpty
    case validated(_ item: Validator.SignupField)
}

extension ValidationMessage: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidFormat(let item):
            return "\(item.rawValue) 형식이 맞지 않습니다"
        case .passwordNotMatched:
            return "입력하신 비밀번호와 일치하지 않습니다"
        case .passwordEmpty:
            return "비밀번호 를 입력해주세요"
        case .validated(let item):
            return "사용가능한 \(item.rawValue) 입니다"
        case .passwordMatched:
            return "입력하신 비밀번호와 일치합니다"
        }
    }

    var resultType: ValidationResult {
        switch self {
        case .invalidFormat:
            return .fail
        case .passwordNotMatched:
            return .fail
        case .passwordMatched:
            return .pass
        case .passwordEmpty:
            return .fail
        case .validated:
            return .pass
        }
    }
}

//
//  Validator.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/05.
//

import Foundation

enum ValidationFailure: Error {
    case invalidFormat(_ regex: Validator.Regex)
    case passwordNotMatched
}

extension ValidationFailure {
    var description: String {
        switch self {
        case .invalidFormat(let regex):
            return "\(regex.type) 형식이 맞지 않습니다"
        case .passwordNotMatched:
            return "비밀번호가 일치하지 않습니다"
        }

    }
}

struct Validator {

    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        case userName = "[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]{2,20}"
        var type: String {
            switch self {
            case .email:
                return "이메일"
            case .password:
                return "비밀번호"
            case .userName:
                return "이름"
            }
        }
    }

    func isValidFormat(_ input: String, for regex: Regex) -> Result<Bool, ValidationFailure> {
        if validateRegex(input, regex: regex) {
            return .success(true)
        } else {
            return .failure(.invalidFormat(regex))
        }
    }

    private func validateRegex(_ input: String, regex: Regex) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regex.rawValue).evaluate(with: input)
    }

    func isPasswordMatched(password: String, confirmPassword: String) -> Result<Bool, ValidationFailure> {
        if password == confirmPassword {
            return .success(true)
        } else {
            return .failure(.passwordNotMatched)
        }
    }

}

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
        var regexDescription: String {
            switch self {
            case .email:
                return "example@example.com"
            case .password:
                return "대소문자(특수문자포함 가능)8 ~ 20글자"
            case .userName:
                return "한글 또는 영어 2~20 글자"
            }
        }
    }

    func validateDuplication(_ input: String, emailList: [String]) -> ValidationDescriptive? {
        for email in emailList {
            if input == email {
                return FailureMessage.duplicatedEmailAddress
            }
        }
        return nil
    }

    func validateEmpty(_ input: String) -> ValidationDescriptive? {
        guard !input.isEmpty else {return FailureMessage.itemEmpty}
        return nil
    }

    func isValidFormat(_ input: String, for item: SignupField) -> ValidationDescriptive {
        guard !input.isEmpty else {return FailureMessage.itemEmpty}

        if validate(input, regex: item.regex) {
            return SuccessMessage.validated(item)
        } else {
            return FailureMessage.invalidFormat(item)
        }
    }

    private func validate(_ input: String, regex: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
    }

    func isMatched(password: String, confirmPassword: String?) -> ValidationDescriptive {
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {return FailureMessage.itemEmpty}
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedConfirmPassword = confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedPassword == trimmedConfirmPassword ? SuccessMessage.passwordMatched : FailureMessage.passwordNotMatched
    }

}

protocol ValidationDescriptive {
    var description: String {get}
    var status: Bool {get}
}

enum SuccessMessage: ValidationDescriptive {
    case validated(_ item: Validator.SignupField)
    case passwordMatched
    var status: Bool {true}
    var description: String {
        switch self {
        case .validated(let item):
            return "사용가능한 \(item.rawValue) 입니다"
        case .passwordMatched:
            return "입력하신 비밀번호와 일치합니다"
        }
    }
}

enum FailureMessage: ValidationDescriptive {

    case invalidFormat(_ item: Validator.SignupField)
    case passwordNotMatched
    case passwordEmpty
    case itemEmpty
    case duplicatedEmailAddress

    var status: Bool {false}
    var description: String {
        switch self {
        case .invalidFormat(let item):
            return "\(item.regexDescription) 형식으로 작성해주세요"
        case .passwordNotMatched:
            return "입력하신 비밀번호와 일치하지 않습니다"
        case .passwordEmpty:
            return "비밀번호 를 입력해주세요"
        case.itemEmpty:
            return "필수 정보입니다"
        case .duplicatedEmailAddress:
            return "중복된 이메일주소 입니다."
        }

    }
}

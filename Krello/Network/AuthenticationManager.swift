//
//  AuthenticationManager.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/06.

import FirebaseAuth

protocol AuthenticationEngine {
    func registerUser(info: AuthenticationInfo, completion : @escaping  (Result<AuthDataResult, AuthErrorCode>) -> Void)
    func login(info: AuthenticationInfo, completion : @escaping  (Result<AuthDataResult, AuthErrorCode>) -> Void)
    func resignUser(completion : @escaping  (Result<Bool, AuthErrorCode>) -> Void)
}

extension Auth: AuthenticationEngine {

    func registerUser(info: AuthenticationInfo, completion: @escaping  (Result<AuthDataResult, AuthErrorCode>) -> Void) {
        Auth.auth().createUser(withEmail: info.email, password: info.password) {authResult, error in
            if let error = error as? AuthErrorCode {
                completion(.failure(error))
            } else {
                guard let authResult = authResult else {return}
                completion(.success(authResult))
            }
        }
    }

    func login(info: AuthenticationInfo, completion : @escaping  (Result<AuthDataResult, AuthErrorCode>) -> Void) {
        Auth.auth().signIn(withEmail: info.email, password: info.password) {authResult, error in
            if let error = error as? AuthErrorCode {
                completion(.failure(error))
            } else {
                guard let authResult = authResult else {return}
                completion(.success(authResult))
            }
        }
    }

    func resignUser(completion: @escaping (Result<Bool, AuthErrorCode>) -> Void) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error as? AuthErrorCode {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

}

class AuthenticationManager {

    // AuthenticatableEngine 을 만들면서 Testable 한 AuthenticationManager 을 구현할수 있게됨.
    private let authenticationEngine: AuthenticationEngine

    init (authenticationEngine: AuthenticationEngine = Auth.auth()) {
        self.authenticationEngine = authenticationEngine
    }

    func signUp(info: AuthenticationInfo, completion: @escaping (Result<User, AuthErrorCode>) -> Void) {
        authenticationEngine.registerUser(info: info) { result in
            switch result {
            case .success(let authResult):
                completion(.success(authResult.user))
            case .failure(let error):
                completion(.failure(error))

            }
        }

    }

    func login(info: AuthenticationInfo, completion: @escaping (Result<User, AuthErrorCode>) -> Void) {
        authenticationEngine.login(info: info) { result in
            switch result {
            case .success(let authResult):
                completion(.success(authResult.user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func resignUser(completion: @escaping (Result<Bool, AuthErrorCode>) -> Void) {
        authenticationEngine.resignUser { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

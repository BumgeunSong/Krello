//
//  AuthenticationEngine.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

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

//
//  UserGetService.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/17.
//

import Foundation

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserGetting {
    func getAllUser(uid: String, email: String, userName: String, _ completion: @escaping () -> Void)
}

struct UserAddService: UserGetting {
    func addUser(uid: String, email: String, userName: String, _ completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        userRef.setData([
            "id": uid,
            "email": email,
            "name": userName
        ]) { err in
            if let err = err {
                print(err)
            } else {
                completion()
            }
        }
    }
}

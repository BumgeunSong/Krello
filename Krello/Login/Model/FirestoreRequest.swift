//
//  FirestoreRequest.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/18.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirestoreRequest {
    associatedtype Modeltype: Codable
    var docReference: DocumentReference { get }
    var docData: [String: Any] { get }
}

extension FirestoreRequest {
    var db: Firestore {
        Firestore.firestore()
    }
}

struct UserRequest: FirestoreRequest {
    typealias Modeltype = UserProfile

    var uid: FireabaseAuthUID
    var email: String
    var username: String

    var docReference: DocumentReference {
        db.collection("users").document(uid)
    }

    var docData: [String: Any] {
        return ["email": email, "username": username]
    }
}

// Tasks를 Board 필드 배열에 추가하는 경우
struct TaskRequest: FirestoreRequest {
    typealias Modeltype = Task

    var boardId: FirestoreUID

    var docReference: DocumentReference {
        db.collection("boards").document(boardId)
    }

    var task: Task

    var docData: [String: Any] {
        task.serialized
    }
}

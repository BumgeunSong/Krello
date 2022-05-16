//
//  FirestoreService.swift
//  Krello
//
//  Created by Sujin Jin on 2022/05/10.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

typealias UID = String

struct ServerUser: Identifiable, Codable {
    @DocumentID var id: String? // 회원가입할때 생성된 uid
    let name: String
    let email: String
}

struct Task: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let status: Status
    let contents: String
    let rowPosition: Int
    let createdAt: Date

    enum Status: String, Codable {
        case todo = "Todo"
        case inprogress = "Inprogress"
        case done = "Done"
        case none = "None"
    }
}

struct Board: Identifiable, Codable {
    @DocumentID var id: String?
    let ownerUid: String
    let title: String
    let tasks: [Task]?
}

struct ActivityLog: Identifiable, Codable {
    @DocumentID var id: String?
    let taskTitle: String
    let createdAt: Date
    let action: Action

    enum Action: String, Codable {
        case move = "Move"
        case add = "Add"
        case delete = "Delete"
        case update = "Update"
    }
}

enum FirestoreServiceError: Error {
    case notDecodeData
    case emptyData
    case error(error: Error)
}

final class FirestoreService {

    func insertUser(uid: String, email: String, userName: String, _ completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        userRef.setData([
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

    func fetchUser(uid: String, _ completion: @escaping (Result<ServerUser, FirestoreServiceError>) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        userRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            guard let document = documentSnapshot, document.exists else {
                completion(.failure(.emptyData))
                return
            }
            guard let decodedModel = try? document.data(as: ServerUser.self) else {
                completion(.failure(.notDecodeData))
                return
            }
            completion(.success(decodedModel))
        }
    }

    func fetchAllUsers(_ completion: @escaping (Result<[ServerUser], FirestoreServiceError>) -> Void) {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")

        usersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }

            guard let documents = querySnapshot?.documents else {
                completion(.failure(.emptyData))
                return
            }

            var results = [ServerUser]()
            for document in documents {
                guard let decodeModel = try? document.data(as: ServerUser.self) else {
                    continue
                }
                results.append(decodeModel)
            }
            completion(.success(results))
        }
    }

    func fetchBoards(userUid: String, _ completion: @escaping (Result<[Board], FirestoreServiceError>) -> Void) {
        let db = Firestore.firestore()
        let boardRef = db.collection("boards").whereField("ownerUid", isEqualTo: userUid)

        boardRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            var result = [Board]()
            for document in querySnapshot!.documents {
                guard let model = try? document.data(as: Board.self) else {
                    continue
                }
                result.append(model)
            }
            completion(.success(result))
        }
    }

    func fetchLogs(boardUid: String, _ completion: @escaping(Result<[ActivityLog], FirestoreServiceError>) -> Void) {
        let db = Firestore.firestore()
        let boardLogsRef = db.collection("boards").document(boardUid).collection("logs")

        boardLogsRef.getDocuments { (snapShot, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            guard let documents = snapShot?.documents else {
                completion(.failure(.emptyData))
                return
            }
            var result = [ActivityLog]()
            for document in documents {
                guard let decodeModel = try? document.data(as: ActivityLog.self) else {
                    continue
                }
                result.append(decodeModel)
            }
            completion(.success(result))
        }
    }
}

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
import MobileCoreServices

enum FirestoreServiceError: Error {
    case notDecodeData
    case emptyData
    case error(error: Error)
}

final class FirestoreService {

    func save<Request: FirestoreRequest>(_ request: Request, _ completion: (() -> Void)? = nil) {
        let ref = request.docReference

        ref.setData(request.docData) { err in
            if let err = err {
                print(err)
            } else {
                completion?()
            }
        }

    }

    func get<Request: FirestoreRequest>(_ request: Request, _ completion: @escaping (Result<Request.Modeltype, FirestoreServiceError>) -> Void) {
        let ref = request.docReference

        ref.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            guard let document = documentSnapshot, document.exists else {
                completion(.failure(.emptyData))
                return
            }
            guard let decodedModel = try? document.data(as: Request.Modeltype.self) else {
                completion(.failure(.notDecodeData))
                return
            }
            completion(.success(decodedModel))
        }
    }

    func fetchUser(uid: String, _ completion: @escaping (Result<UserProfile, FirestoreServiceError>) -> Void) {
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
            guard let decodedModel = try? document.data(as: UserProfile.self) else {
                completion(.failure(.notDecodeData))
                return
            }
            completion(.success(decodedModel))
        }
    }

    func fetchAllUsers(_ completion: @escaping (Result<[UserProfile], FirestoreServiceError>) -> Void) {
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

            var results = [UserProfile]()
            for document in documents {
                guard let decodeModel = try? document.data(as: UserProfile.self) else {
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

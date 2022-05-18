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

<<<<<<< HEAD
typealias UID = String

struct ServerUser: Identifiable, Codable {
    @DocumentID var id: String? // 회원가입할때 생성된 uid
    let name: String
    let email: String
}

enum DragAndDropError: Error {
    case DropDecodingErrror
}

final class Task: NSObject, Identifiable, Codable, NSItemProviderReading, NSItemProviderWriting {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }

    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
            let progress = Progress(totalUnitCount: 100)
            do {
                let data = try JSONEncoder().encode(self)
                progress.completedUnitCount = 100
                completionHandler(data, nil)
            } catch {
                completionHandler(nil, error)
            }
            return progress
        }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        do {
            let subject = try JSONDecoder().decode(Task.self, from: data)
            return subject
        } catch {
           throw DragAndDropError.DropDecodingErrror
        }
    }

    let id: String
    let title: String
    let status: Status
    let contents: String
    let rowPosition: Int
    let createdAt: Date

    init(id: String, title: String, status: Status, contents: String, rowPosition: Int, createdAt: Date) {
        self.id = id
        self.title = title
        self.contents = contents
        self.status = status
        self.rowPosition = rowPosition
        self.createdAt = createdAt
    }

    enum Status: String, Codable {
        case todo = "Todo"
        case inprogress = "In progress"
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

=======
>>>>>>> 3de9d3f ([#49] Add: Make networking layer generic by FirestoreRequest protocol)
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

    func fetchUser(uid: String, _ completion: @escaping (Result<User, FirestoreServiceError>) -> Void) {
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
            guard let decodedModel = try? document.data(as: User.self) else {
                completion(.failure(.notDecodeData))
                return
            }
            completion(.success(decodedModel))
        }
    }

    func fetchAllUsers(_ completion: @escaping (Result<[User], FirestoreServiceError>) -> Void) {
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

            var results = [User]()
            for document in documents {
                guard let decodeModel = try? document.data(as: User.self) else {
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

//
//  Task.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/18.
//

import Foundation
import FirebaseFirestoreSwift
import MobileCoreServices

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
    var serialized: [String: Any] {
        return [
            "id": id,
            "title": title,
            "status": status,
            "contents": contents,
            "rowPosition": rowPosition,
            "createdAt": createdAt
        ]
    }
}

enum DragAndDropError: Error {
    case DropDecodingErrror
}

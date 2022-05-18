//
//  Task.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/18.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable, Hashable {
    let id: FirestoreUID
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

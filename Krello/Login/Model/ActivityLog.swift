//
//  ActivityLog.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/18.
//

import Foundation
import FirebaseFirestoreSwift

struct ActivityLog: Identifiable, Codable {
    @DocumentID var id: FirestoreUID?
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

//
//  Board.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/18.
//

import Foundation
import FirebaseFirestoreSwift

struct Board: Identifiable, Codable {
    @DocumentID var id: FirestoreUID?
    let ownerUid: String
    let title: String
    let tasks: [Task]?
}

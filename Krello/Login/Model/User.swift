//
//  User.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/18.
//

import Foundation
import FirebaseFirestoreSwift

typealias FirestoreUID = String
typealias FireabaseAuthUID = String

struct User: Identifiable, Codable {
    @DocumentID var id: FireabaseAuthUID? // 회원가입할때 생성된 uid
    let name: String
    let email: String
}

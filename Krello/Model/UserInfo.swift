//
//  UserInfo.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/08.
//

import Foundation
// UserInfo 는 데이터 베이스에 들어갈 정보이기 때문에 password 는 안넣음
// password 정보는 Firebase Auth 에 있음.
struct UserInfo {
    let uid: String
    let email: String
    let userName: String
}

//
//  BoardManager.swift
//  Krello
//
//  Created by Sujin Jin on 2022/05/12.
//

import Foundation

final class BoardManager {
    private let service = FirestoreService()
    private let userUid: String = "P3OuBRgwk2gZojfq8dmgkicz2fA2"

    func load(_ completion: @escaping ([String]) -> Void) {
        service.fetchBoards(userUid: userUid) { result in
            switch result {
            case .success(let boards):
                let boardTitles = boards.map { $0.title }
                completion(boardTitles)
            case .failure(let error):
                // TODO: - Error handle
                print(error)
            }
        }
    }
}

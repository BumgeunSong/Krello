//
//  BoardManager.swift
//  Krello
//
//  Created by Sujin Jin on 2022/05/12.
//

import Foundation

final class BoardManager {
    private let service = FirestoreService()
    private let userUID: UID
    private var boards = [Board]()
    var boardTitles: [String] {
        return boards.map { $0.title }
    }

    init(userUID: UID) {
        self.userUID = userUID
    }

    func loadInitialData(_ completion: @escaping (Bool?) -> Void) {
        service.fetchBoards(userUid: self.userUID) { result in
            switch result {
            case .success(let boards):
                let viewModels = boards
                self.boards = viewModels
                completion(true)
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadBoard(of index: Int) -> Board {
        return boards[index]
    }
}

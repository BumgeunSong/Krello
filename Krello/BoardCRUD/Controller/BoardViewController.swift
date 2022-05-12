//
//  BoardViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

import UIKit

class BoardViewController: UIViewController {

    let dummyStatus = ["To do", "In progress", "Done"]
    let dummyTasks = [
        ["ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ"],
        ["ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ", "ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ", "ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ", "ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ", "ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ"],
        ["test"]
    ]
    var boardName: String = "Dummy Board"

    var boardView: BoardView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureSubviews()
    }

    func configureNavBar() {
        navigationItem.title = boardName
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: nil, action: nil)
    }

    func configureSubviews() {
        let boardView = BoardView()
        boardView.setDelegate(self)
        boardView.setDataSource(self)
        boardView.setLayout(.krelloBoardLayout)

        self.boardView = boardView
        self.view = boardView
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        boardView?.setLayout(.krelloBoardLayout)
    }

}

extension BoardViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummyStatus.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {return UICollectionViewCell()}

        cell.configure(status: dummyStatus[indexPath.item], tasks: dummyTasks[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingIndicatorReusableView.identifier, for: indexPath) as? PagingIndicatorReusableView else {
            return UICollectionReusableView()
        }
        return footer
    }

}

extension BoardViewController: UICollectionViewDelegate {

}

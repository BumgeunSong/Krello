//
//  BoardViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

import UIKit

class BoardViewController: UIViewController {
    let dummyStatus = ["Todo", "In progress", "Done"]
    let dummyTasks = [
        ["Group 구조 기능 단위로 정리하기", "BoardViewController 구현하기"],
        ["로그인 UI 구현", "회원가입 UI 구현", "회원 가입 Validation 로직 구현", "Github Action 에러 해결", "UIKit Preview 기능 추가", "[할일 조회] FirestoreService 구현", "TableView 높이 해결", "Firestore 에서 데이터를 읽어오는 객체 구현 & BoardList 화면에 데이터 뿌리기", "login view 터치했을때 키보드가 내려갔는지 테스트", "AuthenticationManger 추가"],
        ["Pull Request, Issue 템플릿 적용"]
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

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as? BoardCollectionViewCell
        cell?.contentView.subviews.last?.removeFromSuperview()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {return UICollectionViewCell()}

        let taskVC = TaskViewController(status: dummyStatus[indexPath.item])
        cell.contentView.addSubview(taskVC.view)
        NSLayoutConstraint.activate([
            taskVC.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            taskVC.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            taskVC.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            taskVC.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        self.addChild(taskVC)
        taskVC.didMove(toParent: self)
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

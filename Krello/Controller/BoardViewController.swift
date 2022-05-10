//
//  BoardViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

import UIKit

class BoardViewController: UIViewController {

    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        view.backgroundColor =  .krelloGreen
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout = FlowLayoutMaker.createCompositionalLayout()
    }

    private func configureCollectionView() {
        let layout = FlowLayoutMaker.createCompositionalLayout()
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        self.collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)
        self.collectionView.register(PagingIndicatorReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingIndicatorReusableView.identifier)
        self.collectionView.backgroundColor = .krelloGreen
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {return UICollectionViewCell()}
//        let dataMock = TaskTableViewDataSource(status: "Todo", tasks: ["ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ"])
        cell.configure(status: "Todo", task: ["ㄱㄴㄷㄹ", "ㅁㅂㅅㅇ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ", "ㄱㄴㄷㄹ"])
        self.collectionView.setNeedsLayout()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingIndicatorReusableView.identifier, for: indexPath) as? PagingIndicatorReusableView else {
            return UICollectionReusableView()
        }
        return footer
    }

}

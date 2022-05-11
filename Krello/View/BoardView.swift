//
//  BoardView.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/11.
//

import UIKit

class BoardView: DefaultView {

    private lazy var collectionView: UICollectionView = {

        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: .krelloBoardLayout)

        collectionView.backgroundColor = .krelloGreen

        collectionView.alwaysBounceVertical = false

        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)

        collectionView.register(PagingIndicatorReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingIndicatorReusableView.identifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.clipsToBounds = false

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .krelloGreen
        createSubviews()
    }

    private func createSubviews() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setLayout(_ layout: UICollectionViewLayout) {
        collectionView.collectionViewLayout = layout
    }

    func setDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }

    func setDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
}

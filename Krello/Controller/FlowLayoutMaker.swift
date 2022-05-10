//
//  BoardCollectionView.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

import UIKit

enum FlowLayoutMaker {

    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(500))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .absolute(500))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(50))

        let orientation = UIDevice.current.orientation
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            section.orthogonalScrollingBehavior = .continuous
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        } else {
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: sectionFooterSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom)

            section.visibleItemsInvalidationHandler = { _, contentOffset, environment in
                  let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
                  print(currentPage)
            }
            section.boundarySupplementaryItems = [sectionFooter]
            section.orthogonalScrollingBehavior = .groupPagingCentered
            let layout = UICollectionViewCompositionalLayout(section: section)

            return layout
        }

    }

}

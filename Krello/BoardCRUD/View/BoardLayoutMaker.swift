//
//  BoardCollectionView.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

import UIKit

extension UICollectionViewLayout {
    static var krelloBoardLayout: UICollectionViewCompositionalLayout {
        let item = BoardLayoutMaker.createItem()
        let group = BoardLayoutMaker.createGroup(item)
        let section = BoardLayoutMaker.createSection(group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

enum BoardLayoutMaker {
    static func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0)

        return item
    }

    static func createGroup(_ item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.9))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        return group
    }

    static func createSection(_ group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let currentOrientation = UIDevice.current.orientation
        let isLandscape = currentOrientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
        return isLandscape ? createLandscapeSection(group) : createFortraitSection(group)
    }

    static func createLandscapeSection(_ group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    static func createFortraitSection(_ group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        let footer = createFooter()

        section.visibleItemsInvalidationHandler = { _, contentOffset, environment in
            let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
            print(currentPage)
        }
        section.boundarySupplementaryItems = [footer]
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    static func createFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(50))

        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)

        return sectionFooter
    }
}

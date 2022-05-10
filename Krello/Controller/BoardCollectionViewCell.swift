//
//  BoardCollectionViewCell.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/09.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {

    static let identifier = "BoardCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }

    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  BoardCollectionViewCell.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/09.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {

    static let identifier = "BoardCollectionViewCell"

    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.last?.removeFromSuperview()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureShadow()
        configureBackground()
        configureCornerRadius()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
        configureCornerRadius()
    }

    private func configureShadow() {
        layer.cornerRadius = 5
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 2, height: 2)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.masksToBounds = false
    }

    private func configureBackground() {
        contentView.backgroundColor = .krelloGray
    }

    private func configureCornerRadius() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

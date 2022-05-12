//
//  RoundedTableViewCell.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/11.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    static let identifier = "TaskTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureBackground()
        configureCornerRadius()
        configureShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureShadow() {
        layer.cornerRadius = 5
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 3, height: 3)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.masksToBounds = false
    }

    private func configureBackground() {
        backgroundColor = .krelloGray
        contentView.backgroundColor = .white
    }

    private func configureCornerRadius() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

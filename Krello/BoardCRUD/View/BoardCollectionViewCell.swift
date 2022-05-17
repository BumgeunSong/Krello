//
//  BoardCollectionViewCell.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/09.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {

    static let identifier = "BoardCollectionViewCell"

    lazy var taskStackView = TaskStackView(frame: contentView.bounds,
                                           delegate: self, dataSource: self,
                                           dragDelegate: self, dropDelegate: self)

    // TODO: String은 임시 데이터 타입이므로 모델 생성시 교체.
    var tasks: [String]?
    var status: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureShadow()
        configureBackground()
        configureCornerRadius()
        createSubviews()
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

    private func createSubviews() {
        contentView.addSubview(taskStackView)

        taskStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            taskStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            taskStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            taskStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])

    }

    func configure(status: String, tasks: [String]) {
        self.status = status
        taskStackView.headerLabel.text = "\(status)"

        self.tasks = tasks
        taskStackView.taskTableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

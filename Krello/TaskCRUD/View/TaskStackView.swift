//
//  TaskStackView.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/11.
//

import UIKit

class TaskStackView: UIStackView {

    lazy var headerLabel: UILabel = {
        let label = PaddedLabel()
        label.leftPadding = 16
        label.rightPadding = 16
        label.topPadding = 4
        label.bottomPadding = 4

        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var headerView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .krelloGray
        stackView.addArrangedSubview(headerLabel)
        return stackView
    }()

    lazy var taskTableView: UITableView = { [weak self] in
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)

        tableview.backgroundColor = .krelloGray

        tableview.delegate = tableViewDelegate
        tableview.dataSource = tableViewDataSource
        return tableview
    }()

    lazy var footerView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .krelloGray

        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.setTitle("Add Card", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        stackView.addArrangedSubview(button)
        return stackView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()

        return stackView
    }()

    var tableViewDelegate: UITableViewDelegate?
    var tableViewDataSource: UITableViewDataSource?

    init(frame: CGRect, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: frame)
        self.tableViewDelegate = delegate
        self.tableViewDataSource = dataSource

        axis = .vertical
        distribution = .fill
        alignment = .fill

        addArrangedSubviews([headerView, taskTableView, footerView])

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            footerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

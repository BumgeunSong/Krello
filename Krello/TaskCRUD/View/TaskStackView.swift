//
//  TaskStackView.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/11.
//

import UIKit

class TaskStackView: UIStackView {

    lazy var headerLabel: UILabel = {
        let label = PaddedLabel(padding: .init(top: 4, left: 16, bottom: 4, right: 16))
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var headerView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: stackView.bounds.width, height: 50))
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

        tableview.dragInteractionEnabled = true
        tableview.dropDelegate = tableViewDropDelegate
        tableview.dragDelegate = tableViewDragDelegate
        tableview.translatesAutoresizingMaskIntoConstraints = false

        return tableview
    }()

    lazy var footerView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: stackView.bounds.width, height: 50))
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
    var tableViewDragDelegate: UITableViewDragDelegate?
    var tableViewDropDelegate: UITableViewDropDelegate?

    init(frame: CGRect,
         delegate: UITableViewDelegate,
         dataSource: UITableViewDataSource,
         dragDelegate: UITableViewDragDelegate,
         dropDelegate: UITableViewDropDelegate) {
        super.init(frame: frame)
        self.tableViewDelegate = delegate
        self.tableViewDataSource = dataSource
        self.tableViewDragDelegate = dragDelegate
        self.tableViewDropDelegate = dropDelegate

        axis = .vertical
        distribution = .fill
        alignment = .fill

        addArrangedSubviews([headerView, taskTableView, footerView])

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            footerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }

    func setConstraints(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])

    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

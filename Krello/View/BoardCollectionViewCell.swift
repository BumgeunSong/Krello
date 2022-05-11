//
//  BoardCollectionViewCell.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/09.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {

    static let identifier = "BoardCollectionViewCell"

    // TODO: String은 임시 데이터 타입이므로 모델 생성시 교체.
    var tasks: [String]?
    var status: String?

    lazy var headerView: UIStackView = {
        let headerStackView = UIStackView()
        headerStackView.backgroundColor = .krelloYellow

        let label = UILabel()
        label.text = "Todo"
        headerStackView.addArrangedSubview(label)

        return headerStackView
    }()

    lazy var taskTableView: UITableView = { [weak self] in
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")

        tableview.backgroundColor = .krelloGray

        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()

    lazy var footerView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .krelloGray

        let label = UILabel()
        label.text = "Add Card"
        label.textColor = .white
        stackView.addArrangedSubview(label)

        return stackView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])

        stackView.addArrangedSubviews([headerView,
                                       footerView])
        print("Collection View Cell created")
    }

    func configure(status: String, task: [String]) {
        self.tasks = task
        self.status = status

        taskTableView.reloadData()
        taskTableView.layoutIfNeeded()
        print("TableView Reload")

        stackView.removeArrangedSubview(taskTableView)
        stackView.insertArrangedSubview(taskTableView, at: 1)
        print("Table View added in stack view")

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ...
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasks = tasks else {return 0}
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasks = tasks else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }

}

class TaskTableViewDataSource: NSObject, UITableViewDataSource {

    // TODO: String은 임시 데이터 타입이므로 모델 생성시 교체.
    let tasks: [String]
    let status: String

    // Status for header, tasks for populate cell
    init(status: String, tasks: [String]) {
        self.tasks = tasks
        self.status = status
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]

        return cell
    }
}

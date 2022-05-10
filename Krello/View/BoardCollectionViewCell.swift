//
//  BoardCollectionViewCell.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/09.
//

import UIKit

class TaskTableViewHeader: UITableViewHeaderFooterView {
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }

    func configure() {
        addSubview(title)
        title.frame = self.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoardCollectionViewCell: UICollectionViewCell {

    static let identifier = "BoardCollectionViewCell"

    var taskTableView: UITableView!
    // TODO: String은 임시 데이터 타입이므로 모델 생성시 교체.
    var tasks: [String]?
    var status: String?

    // Status for header, tasks for populate cell
    var headerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        configureHeaderView()
        configureTableView()
    }

    func  configureHeaderView() {
        headerView = UIView()
        let label = UILabel()
        headerView.backgroundColor = .brown
        label.text = "Todo"
        headerView.addSubview(label)
        self.contentView.addSubview(headerView)
        self.headerView.frame = self.contentView.bounds
//        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
//        ])
    }

    func configureTableView() {
        let uitableview = UITableView(frame: self.contentView.bounds, style: .insetGrouped)
        taskTableView = uitableview
        self.contentView.addSubview(taskTableView)
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        taskTableView.register(TaskTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "TaskTableViewHeader")
        taskTableView.backgroundColor = .secondarySystemBackground
        taskTableView.sectionHeaderHeight = 20
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.estimatedRowHeight = 60
        taskTableView.rowHeight = UITableView.automaticDimension
//        taskTableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            taskTableView.topAnchor.constraint(equalTo: headerView.topAnchor)
//        ])
    }

    func configure(status: String, task: [String]) {
        self.tasks = task
        self.status = status
//        self.taskTableView.dataSource = datasource
        taskTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TaskTableViewHeader") as? TaskTableViewHeader,
              let dataSource = tableView.dataSource as? TaskTableViewDataSource else { return UIView() }
        header.title.text = "\(dataSource.status)"
        return header
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

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "addCard"
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

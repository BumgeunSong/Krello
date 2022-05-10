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
        backgroundColor = .krelloGray
        addSubview(title)
        title.frame = self.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoardCollectionViewCell: UICollectionViewCell {

    var taskTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(taskTableView)
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        taskTableView.register(TaskTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "TaskTableViewHeader")

        taskTableView.sectionHeaderHeight = 20
        taskTableView.delegate = self
        taskTableView.frame = self.bounds
    }

    lazy var makeHeaderView: (String) -> UIView = { _ in
        let view = UIView()

        return view
    }

    func configure(with datasource: UITableViewDataSource) {
        self.taskTableView.dataSource = datasource
        taskTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TaskTableViewHeader") as? TaskTableViewHeader,
              let dataSource = tableView.dataSource as? TaskTableViewDataSource else { return UIView() }
        header.title.text = "\(dataSource.status)"
        return header
    }

    override func prepareForReuse() {
        taskTableView.dataSource = nil
        taskTableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ...
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

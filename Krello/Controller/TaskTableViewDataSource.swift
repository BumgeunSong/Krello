//
//  TaskTableViewDataSource.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/11.
//

import UIKit

extension BoardCollectionViewCell: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tasks = tasks else {return 0}
        return tasks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasks = tasks else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)

        cell.textLabel?.text = tasks[indexPath.section]

        return cell
    }
}

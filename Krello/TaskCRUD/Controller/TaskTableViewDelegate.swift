//
//  TaskTableViewDelegate.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/11.
//

import UIKit

extension BoardCollectionViewCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .krelloGray
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .krelloGray
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return view
    }
}

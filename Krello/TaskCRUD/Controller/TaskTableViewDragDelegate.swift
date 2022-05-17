//
//  TaskTableViewDragDelegate.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/12.
//

import UIKit
import MobileCoreServices

extension BoardCollectionViewCell: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let tasks = tasks, let taskData = tasks[indexPath.section].data(using: .utf8) else {
            return []
        }

        let itemProvider = NSItemProvider(item: taskData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (self, indexPath, tableView)
        return [dragItem]
    }

}

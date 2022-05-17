//
//  TaskTableViewDropDelegate.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/12.
//

import UIKit
import MobileCoreServices

extension BoardCollectionViewCell: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        guard coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) else {
            return
        }

        coordinator.session.loadObjects(ofClass: NSString.self) { [weak self] items in
            guard let draggedTask = items.first as? String else { return }

            var updatedIndexSets = IndexSet()

            let fromIndexPath = coordinator.items.first?.sourceIndexPath
            let toIndexPath = coordinator.destinationIndexPath

            switch (fromIndexPath, toIndexPath) {

            case (.some(let from), .some(let to)):
                if from.section < to.section {
                    updatedIndexSets = IndexSet(integersIn: from.section...to.section)
                } else {
                    updatedIndexSets = IndexSet(integersIn: to.section...from.section)
                }

                self?.taskStackView.taskTableView.beginUpdates()
                self?.tasks?.remove(at: from.section)
                self?.tasks?.insert(draggedTask, at: to.section)
                self?.taskStackView.taskTableView.reloadSections(updatedIndexSets, with: .automatic)
                self?.taskStackView.taskTableView.endUpdates()

            case (nil, .some(let to)):
                self?.removeFromTableData(localContext: coordinator.session.localDragSession?.localContext)

                self?.taskStackView.taskTableView.beginUpdates()
                self?.tasks?.insert(draggedTask, at: to.section)
                self?.taskStackView.taskTableView.insertSections(IndexSet(integer: to.section), with: .automatic)
                self?.taskStackView.taskTableView.endUpdates()

            case (nil, nil):
                self?.removeFromTableData(localContext: coordinator.session.localDragSession?.localContext)
                self?.taskStackView.taskTableView.beginUpdates()
                self?.tasks?.append(draggedTask)
                self?.taskStackView.taskTableView.insertSections(IndexSet(integer: (self?.tasks!.count)!-1), with: .automatic)
                self?.taskStackView.taskTableView.endUpdates()

            default: break
            }

        }

    }

    private func removeFromTableData(localContext: Any?) {
        guard let (dataSource, from, tableView) = localContext as? (BoardCollectionViewCell, IndexPath, UITableView) else { return }

        tableView.beginUpdates()
        dataSource.tasks?.remove(at: from.section)
        tableView.deleteSections(IndexSet(integer: from.section), with: .automatic)
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

}

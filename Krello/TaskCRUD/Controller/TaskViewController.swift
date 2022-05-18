//
//  TaskViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/18.
//

import UIKit

protocol TaskFetching {
    func fetch(status: String) -> [Task]
}

class TaskServiceMock: TaskFetching {
    func fetch(status: String) -> [Task] {
        return [Task(id: "ASDS234t6xc", title: "테스트1", status: .todo, contents: "오늘은", rowPosition: 0, createdAt: Date()),
         Task(id: "ASDS234t6xc", title: "테스트2", status: .inprogress, contents: "오늘은 ", rowPosition: 1, createdAt: Date()),
                Task(id: "ASDS234t6xc", title: "테스트3", status: .done, contents: "오늘은 ", rowPosition: 2, createdAt: Date())].filter({$0.status.rawValue == status})
    }

}

class TaskViewController: UIViewController {

    lazy var taskStackView = TaskStackView(frame: self.view.bounds,
                                           delegate: self, dataSource: self,
                                           dragDelegate: self, dropDelegate: self)
    private var tasks: [Task]?
    private var status: String
    private let taskService: TaskFetching = TaskServiceMock()

    init(status: String) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
        updateTable()
    }

    private func configureSubviews() {
        self.view.addSubview(taskStackView)
        taskStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            taskStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])

    }

    private func updateTable() {
        DispatchQueue.main.async {
            self.tasks = self.taskService.fetch(status: self.status)
            self.taskStackView.headerLabel.text = self.status
            self.taskStackView.taskTableView.reloadData()
        }
    }

}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate {

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

        cell.textLabel?.text = tasks[indexPath.section].title

        return cell
    }

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

extension TaskViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        guard let taskData = tasks?[indexPath.section] else {
            return []
        }

        let itemProvider = NSItemProvider(object: taskData)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (self, indexPath, tableView)
        return [dragItem]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

        coordinator.session.loadObjects(ofClass: Task.self) { [weak self] items in
            guard let draggedTask = items.first as? Task else { return }

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
        guard let (dataSource, from, tableView) = localContext as? (TaskViewController, IndexPath, UITableView) else { return }

        tableView.beginUpdates()
        dataSource.tasks?.remove(at: from.section)
        tableView.deleteSections(IndexSet(integer: from.section), with: .automatic)
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}

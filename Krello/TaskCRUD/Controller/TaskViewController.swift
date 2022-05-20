//
//  TaskViewController.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/18.
//

import UIKit

protocol TaskFetching {
    func fetch(status: Task.Status) -> [Task]
}

class TaskServiceMock: TaskFetching {
    func fetch(status: Task.Status) -> [Task] {
        return [Task(id: "ASDS234t6xc", title: "테스트1", status: .todo, contents: "오늘은", rowPosition: 0, createdAt: Date()),
                Task(id: "ASDS234dsadt6xc", title: "테스트2", status: .todo, contents: "오늘은 ", rowPosition: 1, createdAt: Date()),
                Task(id: "ASDS234t6xc", title: "테스트3", status: .done, contents: "오늘은 ", rowPosition: 2, createdAt: Date())].filter({$0.status == status})
    }

}

class TaskViewController: UIViewController {

    lazy var taskStackView = TaskStackView(frame: self.view.bounds)
    private var tableViewdataSource: UITableViewDataSource?
    private var tableViewDelegate: UITableViewDelegate?
    private var tableViewDragDelegate: UITableViewDragDelegate?
    private var tableViewDropDelegate: UITableViewDropDelegate?

    private var tasks = [Task]()
    private var status: Task.Status
    private let taskService: TaskFetching = TaskServiceMock()

    init(status: Task.Status) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureContraints()
        configureDisplay()
    }

    private func configureContraints() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        taskStackView.setConstraints(to: self.view)
    }

    private func configureSubviews() {
        self.view.addSubview(taskStackView)
    }

    private func configureDisplay() {
        setDataSource()
        updateTable()
        tableViewDelegate =  self
        tableViewDragDelegate = self
        tableViewDropDelegate = self
        self.taskStackView.taskTableView.delegate = tableViewDelegate
        self.taskStackView.taskTableView.dragDelegate = tableViewDragDelegate
        self.taskStackView.taskTableView.dropDelegate = tableViewDropDelegate
    }

    private func setDataSource() {
        self.tasks = taskService.fetch(status: self.status)
        let tableConfigurator = TableConfigurator <Task> { task, cell in
            cell.textLabel?.text = task.title
        } numberOfRowsInSection: { _ in
            1
        } numberOfSections: { models in
            models.count
        } titleForHeaderInSection: {nil}

        self.tableViewdataSource = TableViewDataSource(models: self.tasks,
                                                       reuseIdentifier: TaskTableViewCell.identifier,
                                                       tableConfigurator: tableConfigurator)
        self.taskStackView.taskTableView.dataSource = tableViewdataSource
    }

    private func updateTable() {
        self.taskStackView.tableViewDelegate = self
        DispatchQueue.main.async {
            self.taskStackView.headerLabel.text = self.status.rawValue
            self.taskStackView.taskTableView.reloadData()
        }
    }
}

extension TaskViewController: UITableViewDelegate {

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

        let taskData = tasks[indexPath.section]
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
                self?.tasks.remove(at: from.section)
                self?.tasks.insert(draggedTask, at: to.section)
                self?.taskStackView.taskTableView.reloadSections(updatedIndexSets, with: .automatic)
                self?.taskStackView.taskTableView.endUpdates()

            case (nil, .some(let to)):
                self?.removeFromTableData(localContext: coordinator.session.localDragSession?.localContext)

                self?.taskStackView.taskTableView.beginUpdates()
                self?.tasks.insert(draggedTask, at: to.section)
                self?.taskStackView.taskTableView.insertSections(IndexSet(integer: to.section), with: .automatic)
                self?.taskStackView.taskTableView.endUpdates()

            case (nil, nil):
                self?.removeFromTableData(localContext: coordinator.session.localDragSession?.localContext)
                self?.taskStackView.taskTableView.beginUpdates()
                self?.tasks.append(draggedTask)
                self?.taskStackView.taskTableView.insertSections(IndexSet(integer: (self?.tasks.count)!-1), with: .automatic)
                self?.taskStackView.taskTableView.endUpdates()

            default: break
            }

        }

    }

    private func removeFromTableData(localContext: Any?) {
        guard let (dataSource, from, tableView) = localContext as? (TaskViewController, IndexPath, UITableView) else { return }

        tableView.beginUpdates()
        dataSource.tasks.remove(at: from.section)
        tableView.deleteSections(IndexSet(integer: from.section), with: .automatic)
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
 }

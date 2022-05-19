//
//  BoardListTableViewController.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/09.
//

import UIKit

class BoardListViewController: UIViewController {
    private let boardManager: BoardManager
    private var dummy = [String]()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BoardListTableViewCell")
        return tableView
    }()

    init(boardManager: BoardManager) {
         self.boardManager = boardManager
         super.init(nibName: nil, bundle: nil)
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureContraints()
        configureDisplay()
    }

    private func configureSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func configureContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func configureDisplay() {
        loadViewData()
        setupNavigation()
    }

    private func loadViewData() {
        // TODO: - 초기 데이터를 가져오지 못했을경우 에러처리.: Firebase store 에서 에러를 어떻게 주는지 알아보기.
        boardManager.loadInitialData { [self] _ in
            self.dummy = self.boardManager.boardTitles
            self.tableView.reloadData()
        }
    }

    private func setupNavigation() {
        navigationItem.title = "Krello"
        navigationController?.navigationBar.backgroundColor = .krelloBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }
}

extension BoardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardListTableViewCell", for: indexPath)

        cell.textLabel?.text = dummy[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Boards"
    }
}

extension BoardListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Present Board!")
        let board = BoardViewController()
        navigationController?.pushViewController(board, animated: true)
    }
}

// Add this to see preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct BoardListTableViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // This is viewController you want to see.
            let destinationVC = BoardListViewController(boardManager: BoardManager(userUID: "P3OuBRgwk2gZojfq8dmgkicz2fA2"))
            let navigationViewController = UINavigationController(rootViewController: destinationVC)
            return navigationViewController
        }
        .previewDevice("iPhone 12")
    }
}
#endif

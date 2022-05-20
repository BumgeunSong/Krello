//
//  TableViewDataSource.swift
//  Krello
//
//  Created by Kai Kim on 2022/05/19.
//

import UIKit
struct TableConfigurator<Model> {
     let cellConfigurator: (Model, UITableViewCell) -> Void
     let numberOfRowsInSection: ([Model]) -> Int
     let numberOfSections: ([Model]) -> Int
}

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {

    var tableConfigurator: TableConfigurator<Model>
    var models: [Model]

    private let reuseIdentifier: String

    init(models: [Model], reuseIdentifier: String, tableConfigurator: TableConfigurator<Model>) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.tableConfigurator = tableConfigurator
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableConfigurator.numberOfSections(models)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableConfigurator.numberOfRowsInSection(models)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        tableConfigurator.cellConfigurator(models[indexPath.item], cell)
        return cell
    }

}

//
//  FactsViewController.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    
    var tableView = UITableView()
    let cellId = "DataCell"
    var safeArea: UILayoutGuide!

    var factsArray: [Rows]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.safeArea = view.layoutMarginsGuide
        self.tableView.register(DataTableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.setupTableView()
        RetrieveFactsService.fetchAllFacts { facts in
            self.title = facts?.title
            guard let factsArray = facts?.rows else { return }
                self.factsArray = FactsModel.removedNilObjectsFromRows(rows: factsArray)
            self.tableView.reloadData()
        }
    }

    func setupTableView() {
        self.tableView.dataSource = self
        view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        self.tableView.anchor(top: self.safeArea.topAnchor, left: self.safeArea.leftAnchor, bottom: self.safeArea.bottomAnchor, right: self.safeArea.rightAnchor,
                         paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
}

extension FactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let factsArray = self.factsArray else { return 0 }
        return factsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as? DataTableViewCell, let factsArray = self.factsArray else { return UITableViewCell() }

        cell.dataModel = factsArray[indexPath.row]
        return cell
    }
}

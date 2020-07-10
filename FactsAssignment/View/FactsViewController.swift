//
//  FactsViewController.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit
import ProgressHUD

class FactsViewController: UIViewController {
    
    var tableView = UITableView()
    let cellId = "DataCell"
    var safeArea: UILayoutGuide!

    var factsArray: [Rows]?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        ]
        
        self.safeArea = view.layoutMarginsGuide
        self.tableView.register(DataTableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.setupTableView()

        ProgressHUD.animationType = .circleStrokeSpin
//        ProgressHUD.colorHUD = .orange
        ProgressHUD.colorAnimation = .orange
        ProgressHUD.show()
        refreshControl.tintColor = UIColor.orange
        self.refreshFactsData()
    }

    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension

        self.tableView.anchor(top: self.safeArea.topAnchor, left: self.safeArea.leftAnchor, bottom: self.safeArea.bottomAnchor, right: self.safeArea.rightAnchor,
                         paddingTop: 10, paddingLeft: 0, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    tableView.tableFooterView = UIView()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshFactsData), for: .valueChanged)

    }
    
    @objc func refreshFactsData() {
        RetrieveFactsService.fetchAllFacts { facts in
            self.title = facts?.title
            guard let factsArray = facts?.rows else { return }
                self.factsArray = FactsModel.removedNilObjectsFromRows(rows: factsArray)
            self.tableView.reloadData()
            ProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
        }
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

extension FactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DataTableViewCell else { return }
        if cell.dataImageView.image == nil {
//            cell.dataImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
//            cell.dataImageView.heightAnchor.constraint(equalToConstant: 0).isActive = false
        }
//        cell.layoutIfNeeded()
    }
}

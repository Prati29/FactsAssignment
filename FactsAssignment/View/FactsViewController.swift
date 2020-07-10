//
//  FactsViewController.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit
import ProgressHUD
import Alamofire

class FactsViewController: UIViewController {
    
    var tableView = UITableView()
    let cellId = "DataCell"
    var safeArea: UILayoutGuide!

    var factsArray: [Rows]?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.orange,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        ]
        
        self.safeArea = view.layoutMarginsGuide
        self.setupTableView()

        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorAnimation = .orange
        ProgressHUD.show()
        
        refreshControl.tintColor = UIColor.orange
        self.refreshFactsData()
    }

    func setupTableView() {
        self.tableView.register(DataTableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.tableView.dataSource = self
        view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension

        self.tableView.anchor(top: self.safeArea.topAnchor,
                              left: self.safeArea.leftAnchor,
                              bottom: self.safeArea.bottomAnchor,
                              right: self.safeArea.rightAnchor,
                              paddingTop: 10,
                              paddingLeft: 0,
                              paddingBottom: 20,
                              paddingRight: 10,
                              width: 0,
                              height: 0,
                              enableInsets: false)
    tableView.tableFooterView = UIView()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshFactsData), for: .valueChanged)

    }
    
    @objc func refreshFactsData() {
        if NetworkReachabilityManager()!.isReachable {
            RetrieveFactsService.fetchAllFacts { facts in
                self.title = facts?.title
                guard let factsArray = facts?.rows else { return }
                self.factsArray = FactsViewModel.removeNilObjectsFromRows(rows: factsArray)
                self.tableView.reloadData()
                ProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
            }
        } else {
            ProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
            self.alert(message: "No internet connect", title: "Error")
        }
    }
}

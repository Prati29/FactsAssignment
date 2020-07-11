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
import CocoaLumberjack

/// Controller class to load facts on UI.
class FactsViewController: UIViewController {
    
    // MARK: Constants
    
    /// Cell reuse identifier for loading cell in tableview.
    let cellIdentifier = "DataCell"
    
    /// String constant for alert title
    private static let alertTitle = "ALERT_TITLE"

    /// String constant for alert message
    private static let alertMessage = "ALERT_MESSAGE"

    /// Activity indicator to show on pull to refresh.
    private let refreshControl = UIRefreshControl()

    // MARK: Variables
    
    /// Tableview to show facts.
    var tableView = UITableView()
    
    /// `UILayoutGuide` object to add constaints programatically.
    private var safeArea: UILayoutGuide!
    
    /// Array variable to store facts retrived from service.
    private(set) var rowsArray: [Rows]?

    private var reachability: NetworkReachabilityManager!

    private var isPageLoaded = false
    
    // MARK: View Methods
    
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
        reachability = NetworkReachabilityManager.default
        self.monitorReachability()
        self.refreshFactsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DDLogInfo("FactsViewController appeard.")
    }

    // MARK: Private Methods

    private func monitorReachability() {
        reachability.startListening { status in
            print("Reachability Status Changed: \(status)")
            if status == .notReachable || status == .unknown {
                DDLogError("Network not reachable - \(status)")
            } else {
                if !self.isPageLoaded {
                    self.refreshFactsData()
                }
            }
        }
    }
    
    /// To setup tableview and its constraints.
    private func setupTableView() {
        self.tableView.register(RowTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
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
    
    /// Selector to refresh facts data on pull to refresh.
    @objc private func refreshFactsData() {
        if reachability.isReachable {
            RetrieveFactsService.fetchAllFacts { facts in
                self.title = facts?.title
                guard let rowsArray = facts?.rows else { return }
                self.rowsArray = FactsViewModel.removeNilObjectsFromRows(rows: rowsArray)
                self.tableView.reloadData()
                ProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
                self.isPageLoaded = true
            }
        } else {
            ProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
            self.isPageLoaded = false
            DDLogError(type(of: self).alertMessage)
            self.alert(
                message: NSLocalizedString(type(of: self).alertMessage, comment: ""),
                title: NSLocalizedString(type(of: self).alertTitle, comment: ""))
        }
    }
}

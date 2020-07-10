//
//  FactsViewController + DataSource.swift
//  FactsAssignment
//
//  Created by Savita Pal on 11/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit

extension FactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let factsArray = self.factsArray else { return 0 }
        return factsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as? DataTableViewCell,
            let factsArray = self.factsArray
            else { fatalError("Unexpected Table View Cell") }

        cell.factModel = factsArray[indexPath.row]
        return cell
    }
}

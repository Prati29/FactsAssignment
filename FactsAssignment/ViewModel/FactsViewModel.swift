//
//  FactsViewModel.swift
//  FactsAssignment
//
//  Created by Pratiksha Pawale on 11/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

/// ViewModel class for Facts.
class FactsViewModel {
    
    /**
    Removed objects from array if all keys have .
    
    - Parameters:
       - title: Title of row.
       - description: Description of row.
       - imageHref: Image url of row.
    
    */
    static func removeNilObjectsFromRows(rows: [Rows]) -> [Rows] {
        var newRows = [Rows]()
        for item in rows {
            if item.title != "" || item.description != "" || item.imageHref != "" {
                newRows.append(item)
            }
        }
        return newRows
    }
}

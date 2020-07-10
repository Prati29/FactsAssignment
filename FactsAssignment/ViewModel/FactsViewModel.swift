//
//  FactsViewModel.swift
//  FactsAssignment
//
//  Created by Savita Pal on 11/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

class FactsViewModel {
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

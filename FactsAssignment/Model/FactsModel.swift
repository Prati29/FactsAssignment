//
//  FactsModel.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

struct FactsModel: Codable {
    let title: String
    let rows: [Rows]!
}

struct Rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}

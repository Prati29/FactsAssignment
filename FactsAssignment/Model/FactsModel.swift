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

class Rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
    
    init(title: String?, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.imageHref = try container.decodeIfPresent(String.self, forKey: .imageHref) ?? ""

    }
}

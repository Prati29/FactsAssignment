//
//  FactsModel.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

/// Model class for facts.
struct FactsModel: Codable {
    
    /// Heading of all facts.
    let title: String
    
    /// Array of rows in facts.
    let rows: [Rows]!
}

/// Model class for rows in facts.
class Rows: Codable {
    
    // MARK: Variables
    
    /// Title of row.
    var title: String?
    
    /// Description of row.
    var description: String?
    
    /// Image of row.
    var imageHref: String?
    
    /// Enum for coding keys of rows.
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
    
    // MARK: Initializers
    
    /**
     Initializer for row model class.
     
     - Parameters:
        - title: Title of row.
        - description: Description of row.
        - imageHref: Image url of row.
     
     */
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

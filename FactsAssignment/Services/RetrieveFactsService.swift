//
//  RetrieveFactsService.swift
//  FactsAssignment
//
//  Created by Savita Pal on 10/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import Alamofire
import SwiftyJSON

class RetrieveFactsService {
    static func fetchAllFacts(completion: @escaping ([Facts]?) -> Void) {
        
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            completion(nil)
            return
        }
        
        AF.request(url,
                   method: .get)
            .validate()
            .responseData { response in
                guard let data = response.data else { return }
                guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else { return }
                guard let properData = string.data(using: .utf8, allowLossyConversion: true) else { return }
                
                do {
                    let factsJSON = try JSON(data: properData)
                    print(factsJSON)
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(Facts.self, from: properData)
                    print(json)
                } catch {
                    print(error)
                }
                
        }
    }
}

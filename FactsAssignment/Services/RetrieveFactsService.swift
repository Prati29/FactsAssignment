//
//  RetrieveFactsService.swift
//  FactsAssignment
//
//  Created by Savita Pal on 10/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import Alamofire

public class RetrieveFactsService {
    static func fetchAllFacts(completion: @escaping (FactsModel?) -> Void) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            completion(nil)
            return
        }
        
        AF.request(url,
                   method: .get)
            .validate()
            .responseData { response in
                // To change String encoding from isoLatin1 to utf8
                guard let responseData = response.data,
                    let stringFromData = String(data: responseData, encoding: String.Encoding.isoLatin1),
                    let validData = stringFromData.data(using: .utf8, allowLossyConversion: true)
                    else {
                        completion(nil)
                        return
                }
                do {
                    let factsJSON = try JSONDecoder().decode(FactsModel.self, from: validData)
                    completion(factsJSON)
                } catch {
                    completion(nil)
                }
        }
    }
}

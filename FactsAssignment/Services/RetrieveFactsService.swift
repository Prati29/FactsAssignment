//
//  RetrieveFactsService.swift
//  FactsAssignment
//
//  Created by Savita Pal on 10/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import Alamofire

class RetrieveFactsService {
    static func fetchAllFacts(completion: @escaping (FactsModel?) -> Void) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            completion(nil)
            return
        }
        
        AF.request(url,
                   method: .get)
            .validate()
            .responseData { response in
                guard let responseData = response.data else { return }
                guard let stringFromData = String(data: responseData, encoding: String.Encoding.isoLatin1) else { return }
                guard let validData = stringFromData.data(using: .utf8, allowLossyConversion: true) else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(FactsModel.self, from: validData)
                    completion(json)
                } catch {
                    print(error)
                }
                
        }
    }
}

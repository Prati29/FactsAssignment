//
//  RetrieveFactsService.swift
//  FactsAssignment
//
//  Created by Savita Pal on 10/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import Alamofire
import CocoaLumberjack

/// Service class to fetch all facts from server.
public class RetrieveFactsService {
    
    // MARK: - Constants
    
    /// Server url for facts.
    private static let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    // MARK: - Public method
    
    /**
     Fetches facts from server.
     
     - Parameters:
        - completion: Completion block with all facts retrieved.
     */
    static func fetchAllFacts(completion: @escaping (FactsModel?) -> Void) {
        DDLogInfo("Fetch all facts service method.")
        guard let url = URL(string: RetrieveFactsService.urlString) else {
            DDLogError("Invalid url for facts service.")
            completion(nil)
            return
        }
        
        DDLogInfo("Facts service call initiated.")
        AF.request(url,
                   method: .get)
            .validate()
            .responseData { response in
                DDLogInfo("Facts service call response received.")
                // To change String encoding from isoLatin1 to utf8
                guard let responseData = response.data,
                    let stringFromData = String(data: responseData, encoding: String.Encoding.isoLatin1),
                    let validData = stringFromData.data(using: .utf8, allowLossyConversion: true)
                    else {
                        DDLogError("Corrupted data in response.")
                        completion(nil)
                        return
                }
                do {
                    let factsJSON = try JSONDecoder().decode(FactsModel.self, from: validData)
                    DDLogInfo("Facts service call completed with response.")
                    completion(factsJSON)
                } catch {
                    DDLogError("Error in decoding data to json.")
                    completion(nil)
                }
        }
    }
}

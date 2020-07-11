//
//  FactsAssignmentTests.swift
//  FactsAssignmentTests
//
//  Created by Pratiksha Pawale on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import XCTest
import Hippolyte

@testable import FactsAssignment

class RetrieveFactsServiceTest: XCTestCase {

    let stubbedResponse: FactsModel = FactsModel(title: "About Canada", rows: [
        Rows(
            title: "Beavers",
            description: "Beavers are second only to humans in their ability to manipulate and change their environment. ",
            imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        ),
        Rows(
            title: "Flag",
            description: nil,
            imageHref: "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
        )])
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAllFacts() {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
         var stub = StubRequest(method: .GET, url: url)
         var response = StubResponse()
        guard let body = try? JSONEncoder().encode(stubbedResponse) else { return }
         response.body = body
         stub.response = response
         Hippolyte.shared.add(stubbedRequest: stub)
         Hippolyte.shared.start()
        
        let expectation = self.expectation(description: "Scaling")

        RetrieveFactsService.fetchAllFacts { facts in
            XCTAssertEqual(facts?.rows.count, self.stubbedResponse.rows.count)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

    }
}

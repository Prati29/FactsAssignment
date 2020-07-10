//
//  FactsViewModelTest.swift
//  FactsAssignmentTests
//
//  Created by Savita Pal on 11/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import XCTest

class FactsViewModelTest: XCTestCase {

    var rows = [Rows(title: "", description: "", imageHref: ""),
    Rows(title: "Flag", description: "", imageHref: "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png")]
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRemoveNilObjectsFromRows() {
        let updatedRows = FactsViewModel.removeNilObjectsFromRows(rows: rows)
        XCTAssertEqual(updatedRows.count, rows.count - 1)
    }
}

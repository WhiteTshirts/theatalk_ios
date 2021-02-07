//
//  ModelTest.swift
//  theatalk-iosTests
//
//  Created by riku iwasaki on 2021/02/08.
//

import XCTest

class ModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var i = Room(admin_id_: 0, name_: "0", id_: 0, is_private_: false, start_time_: Date(), viewer_: 0, youtube_id_: "")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  theatalk_iosTests.swift
//  theatalk-iosTests
//
//  Created by riku iwasaki on 2020/12/16.
//

import XCTest
@testable import theatalk_ios

class theatalk_iosTests: XCTestCase {
    var R = Room(admin_id_: 0, name_: "a", id_: 0, is_private_: false, start_time_: Date(), viewer_: 0, youtube_id_: "aa")
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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

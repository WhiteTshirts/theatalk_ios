//
//  RoomTest.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/08.
//

import XCTest
class RoomTest: XCTestCase {
    override func setUpWithError() throws {
        var i = Room_(admin_id_: 0, name_: "", id_: 0, is_private_: false, start_time_: Date(), viewer_: 0, youtube_id_: "0")
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
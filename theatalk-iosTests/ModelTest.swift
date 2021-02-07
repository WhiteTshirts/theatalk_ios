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
        guard let url = Bundle.main.url(forResource: "rooms", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
         
        /// ②employees.jsonの内容をData型プロパティに読み込み
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
         
        /// ③JSONデコード処理
        let decoder = JSONDecoder()
        guard let rooms = try? decoder.decode(Rooms.self, from: data) else {
            fatalError("JOSN読み込みエラー")
        }
        print(rooms.rooms[0].created_at)
        print(rooms.rooms[0])
         
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

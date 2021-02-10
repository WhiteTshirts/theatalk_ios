//
//  ModelTest.swift
//  theatalk-iosTests
//
//  Created by riku iwasaki on 2021/02/08.
//

import XCTest
import Combine
class ModelTest: XCTestCase,ObservableObject {
    var disposables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let url = Bundle.main.url(forResource: "rooms", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
         
        /// ②employees.jsonの内容をData型プロパティに読み込み
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
        let decoder = JSONDecoder()
        guard let rooms = try? decoder.decode(Rooms.self, from: data) else {
            fatalError("JOSN読み込みエラー")
        }
        let fe = RoomFetcher(url: "localhost:5000").GETRooms()
            .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  break
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] forecast in
                guard let self = self else { return }
            })
            .store(in: &disposables)
        let ta = TagFetcher(url: "localhost:5000").GETTags()
            .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  break
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] forecast in
                print("jfsdjfldsfjfldsfjsd")
                print(forecast.tags[0].name)
                guard let self = self else { return }
            })
            .store(in: &disposables)

                
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

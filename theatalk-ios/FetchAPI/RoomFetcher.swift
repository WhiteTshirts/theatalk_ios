//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
import Combine
protocol RoomFechable {
    func GETRooms(
    ) -> AnyPublisher<Rooms,APIError>
    func EnterRoom(
        roomId:Int
    ) -> AnyPublisher<Room,APIError>
//    func GETRoomsWithTag(
//         tagId: Int
//    ) -> AnyPublisher<Rooms,APIError>
//    func GetRoom(
//        forRoomId roomId: Int
//    ) -> AnyPublisher<Room,APIError>
//    func PostRoom(
//        forRoom room: Room
//    ) -> AnyPublisher<Room,APIError>
//    func EditRoom(
//        forRoom room: Room
//    ) ->AnyPublisher<Room,APIError>
//    func DeleteRoom(
//        forRoom room:Room
//    ) -> AnyPublisher<Void,APIError>
    
}
class RoomFetcher{
    private var urllink=""
    private var host = "http://localhost:5000"
    let encoder = JSONEncoder()
    var fetcher  = Fetcher()
    private let session: URLSession
    @Published var roomData: [Room]=[]
    init(url:String,session: URLSession = .shared){
        urllink = url
        self.session = session
    }
    func exitRoom(){
        
    }


    private func fetchRoom<T>(
        with reqcomponents: URLRequest
    ) -> AnyPublisher<T, APIError> where T: Decodable {
//      guard let url = components.url else {
//        let error = APIError.network(description: "Couldn't create URL")
//        return Fail(error: error).eraseToAnyPublisher()
//      }
      return session.dataTaskPublisher(for: reqcomponents)
        .mapError { error in
          .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
          decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
    

  }
extension RoomFetcher{
    func makeGetRoomsComponents(
    ) -> URLRequest {

        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1/rooms"
        let components = URLRequest(url:url_components.url!)
        
      return components
    }
    func makeEnterRoomComponents(
        roomId:Int, body:Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1/room_users"
        var components = URLRequest(url:url_components.url!)
        components.addValue("application/json", forHTTPHeaderField: "content-type")
        components.httpMethod = "POST"
        components.setValue("Bearer \(mockUserHashVal)", forHTTPHeaderField: "Authorization")
        if(body != nil){
            components.httpBody = body
        }
      return components
    }
}


extension RoomFetcher: RoomFechable{
    func GETRooms() -> AnyPublisher<Rooms, APIError> {
        return fetchRoom(with: makeGetRoomsComponents())
    }
    func EnterRoom(
        roomId:Int
    ) -> AnyPublisher<Room,APIError>{
        var body:Data!
        var room_info = Dictionary<String,Any>()
        room_info["room_id"] = roomId
        var jobj = Dictionary<String,Any>()
        jobj["user"] = room_info
        do {
            body = try JSONSerialization.data(withJSONObject: jobj, options: [])
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)\n")
        }
        return fetchRoom(with: makeEnterRoomComponents(roomId: roomId, body: body))
    }
//    func GETRoomsWithTag(forTag tag: Int) -> AnyPublisher<Rooms, APIError> {
//        var body:Data!
//        var room_info = Dictionary<String,Any>()
//        room_info["room_id"] = roomId
//        var jobj = Dictionary<String,Any>()
//        jobj["user"] = room_info
//        do {
//            body = try JSONSerialization.data(withJSONObject: jobj, options: [])
//        } catch let encodeError as NSError {
//            print("Encoder error: \(encodeError.localizedDescription)\n")
//        }
//        return fetchRoom(with: makeEnterRoomComponents(roomId: roomId, body: body))
//    }
//
//    func GetRoom(forRoomId roomId: Int) -> AnyPublisher<Room, APIError> {
//
//    }
//
//    func PostRoom(forRoom room: Room) -> AnyPublisher<Room, APIError> {
//
//    }
//
//    func EditRoom(forRoom room: Room) -> AnyPublisher<Room, APIError> {
//
//    }
//
//    func DeleteRoom(forRoom room: Room) -> AnyPublisher<Void, APIError> {
//
//    }
//
    
    
}

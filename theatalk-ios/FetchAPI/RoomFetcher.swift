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
    ) -> AnyPublisher<Rooms_json,APIError>
    func EnterRoom(
        roomId:Int
    ) -> AnyPublisher<Room_json,APIError>
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
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        //iso8601 2018-01-08T02:51:37Z
    }


    private func fetchRoom<T>(
        with reqcomponents: URLRequest
    ) -> AnyPublisher<T, APIError> where T: Decodable {
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
    func makeRoomsComponents(Path:String,Type:String,body: Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1"+Path
        var components = URLRequest(url:url_components.url!)
        components.httpMethod = Type
        components.addValue("application/json", forHTTPHeaderField: "content-type")
        if(g_user_token != nil){
            components.setValue("Bearer \(g_user_token)", forHTTPHeaderField: "Authorization")
        }
        if(body != nil){
            components.httpBody = body
        }
      return components
    }
}


extension RoomFetcher: RoomFechable{
    
    func GetRoom(
        roomId:Int
    )->AnyPublisher<Room_json,APIError>{
        return fetchRoom(with: makeRoomsComponents(Path: "/rooms/\(roomId)", Type: "GET", body: nil))
    }
    func GETRooms() -> AnyPublisher<Rooms_json, APIError> {
        return fetchRoom(with: makeRoomsComponents(Path: "/rooms", Type: "GET", body: nil))
    }
    func CreateRoom(room:Room) -> AnyPublisher<Room_json,APIError>{
        do{
            let data = try encoder.encode(room)
            return fetchRoom(with: makeRoomsComponents(Path: "/rooms", Type: "POST", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
    }
    func EditRoom(room:Room) -> AnyPublisher<Room_json,APIError>{

        if let roomId = room.id{
            do{
                let data = try encoder.encode(room)
                return fetchRoom(with: makeRoomsComponents(Path: "/rooms/\(roomId)", Type: "PUT", body: data))
            }catch{
                let error = APIError.network(description: "could not encode")
                return Fail(error: error).eraseToAnyPublisher()
            }
        }else{
            let error = APIError.network(description: "could not edit room")
            return Fail(error: error).eraseToAnyPublisher()
        }

    }
    func EnterRoom(
        roomId:Int
    ) -> AnyPublisher<Room_json,APIError>{
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
        return fetchRoom(with: makeRoomsComponents(Path: "/room_users", Type:"POST", body: body))
    }
    func ExitRoom()-> AnyPublisher<User,APIError>{
        return fetchRoom(with: makeRoomsComponents(Path: "/room_users/leave", Type: "GET", body: nil))
    }
    func GetSameRoomUsers()->AnyPublisher<Users_Json,APIError>{
        return fetchRoom(with: makeRoomsComponents(Path: "/room_users", Type: "GET", body: nil))
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

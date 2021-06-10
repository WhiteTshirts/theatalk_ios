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
class RoomFetcher:Fetcher{
    @Published var roomData: [Room]=[]
    override init(session: URLSession = .shared){
        super.init()
        //iso8601 2018-01-08T02:51:37Z
    }

  }


extension RoomFetcher: RoomFechable{
    
    func GetRoom(
        roomId:Int
    )->AnyPublisher<Room_json,APIError>{
        return fetchData(with: makeComponents(Path: "/rooms/\(roomId)", Type: "GET", body: nil))
    }
    func GETRooms() -> AnyPublisher<Rooms_json, APIError> {
        return fetchData(with: makeComponents(Path: "/rooms", Type: "GET", body: nil))
    }
    
    func GetRoomsHistory()->AnyPublisher<Rooms_json, APIError> {
        return fetchData(with: makeComponents(Path: "/room_histories", Type: "GET", body: nil))
    }
    func CreateRoom(room:Room) -> AnyPublisher<Room_json,APIError>{

        do{
            let data = try encoder.encode(room)
            return fetchData(with: makeComponents(Path: "/rooms", Type: "POST", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
    }
    func EditRoom(room:Room) -> AnyPublisher<Room_json,APIError>{

        if let roomId = room.id{
            do{
                let data = try encoder.encode(room)
                return fetchData(with: makeComponents(Path: "/rooms/\(roomId)", Type: "PUT", body: data))
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
        return fetchData(with: makeComponents(Path: "/room_users", Type:"POST", body: body))
    }
    func ExitRoom()-> AnyPublisher<User,APIError>{
        return fetchData(with: makeComponents(Path: "/room_users/leave", Type: "GET", body: nil))
    }
    func GetSameRoomUsers()->AnyPublisher<Users_Json,APIError>{
        return fetchData(with: makeComponents(Path: "/room_users", Type: "GET", body: nil))
    }
    func GETRoomsbyTag(tagId:Int)->AnyPublisher<Rooms_json,APIError>{
        return fetchData(with: makeComponents(Path: "/room_tags/\(tagId)", Type: "GET", body: nil))
    }
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

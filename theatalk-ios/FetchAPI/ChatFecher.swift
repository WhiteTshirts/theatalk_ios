//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
import Combine

class ChatFetcher:Fetcher{
    @Published var chatData: [Chat]=[]

    init(){
        super.init()
 
        //iso8601 2018-01-08T02:51:37Z
    }

    func sendChatData(msg:String,room_Id:Int)->AnyPublisher<Chat_Json,APIError>{
        let chat = Chat(user_id_: 0, text_: msg, created_at_: Date())

        do {
            let data = try encoder.encode(chat)
            return fetchData(with: makeComponents(Path: "/rooms/\(room_Id)/chats", Type: "POST", body: data))
        } catch{
            let error = APIError.encoding(description: "could not encode data")
            return Fail(error: error).eraseToAnyPublisher()
        }

    }
    func GetChats()->AnyPublisher<Chats_Json,APIError>{

        return  fetchData(with: makeComponents(Path: "/rooms/0/chats", Type: "GET", body: nil))
    }
    func ExitRoom()-> AnyPublisher<User,APIError>{
        return fetchData(with: makeComponents(Path: "/room_users/leave", Type: "GET", body: nil))
    }

}

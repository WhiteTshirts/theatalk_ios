//
//  ChatViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine


var mockChatsData:[Chat] = [Chat(user_name_:"test1",user_id_: 0, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_name_:"test1",user_id_: 0, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_name_:"test1",user_id_: 0, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_name_:"test1",user_id_: 0, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_name_:"test1",user_id_: 0, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_name_:"test1",user_id_: 0, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_id_: 3, comment_: "いいいいいいiiii", created_at_: Date()),Chat(user_name_:"test3",user_id_: 5, comment_: "あああああああああああああああああああああああああああああああ", created_at_: Date()),Chat(user_id_: 6, comment_: "うううううううううううううう", created_at_: Date()),Chat(user_id_: 7, comment_: "7777777777777777777", created_at_: Date()),Chat(user_id_: 8, comment_: "888888888888888888888888888888888888888", created_at_: Date())]

final class ChatsViewModel: ObservableObject{
    @Published var chats: [Chat] = []
    private var chatfetcher = ChatFetcher(url: "http://localhost:5000/api/v1/rooms/0")
    init(){
        load()
    }
    func load(){
        self.chats = mockChatsData
//        roomfetcher.fetchRoomData{
//            returnData in
//            print(returnData)
//            self.rooms = returnData
//        }
    }
    func recv(chat: Chat){
        chats.append(chat)
    }
    func SendMsg(msg:String){
        
    }
    
    
    
}


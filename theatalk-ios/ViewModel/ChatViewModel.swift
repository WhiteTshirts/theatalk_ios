//
//  ChatViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine
protocol ChatRecv {
    func chatreceive(chat: String)
}

final class ChatsViewModel: ObservableObject,ChatRecv{
    var chatwb = ChatWBSocket()
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
    func enter(){
        
        chatwb.SubscribeChannel(path: "/", token: mockUserHashVal,delegate: self)
    }
    func chatreceive(chat: String){
        print(chat)
        var chat_ = Chat(user_name_: "aaa", user_id_: 23, comment_: chat, created_at_: Date())
        chats.append(chat_)
        print(chats.count)
    }
    func SendMsg(msg:String,roomId:Int){
        chatfetcher.sendChatData(msg: msg, room_Id: roomId)
    }
    
    
    
}


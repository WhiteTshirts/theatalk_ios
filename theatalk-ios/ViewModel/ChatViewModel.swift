//
//  ChatViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine
protocol ChatRecv {
    func chatreceive(chat: Chat)
}

final class ChatsViewModel: ObservableObject,ChatRecv{
    var chatwb = ChatWBSocket()
    @Published var chats: [Chat] = []
    private var chatfetcher = ChatFetcher(url: "http://localhost:5000/api/v1/rooms/0")
    init(room_Id:Int){
        //print("initialize chat")
        //load(room_Id: room_Id)
    }
    func load(room_Id:Int){
        chatfetcher.fetchChatData(room_Id:room_Id){
            returnData in
            self.chats = returnData
        }
    }
    func enter(){
        
        chatwb.SubscribeChannel(path: "/", token: mockUserHashVal,delegate: self)
    }
    func chatreceive(chat: Chat){
        chats.insert(chat, at: 0)
    }
    func SendMsg(msg:String,roomId:Int){
        chatfetcher.sendChatData(msg: msg, room_Id: roomId)
    }
    
    
    
}


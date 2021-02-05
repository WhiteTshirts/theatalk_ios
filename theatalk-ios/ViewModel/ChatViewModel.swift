//
//  ChatViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine


final class ChatsViewModel: ObservableObject{
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
        chatwb.SubscribeChannel(path: "/", token: "token")
    }
    func recv(chat: Chat){
        chats.append(chat)
    }
    func SendMsg(msg:String){
        
    }
    
    
    
}


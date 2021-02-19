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
    private var disposables = Set<AnyCancellable>()
    var isLoading = false
    var isSending = false
    var chatwb = ChatWBSocket()
    @Published var chats: [Chat] = []
    private var chatfetcher = ChatFetcher(url: "http://localhost:5000/api/v1/rooms/0")
    init(){
        self.load(room_Id: 0)
        self.enter()
    }
    func load(room_Id:Int){
        self.chatfetcher.GetChats(roomId: room_Id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else  { return}
                switch value{
                    case .failure:
                        self.isLoading = false
                        
                    break
                case .finished:
                    break
                }
            }, receiveValue: {[weak self] chats_json in
                guard let self = self else { return }
                if(chats_json.chats != nil){
                    self.chats = chats_json.chats
                    
                    self.isLoading = false
                    
                }

            }).store(in: &disposables)
    }
    func enter(){
        
        self.chatwb.SubscribeChannel(path: "/", token: g_user_token,delegate: self)
        
    }
    func exit(){
        self.chatwb.CloseChannel()
        
        
    }
    func chatreceive(chat: Chat){
        self.chats.insert(chat, at: 0)


    }
    func SendMsg(msg:String,roomId:Int){
        if(msg == ""){
            return
        }
        self.chatfetcher.sendChatData(msg: msg, room_Id: roomId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
        guard let self = self else  { return}
        switch value{
            case .failure:
                self.isSending = false
            break
        case .finished:
            break
        }
    }, receiveValue: {[weak self] chat_json in
        guard let self = self else { return }
        self.isSending = false
    }).store(in: &disposables)
        
    }
    
    
    
}


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
    init(room_Id:Int){
        //print("initialize chat")
        //load(room_Id: room_Id)
    }
    func load(room_Id:Int){
        isSending = true
        chatfetcher.GetChats(roomId: room_Id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else  { return}
                switch value{
                    case .failure:
                        self.chats = []
                        self.isLoading = false
                    break
                case .finished:
                    break
                }
            }, receiveValue: {[weak self] chats_json in
                guard let self = self else { return }
                print(chats_json.chats)
                self.chats = chats_json.chats
                self.isLoading = false
            }).store(in: &disposables)
    }
    func enter(){
        
        chatwb.SubscribeChannel(path: "/", token: g_user_token,delegate: self)
    }
    func chatreceive(chat: Chat){
        chats.insert(chat, at: 0)
    }
    func SendMsg(msg:String,roomId:Int){
        chatfetcher.sendChatData(msg: msg, room_Id: roomId)
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
        self.chatreceive(chat: chat_json.chat)
        self.isSending = false
    }).store(in: &disposables)
        
    }
    
    
    
}


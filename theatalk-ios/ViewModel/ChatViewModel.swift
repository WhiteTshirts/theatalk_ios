//
//  ChatViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine
import SwiftUI
protocol ChatRecv {
    func chatreceive(chat: Chat)
    func userdel(user:User)
    func useradd(user:User)
}

final class ChatsViewModel: ObservableObject,ChatRecv{

    private var disposables = Set<AnyCancellable>()
    var isLoading = false
    var isSending = false
    var chatwb = ChatWBSocket()
    @ObservedObject var UsersVM:UsersViewModel
    func Follow(userId:Int){
        self.UsersVM.Follow(userId: userId)
    }
    func UnFollow(userId:Int){
        self.UsersVM.UnFollow(userId: userId)
    }
    struct StatusText{
        var server_status:Int
        var message:String
    }
    @Published var StatusMessage = StatusText(server_status: 0, message: "")
    @Published var chats: [Chat] = []
    @Published var users: [User] = []
    private var chatfetcher = ChatFetcher()
    init(){
        self.UsersVM = UsersViewModel(userId: UserProfile().user_Id)

        self.load()
        self.enter()


    }
    func load(){
        self.isLoading=true
        self.chatfetcher.GetChats()
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

        self.chatfetcher.ExitRoom()
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
            }, receiveValue: {[weak self] user_json in
                guard let self = self else { return }

            }).store(in: &disposables)
        
        
    }
    func chatreceive(chat: Chat){
        self.chats.insert(chat, at: 0)

    }
    func userdel(user: User) {
        self.users.removeAll(where: {$0.id == user.id})
    }
    
    func useradd(user: User) {
        self.users.append(user)

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


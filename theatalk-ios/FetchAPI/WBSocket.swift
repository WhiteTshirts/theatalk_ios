//
//  WBSocket.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//


import Foundation
import Combine
import SwiftUI
class ChatWBSocket{
    var task:URLSessionWebSocketTask!
    var delegate: ChatRecv?
    @Environment(\.PortEnvironment) private var PORT
    @Environment(\.HostNameEnvironment) private var HNAME
    @Environment(\.WSSchemeEnvironment) private var WSSCHEME
    @Environment(\.WebSocketPathEnvironment) private var WBPATH

    init(){
        
    }
    func SubscribeChannel(path:String, token:String,delegate:ChatRecv){
        var url_components = URLComponents()
        
        url_components.scheme = WSSCHEME
        url_components.port = PORT
        url_components.host = HNAME
        url_components.path = WBPATH
        url_components.queryItems=[
            URLQueryItem(name:"token",value:token)
        ]
        self.delegate = delegate
        if let url_str = url_components.string{
            task = URLSession.shared.webSocketTask(with: URL(string: url_str)!)
        }else{
            return
        }

        task.resume()
        let json = """
       {"command":"subscribe","identifier":"{\\"channel\\":\\"RoomChannel\\"}"}
       """
        let message = URLSessionWebSocketTask.Message.string(json)
        task.send(message){ error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
        
        listen()
        
    }
    func CloseChannel(){
        task?.cancel(with: .goingAway
                     , reason: nil)

    }
    func UserControl(user:User,type:String){
        if(type=="add"){
            self.delegate!.useradd(user: user)
        }else if(type=="del"){
            self.delegate!.userdel(user: user)
        }
    }
    func message_process(o:AnyObject){
        if let message_type = o["type"]{
            if let message_type_str = message_type as? String{
                if(message_type_str == "add" || message_type_str == "del"){
                    if let user_obj = o["user"]! as AnyObject?{
                        let user = User(name_: user_obj["name"]! as! String, user_id: user_obj["id"]! as! Int)
                        self.UserControl(user: user, type: message_type_str)
                    }
                }else if(message_type_str == "comment"){
                    print(o)
                    if let chat_obj = o["chat"]! as AnyObject?{
                        let chat = Chat(user_name_: chat_obj["name"]! as! String, user_id_: chat_obj["user_id"]! as! Int, text_: chat_obj["text"]! as! String, created_at_: Date())
                        print("chat")
                        print(chat)
                        self.delegate!.chatreceive(chat: chat)
                    }

                }
            }

        }
    }
    func listen(){
        
        task.receive{ result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                    case .string(let text):
                        let msg = text.data(using: .utf8)!
                        do{
                            let o = try JSONSerialization.jsonObject(with: msg) as AnyObject
                            if let chat_obj = o["message"]! as AnyObject?{
                                self.message_process(o: chat_obj)
                            }
                        }catch{
                            
                        }
                    case .data(let data):
                        print("Received binary message:")
                

                }
                self.listen()

            }
        }
    }
    
    

}

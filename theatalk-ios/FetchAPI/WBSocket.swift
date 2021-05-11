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
            print(url_str)
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
                            if o["type"]! == nil,let chatobj = o["message"]! as AnyObject?{
                                if type(of: chatobj) != String.Type.self, (chatobj["user_id"]) != nil{
                                    if(chatobj["type"]! == nil){
                                        print(chatobj)
                                        let chat_ = Chat(user_name_:chatobj["name"]! as! String,user_id_: chatobj["user_id"]! as! Int, text_: chatobj["text"]! as! String, created_at_: Date())
                                        self.delegate!.chatreceive(chat: chat_)
                                    }else{
                                        
                                    }

                                }
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

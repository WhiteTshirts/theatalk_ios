//
//  WBSocket.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation

class ChatWBSocket{
    var task:URLSessionWebSocketTask!
    

    init(){
        
    }
    func SubscribeChannel(path:String, token:String){
        task = URLSession.shared.webSocketTask(with: URL(string: "ws://localhost:5000/cable?token=\(token)")!)
        task.resume()
        let json = """
       {"command":"subscribe","identifier":"{\\"channel\\":\\"RoomChannel\\"}"}
       """
        let message = URLSessionWebSocketTask.Message.string(json)
        
    }

}

//
//  WBSocket.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation

class ChatWBSocket{
    var task:URLSessionWebSocketTask!
    var delegate: ChatRecv?

    init(){
        
    }
    func SubscribeChannel(path:String, token:String,delegate:ChatRecv){
        self.delegate = delegate
        task = URLSession.shared.webSocketTask(with: URL(string: "ws://localhost:5000/cable?token=\(token)")!)
        task.resume()
        let json = """
       {"command":"subscribe","identifier":"{\\"channel\\":\\"RoomChannel\\"}"}
       """
        var message = URLSessionWebSocketTask.Message.string(json)
        task.send(message){ error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
        listen()
        
    }
    func listen(){
        var Jsonobject: AnyObject?

        task.receive{ result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):

                switch message {
                    case .string(let text):
                        //print("Received text message:")
                        self.delegate!.chatreceive(chat: text)
                    case .data(let data):
                        print("Received binary message:")
                
                }
                self.listen()

            }
        }
    }
    
    

}

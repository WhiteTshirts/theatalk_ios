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
                                    let chat_ = Chat(user_name_:chatobj["name"]! as! String,user_id_: chatobj["user_id"]! as! Int, text_: chatobj["text"]! as! String, created_at_: Date())
                                    self.delegate!.chatreceive(chat: chat_)
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

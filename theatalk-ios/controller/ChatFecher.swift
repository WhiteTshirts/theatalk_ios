//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
class ChatFetcher{
    private var urllink=""
    @Published var roomData: [Room]=[]
    init(url:String){
        urllink = url
    }
    func fetchChatData(completion: @escaping ([Chat])->Void){
        let url:URL = URL(string: urllink)!
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = TimeZone(identifier: "Asia/Tokyo")
        var chats:[Chat] = []
        let task: URLSessionTask = URLSession.shared.dataTask(with: url,completionHandler: {(data,response,error)in
            do{
                let chatJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! AnyObject
                var chatarray = chatJson["chats"] as! [Any]
                let chats_ = chatarray.map{ (chats_ ) -> [String: Any] in
                    return chats_ as! [String: Any]
                }

                for chat in chats_{
                    var created_at: Date?
                    if chat["created_at"] is NSNull{
                        created_at = nil
                    }else{
                        let t = chat["created_at"] as! String
                        created_at = dateFormater.date(from: t)
                    }
                    chats.append(Chat(user_id_: chat["user_id"] as! Int, comment_: chat["comment"] as! String, created_at_: created_at!))
                }
            }catch{
            }
            completion(chats)

        })
        
        task.resume()

    }
}

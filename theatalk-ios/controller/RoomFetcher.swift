//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
class RoomFetcher{
    private var urllink=""
    @Published var roomData: [Room]=[]
    init(url:String){
        urllink = url
    }
    func fetchRoomData(completion: @escaping ([Room])->Void){
        let url:URL = URL(string: urllink)!
        let dateFormater = DateFormatter()
        var rooms:[Room] = []
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = TimeZone(identifier: "Asia/Tokyo")
        let task: URLSessionTask = URLSession.shared.dataTask(with: url,completionHandler: {(data,response,error)in
            do{
                let roomJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! AnyObject
                var roomarray = roomJson["rooms"] as! [Any]
                let rooms_ = roomarray.map{ (rooms_ ) -> [String: Any] in
                    return rooms_ as! [String: Any]
                }

                for room in rooms_{
                    let crated_at = dateFormater.date(from: room["created_at"] as! String)
                    let start_time: Date?
                    let is_private: Bool
                    if room["start_time"] is NSNull{
                        start_time = nil
                    }else{
                        let t = room["start_time"] as! String
                        start_time = dateFormater.date(from: t)
                    }
                    if room["is_private"] is NSNull{
                        is_private = false
                    }else{
                        is_private = room["is_private"] as! Bool
                    }
                    //let created_at = room["crated_at"] as! Date
                    //print(created_at)
                    rooms.append(Room(admin_id_: room["admin_id"] as! Int, name_: room["name"] as! String, id_: room["id"] as! Int, is_private_: is_private, start_time_: start_time, viewer_: room["viewer"] as! Int, youtube_id_: room["youtube_id"] as! String))
                }
            }catch{
            }
            completion(rooms)

        })
        
        task.resume()

    }
}

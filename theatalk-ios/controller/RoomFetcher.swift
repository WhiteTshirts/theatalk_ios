//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
class RoomFetcher{
    private var urllink=""
    private var host = "http://localhost:5000"
    let encoder = JSONEncoder()
    var fetcher  = Fetcher()
    @Published var roomData: [Room]=[]
    init(url:String){
        urllink = url
    }
    func enterRoom(roomID:Int,token:String){
        let path = "/api/v1/room_users"
        var room_info = Dictionary<String,Any>()
        room_info["room_id"] = roomID
        var jobj = Dictionary<String,Any>()
        jobj["user"] = room_info
        do {
            let data = try JSONSerialization.data(withJSONObject: jobj, options: [])
            fetcher.fetchData(method: "POST", path: path, body: data) { returnData in
                print(returnData)
            }
                
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)\n")
        }
    }
    func exitRoom(){
        
    }
    func fetchRoomData(completion: @escaping ([Room])->Void){
        let path = "/api/v1/rooms"

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = TimeZone(identifier: "Asia/Tokyo")
        var rooms:[Room] = []
        do {
            fetcher.fetchData(method: "GET", path: path, body: nil) { returnData in
                var roomarray = returnData!["rooms"] as! [Any]
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
                    rooms.append(Room(admin_id_: room["admin_id"] as! Int, name_: room["name"] as! String, id_: room["id"] as! Int, is_private_: is_private, start_time_: start_time, viewer_: room["viewer"] as! Int, youtube_id_: room["youtube_id"] as! String))
                }
                completion(rooms)

            }
                
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)\n")
        }
        
    }
}

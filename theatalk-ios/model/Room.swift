//
//  Room.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
final class Thumbnail:ObservableObject{
    @Published var image = UIImage(systemName: "photo")!

    init(from resource:URL){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: resource, completionHandler: { [weak self] data, _, _ in
            guard let imageData = data,
                  let ThumbImage = UIImage(data: imageData) else{
                return
            }
            DispatchQueue.main.async {
                self?.image = ThumbImage
            }
            session.invalidateAndCancel()
        })
        task.resume()
    }
}
class Room: Identifiable,Hashable{
    static func == (lhs: Room, rhs: Room) -> Bool {
        if((lhs.id  != nil)&&(rhs.id != nil)){
            if(lhs.id==rhs.id){
                return true
            }
        }
        return false
    }
    func  hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var admin_id: Int!
    var created_at: Date!
    var id: Int!
    var is_private: Bool!
    var name: String!
    var password: String!
    var start_time: Date!
    var updated_at: Date!
    var viewer: Int!
    var youtube_id: String!
    var tags: [Int]!
    init(admin_id_:Int,name_:String,id_:Int,is_private_:Bool,start_time_:Date?,viewer_:Int,youtube_id_:String){
        admin_id = admin_id_
        id = id_
        is_private = is_private_
        name = name_
        start_time = start_time_
        viewer = viewer_
        youtube_id = youtube_id_
       
    }
}


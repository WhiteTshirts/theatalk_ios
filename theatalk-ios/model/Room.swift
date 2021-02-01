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
    

    var name: String!
    var id: Int!
    var youtube_url: String!
    var author: String!
    var tags: [Int]!
    var image_url: String!
    var room_num: Int!
    init(){
        name = nil
        id = nil
        youtube_url = nil
        author = nil
        tags = nil
        image_url = nil
        room_num = nil
    }
    init(name_:String,id_:Int,youtube_url_ :String, author_: String,tags_: [Int],image_url_: String,room_num_ :Int){
        name = name_
        id = id_
        youtube_url = youtube_url_
        author = author_
        tags = tags_
        image_url = image_url_
        room_num = room_num_
    }
}


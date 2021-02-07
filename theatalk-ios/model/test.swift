//
//  test.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/08.
//

import Foundation
class Room_: Identifiable,Hashable{
    static func == (lhs: Room_, rhs: Room_) -> Bool {
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

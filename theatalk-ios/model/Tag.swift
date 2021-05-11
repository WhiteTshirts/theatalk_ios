//
//  Tag.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
struct Tags_json:Codable{
    var tags:[Tag]!
    
}
struct Tag_json:Codable{
    var tag:Tag!
}
class Tag: Identifiable,Hashable,Codable{
    static func == (lhs: Tag, rhs: Tag) -> Bool {
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
    
    var id:Int!
    var name:String!
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    init(id_:Int,name_:String){
        id = id_
        name = name_
    }
    
}

class TagUser:Codable{
    var tag_id:Int
    init(tag_id:Int){
        self.tag_id = tag_id
    }
}
class TagUser_Json:Codable{
    var tag_user:TagUser
    init(tag_user:TagUser){
        self.tag_user = tag_user
    }
}

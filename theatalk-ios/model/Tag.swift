//
//  Tag.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
class Tags_json:Codable{
    var tags:[Tag]!
    
}
class Tag_json:Codable{
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


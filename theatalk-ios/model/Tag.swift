//
//  Tag.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
class Tags:Codable{
    var tags:[Tag]!
    
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
    
    init(id_:Int,name_:String){
        id = id_
        name = name_
    }
}


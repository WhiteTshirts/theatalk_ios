//
//  User.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
class User:Identifiable,Codable{
    var name: String
    var id: Int //user_id
    var password: String!
    var tags: [Int]!
    private var image_name: String!
    init(name_: String,password_: String){
        id = -1
        name = name_
        password = password_
    }
    
    init(name_: String,id_: Int,tags_: [Int]){
        name = name_
        id = id_
        tags = tags_
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        password = try container.decodeIfPresent(String.self, forKey: .name)
        tags = try container.decodeIfPresent([Int].self, forKey: .tags)
  
    }
}


class Users:Codable{
    var users:[User]!
}

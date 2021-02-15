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
    var isFollowed = false
    var isFollwing = false
    private var image_name: String!
    enum DecodingKeys: CodingKey{
        case name,id,password,tags,isFollowd,isFollowing
    }
    enum EncodeKeys:CodingKey{
        case name,password
    }
    enum EncodeRootKeys:CodingKey{
        case user
    }
    init(name_: String,user_id: Int){
        name = name_
        id = user_id
    }
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
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        password = try container.decodeIfPresent(String.self, forKey: .name)
        tags = try container.decodeIfPresent([Int].self, forKey: .tags)
        isFollwing = try container.decodeIfPresent(Bool.self, forKey: .isFollowing) ?? false
        isFollowed = try container.decodeIfPresent(Bool.self, forKey: .isFollowd) ?? false
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodeRootKeys.self)
        var nestObj = container.nestedContainer(keyedBy: EncodeKeys.self, forKey: .user)
        try nestObj.encode(name, forKey: .name)
        try nestObj.encode(name,forKey: .password)
        
    }
}

class User_Json:Codable{
    var user:User!
    var token:String!
}
class Users_Json:Codable{
    var users:[User]!
}

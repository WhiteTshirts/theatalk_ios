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
    var tags: [Tag]!
    var rooms: [Room]!
    var followings :[User]!
    var followers :[User]!
    var isFollowed = false
    var isFollwing = false
    var room_id:Int!
    private var image_name: String!
    enum DecodingKeys: CodingKey{
        case name,id,password,tags,isFollowed,isFollowing,room_id,rooms,followings,followers
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
    
    init(name:String,user_id:Int,password:String){
        self.name = name
        
        self.id = user_id
        self.password = password
    }
    init(name_: String,password_: String){
        id = -1
        name = name_
        password = password_
    }
    
    init(name_: String,id_: Int,tags_: [Tag]){
        name = name_
        id = id_
        tags = tags_
    }
    init(name_: String,id_: Int,tags_: [Tag],rooms:[Room],followings:[User],followers:[User]){
        self.name = name_
        self.id = id_
        self.tags = tags_
        self.rooms = rooms
        self.followings = followings
        self.followers = followers
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        password = try container.decodeIfPresent(String.self, forKey: .name)
        tags = try container.decodeIfPresent([Tag].self, forKey: .tags)
        rooms = try container.decodeIfPresent([Room].self, forKey: .rooms)
        followings = try container.decodeIfPresent([User].self,forKey: .followings)
        followers = try  container.decodeIfPresent([User].self, forKey: .followers)
        isFollwing = try container.decodeIfPresent(Bool.self, forKey: .isFollowing) ?? false
        isFollowed = try container.decodeIfPresent(Bool.self, forKey: .isFollowed) ?? false
        room_id = try container.decodeIfPresent(Int.self, forKey: .room_id ) ?? 0
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodeRootKeys.self)
        var nestObj = container.nestedContainer(keyedBy: EncodeKeys.self, forKey: .user)
        try nestObj.encode(name, forKey: .name)
        try nestObj.encode(password,forKey: .password)
        
    }
}

class User_Json:Codable{
    var user:User!
    var token:String!
}
class Users_Json:Codable{
    var users:[User]!
}

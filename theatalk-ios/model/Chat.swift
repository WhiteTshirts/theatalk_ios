//
//  Chat.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/06.
//


import Foundation
import SwiftUI

class ChatMessage: Codable{
    
}
struct Chat: Codable{
    
    var user_id: Int
    var room_id: Int!
    var text: String
    var created_at: Date!
    var user_name: String!
    enum DecodingKeys: CodingKey{
        case room_id,text,created_at,user
    }
    enum EncodeKeys:CodingKey{
        case text,user_name
    }
    enum EncodeRootKeys:CodingKey{
        case chat
    }
    
    enum UserKeys:CodingKey{
        case id
        case name
    }
    
    init(user_id_:Int,text_:String,created_at_:Date){
        user_id = user_id_
        text  = text_
        created_at = created_at_
    }
    mutating func UpdateChat(user_name_: String,user_id_:Int,text_:String,created_at_:Date){
        user_name = user_name_
        user_id = user_id_
        text  = text_
        created_at = created_at_
    }
    
    init(user_name_: String,user_id_:Int,text_:String,created_at_:Date){
        user_name = user_name_
        user_id = user_id_
        text  = text_
        created_at = created_at_
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        room_id = try container.decodeIfPresent(Int.self, forKey: .room_id)
        text = try container.decode(String.self, forKey: .text)
        created_at = try container.decodeIfPresent(with: DateTransformer(), forKey: .created_at)
        let user_container = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        user_id = try user_container.decode(Int.self,forKey: .id)
        user_name = try user_container.decode(String.self,forKey: .name)

    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodeRootKeys.self)
        var nestObj = container.nestedContainer(keyedBy: EncodeKeys.self, forKey: .chat)
        try nestObj.encode(text,forKey: .text)
    }
    
}

struct Chat_Json:Codable{
    var chat:Chat!
}

struct Chats_Json:Codable{
    var chats:[Chat]!
}

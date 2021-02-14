//
//  Chat.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/06.
//


import Foundation
import SwiftUI
class Chat: Identifiable,Codable{
    var user_id: Int
    var room_id: Int!
    var text: String
    var created_at: Date!
    var user_name: String!
    enum DecodingKeys: CodingKey{
        case user_id,room_id,text,created_at,user_name
    }
    enum EncodeKeys:CodingKey{
        case text,user_name
    }
    enum EncodeRootKeys:CodingKey{
        case chat
    }
    init(user_id_:Int,text_:String,created_at_:Date){
        user_id = user_id_
        text  = text_
        created_at = created_at_
    }
    func UpdateChat(user_name_: String,user_id_:Int,text_:String,created_at_:Date){
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        user_id = try container.decode(Int.self, forKey: .user_id)
        room_id = try container.decodeIfPresent(Int.self, forKey: .room_id)
        text = try container.decode(String.self, forKey: .text)
        created_at = try container.decodeIfPresent(with: DateTransformer(), forKey: .created_at)

    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodeRootKeys.self)
        var nestObj = container.nestedContainer(keyedBy: EncodeKeys.self, forKey: .chat)
        try nestObj.encode(text,forKey: .text)
    }
    
}

class Chat_Json:Codable{
    var chat:Chat!
}

class Chats_Json:Codable{
    var chats:[Chat]!
}

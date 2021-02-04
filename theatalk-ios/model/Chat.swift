//
//  Chat.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/06.
//


import Foundation
import SwiftUI
class Chat: Identifiable{
    var user_id: Int
    var room_id: Int!
    var comment: String
    var created_at: Date
    var user_name: String!
    init(user_id_:Int,comment_:String,created_at_:Date){
        user_id = user_id_
        comment  = comment_
        created_at = created_at_
    }
    func UpdateChat(user_name_: String,user_id_:Int,comment_:String,created_at_:Date){
        user_name = user_name_
        user_id = user_id_
        comment  = comment_
        created_at = created_at_
    }
    
    init(user_name_: String,user_id_:Int,comment_:String,created_at_:Date){
        user_name = user_name_
        user_id = user_id_
        comment  = comment_
        created_at = created_at_
    }
    
}

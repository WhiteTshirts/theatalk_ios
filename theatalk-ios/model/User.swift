//
//  User.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
struct User:Identifiable{
    var name: String
    var id: Int //user_id
    var password: String!
    var tags: [Int]!
    private var image_name: String!
    var image: Image!
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
}

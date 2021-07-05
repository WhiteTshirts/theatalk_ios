//
//  UserCache.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/11.
//

import Foundation
import SwiftUI
import Combine
let image_names = ["dog","cat","whale","sheep","penguin","dragon"]

struct UserCache{
    private static var users:[User] = []
    private init(){}
    static func find(id:Int)->User?{
        return UserCache.users.filter({$0.id == id}).first
    }
    static func add(user:User){
        UserCache.users.append(user)
    }
    
}
struct AvaterCache{
    
    static var avaters:[Avater] = []
    private init(){}

    static func find(id:Int)->Image{
        print(image_names[id])
        return Image(image_names[id])
    }
    static func add(avater:Avater){
        AvaterCache.avaters.append(avater)
    }
}

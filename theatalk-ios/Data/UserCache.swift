//
//  UserCache.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/11.
//

import Foundation
import SwiftUI
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
    private static var avaters:[Avater] = []
    private init(){}
    static func find(id:Int)->Avater?{
        return AvaterCache.avaters.filter({$0.id == id}).first
    }
    static func add(avater:Avater){
        AvaterCache.avaters.append(avater)
    }
}

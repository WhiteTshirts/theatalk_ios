//
//  UserCache.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/11.
//

import Foundation
struct UserCache{
    var users:[User] = []
    private init(){}
    func find(id:Int)->User?{
        return users.filter({$0.id == id}).first
    }
    
    
}

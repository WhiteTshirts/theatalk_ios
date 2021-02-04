//
//  AuthViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine
var mockUserData:User = User(name_: "hogehoge", password_: "hogehoge")
var mockUsersData:[User] = [User(name_: "user1", id_: 3, tags_: a),
                            User(name_: "user2", id_: 4, tags_: a),
                            User(name_: "user3", id_: 5, tags_: a),
                            User(name_: "user4", id_: 6, tags_: a),
                            User(name_: "user5", id_: 7, tags_: a),
                            User(name_: "user6", id_: 8, tags_: a),
                            User(name_: "user7", id_: 9, tags_: a),
                            User(name_: "user8", id_: 10, tags_: a)
]
var mockUserHashVal = ""


final class AuthViewModel: ObservableObject{
    @Published var user: User?
    @Published var hashval: String?
    //private var fetcher = AuthFetcher(url: "http://localhost:5000/api/v1/rooms/0")
    init(){
        self.user = mockUserData
        //if cannot get user data ask name and password
        hashval = mockUserHashVal
        //login here if fail ask name and password in first scene
    }
    func load(){
//        roomfetcher.fetchRoomData{
//            returnData in
//            print(returnData)
//            self.rooms = returnData
//        }
    }
    
    
}


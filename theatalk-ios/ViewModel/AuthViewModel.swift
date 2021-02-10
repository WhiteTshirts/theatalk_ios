//
//  AuthViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine


final public class AuthViewModel: ObservableObject{
    @Published var user: User?
    @Published var hashval: String?
    //private var fetcher = AuthFetcher(url: "http://localhost:5000/api/v1/rooms/0")
    private init(){
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


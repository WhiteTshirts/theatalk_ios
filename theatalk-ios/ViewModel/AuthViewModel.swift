//
//  AuthViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine

import CoreData
final public class AuthViewModel: ObservableObject{
    
    @Published var user: User?
    @Published var hashval: String?
    @Published var userName:String = ""
    @Published var password:String = ""
    @Published var isSuccessed:Bool = true
    @Published var ErrorMessage = ""
    private var disposables = Set<AnyCancellable>()

    private var authfetcher = AuthFetcher()
    //private var fetcher = AuthFetcher(url: "http://localhost:5000/api/v1/rooms/0")
    init(){
        
        //self.user = mockUserData
        //if cannot get user data ask name and password
        //hashval = mockUserHashVal
        //login here if fail ask name and password in first scene
    }
    func load(){
//        roomfetcher.fetchRoomData{
//            returnData in
//            print(returnData)
//            self.rooms = returnData
//        }
    }
    func SetUser(name: String, password: String){
        self.password = password
        self.userName = name
    }
    func login(completion:@escaping(User?,Bool?)->()){
        authfetcher.login_(user: User(name_: self.userName, password_: self.password)).sink(receiveCompletion: { completion in
            print("receiveCompletion:", completion)
        }, receiveValue: { [self] user_json in
            var user = user_json.user
            
            g_user_token = user_json.token
            completion(user,true)
        }).store(in: &disposables)
    }
    func signup(completion:@escaping(User?,Bool?)->()){
        authfetcher.signup(user: User(name_: self.userName, password_: self.password)).sink(receiveCompletion: { completion in
            print("receiveCompletion:", completion)
        }, receiveValue: { [self] user_json in
            var user = user_json.user
            g_user_token = user_json.token
            print(g_user_token)
            completion(user,true)
        }).store(in: &disposables)
    }
    
    
}


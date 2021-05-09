//
//  UserProfile.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/13.
//

import Foundation



class UserProfile: ObservableObject{
    @Published var username: String{
        didSet{
            
            UserDefaults.standard.set(username,forKey: "username")
        
        }
        
    }
    @Published var password: String{
        didSet{
            UserDefaults.standard.set(password,forKey: "password")
        }
    }
    @Published var user_Id: Int{
        didSet{
            UserDefaults.standard.set(user_Id,forKey: "user_Id")
        }
    }
    @Published var token: String{
        didSet{
            UserDefaults.standard.set(token,forKey: "token")
        }
    }
    @Published var token_invalid:Bool{
        didSet{
            UserDefaults.standard.set(token_invalid,forKey: "token_invalid")
        }
    }
    @Published var server_status:Bool{
        didSet{
            UserDefaults.standard.set(server_status,forKey: "server_status")
        }
    }
    
    init(){
        username = UserDefaults.standard.string(forKey: "username") ?? ""
        password = UserDefaults.standard.string(forKey: "password") ?? ""
        token = UserDefaults.standard.string(forKey: "token") ?? ""
        token_invalid = UserDefaults.standard.bool(forKey: "token_invalid")
        server_status = UserDefaults.standard.bool(forKey: "server_status")
        user_Id = UserDefaults.standard.object(forKey: "user_Id") as? Int ?? -1
        
    }
}

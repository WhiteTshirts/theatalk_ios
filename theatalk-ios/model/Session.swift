//
//  Session.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/07.
//

import Foundation
import Combine

final class Session: ObservableObject{
    @Published var isLogin:Bool
    @Published var user:User?
    init(login:Bool = false,user:User? = nil){
        self.isLogin = login
        self.user = user
    }
    
}


enum AuthError:Error{
    case InvalidName
    case InvalidPass
    case DuplicateName
    case NetworkErr
}
protocol AuthCheckProtocol {
    func login(userName:String, password:String)->Future<User,Error>
    func logout()->Future<Void,Error>
}


final class AuthCheck:AuthCheckProtocol{
    func login(userName:String, password:String)->Future<User,Error>{
        return Future<User,Error>{ promise in
            DispatchQueue.global().async {
                //fetchapi
                if(true){
                    promise(.success(User(name_: userName, password_: password)))
                }else{
                    //エラーを見て返す
                    promise(.failure(AuthError.InvalidName))
                }            }

            
        }
    }
    func logout()->Future<Void,Error>{
        return Future<Void,Error>{
            promise in
            DispatchQueue.global().async {
                if(true){
                    promise(.success(()))
                }else{
                    promise(.failure(AuthError.NetworkErr))
                }            }

        }
    }
}

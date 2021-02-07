//
//  Auth.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine
protocol AuthFechable {
    func login(
    ) -> AnyPublisher<[User],APIError>
    func logout(
        forUser user: User
    ) -> AnyPublisher<User,APIError>
    func signup(
        forUser user: User
    ) ->AnyPublisher<User,APIError>
    
}
class  AuthFetcher{
    @Published var UserData: User?
    @Published var Hashval:String?
    
    let encoder = JSONEncoder()
    var fetcher  = Fetcher()
    func login(name:String,password:String){
        UserData = User(name_: name, password_: password)
        
        var user_info = Dictionary<String,Any>()
        user_info["name"] = name
        user_info["password"] = password
        var jobj = Dictionary<String,Any>()
        jobj["user"] = user_info
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jobj, options: [])
            let jsonStr = String(bytes: data, encoding: .utf8)!
            fetcher.fetchData(method:"POST",path: "/api/v1/login",body: data){ returnData in
                if(returnData != nil){
                    
                    
                    self.Hashval = returnData!["token"] as! String
                }
                
                            
            }
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)\n")
        }


        
    }
    func signup(name:String,password:String){
        
    }

}

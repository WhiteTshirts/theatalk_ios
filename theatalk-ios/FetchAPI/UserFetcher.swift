//
//  UserFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/07.
//

import Foundation
import Combine
protocol UserFechable {
//    func GETUsers(
//    ) -> AnyPublisher<[User],APIError>
//    func GETFollowers(
//        forUser user: User
//    ) -> AnyPublisher<[User],APIError>
//    func POSTFollow(
//        forUser user: User
//    ) ->AnyPublisher<User,APIError>
//    func DELETEFollow(
//        forUser user: User
//    ) -> AnyPublisher<Void,APIError>
    
}
class UserFetcher:Fetcher{
    @Published var userData: [User]=[]
    init(url:String,session: URLSession = .shared){
//        encoder.outputFormatting = .prettyPrinted
//        encoder.dateEncodingStrategy = .iso8601
        //iso8601 2018-01-08T02:51:37Z
        super.init()
    }


  }




extension UserFetcher: UserFechable{
    
    func GetUser(
        userId:Int
    )->AnyPublisher<User_Json,APIError>{
        return fetchData(with: makeComponents(Path: "/users/\(userId)", Type: "GET", body: nil))
    }
    func GETUsers(
    ) -> AnyPublisher<Users_Json,APIError>{
        return fetchData(with: makeComponents(Path: "/users", Type: "GET", body: nil))
    }
    func GETFollowers(
        user:User
    ) -> AnyPublisher<Users_Json,APIError>{

        do{
            let data = try encoder.encode(user)
            return fetchData(with: makeComponents(Path: "/relationships/follow_index", Type: "GET", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func POSTFollow(
        userId: Int
    ) ->AnyPublisher<User_Json,APIError>{
        do{
            let user = User(name_: "", user_id: userId)
            let data = try encoder.encode(user)
            return fetchData(with: makeComponents(Path: "/relationships", Type: "POST", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    func DELETEFollow(
        forUser userId: Int
    ) -> AnyPublisher<Users_Json,APIError>{
        do{
            let user = User(name_: "", user_id: userId)
            let data = try encoder.encode(user)
            return fetchData(with: makeComponents(Path: "/relationships/1", Type: "DELETE", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }


}

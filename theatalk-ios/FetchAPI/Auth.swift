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
    ) -> AnyPublisher<User,APIError>
    func logout(
        forUser user: User
    ) -> AnyPublisher<User,APIError>
    func signup(
        forUser user: User
    ) ->AnyPublisher<User,APIError>
    
}
class  AuthFetcher:Fetcher{
    @Published var UserData: User?
    @Published var Hashval:String?


}

extension AuthFetcher{
    func login_(user:User) -> AnyPublisher<User_Json,APIError>{
        do{
            let body = try encoder.encode(user)
            return fetchData(with: makeComponents(Path: "/login", Type: "POST", body: body))
        }catch{
            let error = APIError.network(description: "couldnot decode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    func signup(user:User)->AnyPublisher<User_Json,APIError>{
        do{
            let body = try encoder.encode(user)
            return fetchData(with: makeComponents(Path: "/users", Type: "POST", body: body))
        }catch{
            let error = APIError.network(description: "couldnot decode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}


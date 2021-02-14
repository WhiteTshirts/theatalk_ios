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
class UserFetcher{
    let encoder = JSONEncoder()
    var fetcher  = Fetcher()
    private let session: URLSession
    @Published var userData: [User]=[]
    init(session: URLSession = .shared){
        self.session = session
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        //iso8601 2018-01-08T02:51:37Z
    }


    private func fetchUser<T>(
        with reqcomponents: URLRequest
    ) -> AnyPublisher<T, APIError> where T: Decodable {
      return session.dataTaskPublisher(for: reqcomponents)
        .mapError { error in
          .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
          decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
  }

extension UserFetcher{
    func makeUsersComponents(Path:String,Type:String,body: Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1"+Path
        var components = URLRequest(url:url_components.url!)
        components.httpMethod = Type
        components.addValue("application/json", forHTTPHeaderField: "content-type")
        if(g_user_token != ""){
            components.setValue("Bearer \(g_user_token)", forHTTPHeaderField: "Authorization")
        }
        if(body != nil){
            components.httpBody = body
        }
      return components
    }
}


extension UserFetcher: UserFechable{
    
    func GetUser(
        userId:Int
    )->AnyPublisher<User_Json,APIError>{
        return fetchUser(with: makeUsersComponents(Path: "/users/\(userId)", Type: "GET", body: nil))
    }
    func GETUsers(
    ) -> AnyPublisher<Users_Json,APIError>{
        return fetchUser(with: makeUsersComponents(Path: "/users", Type: "GET", body: nil))
    }
    func GETFollowers(
        user:User
    ) -> AnyPublisher<Users_Json,APIError>{

        do{
            let data = try encoder.encode(user)
            return fetchUser(with: makeUsersComponents(Path: "/relationships/follow_index", Type: "GET", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func POSTFollow(
        userId: Int
    ) ->AnyPublisher<User_Json,APIError>{
        do{
            var follow_info = Dictionary<String,Any>()
            follow_info["follow_id"] = userId
            let data = try JSONSerialization.data(withJSONObject: follow_info, options: [])
            return fetchUser(with: makeUsersComponents(Path: "/relationships", Type: "GET", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
//    func DELETEFollow(
//        forUser user: User
//    ) -> AnyPublisher<Void,APIError>{
//        do{
//            let data = try encoder.encode(user)
//            return fetchUser(with: makeUsersComponents(Path: "/relationships/follow_index", Type: "GET", body: data))
//        }catch{
//            let error = APIError.network(description: "could not encode")
//            return Fail(error: error).eraseToAnyPublisher()
//        }
//    }


}

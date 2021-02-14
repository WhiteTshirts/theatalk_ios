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
class  AuthFetcher{
    @Published var UserData: User?
    @Published var Hashval:String?
    private let session: URLSession

    let encoder = JSONEncoder()
    var fetcher  = Fetcher()
    init(session: URLSession = .shared){
        self.session = session
    }
    
    private func fetchAuth<T>(
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

extension AuthFetcher{
    func login_(user:User) -> AnyPublisher<User_Json,APIError>{
        do{
            let body = try encoder.encode(user)
            return fetchAuth(with: makeLoginComponents(Path: "login", Type: "POST", body: body))
        }catch{
            let error = APIError.network(description: "couldnot decode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    func signup(user:User)->AnyPublisher<User_Json,APIError>{
        do{
            let body = try encoder.encode(user)
            return fetchAuth(with: makeLoginComponents(Path: "/signup", Type: "POST", body: body))
        }catch{
            let error = APIError.network(description: "couldnot decode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}



extension AuthFetcher{
    func makeLoginComponents(Path:String,Type:String,body: Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1/"+Path
        print(url_components.url!)
        var components = URLRequest(url:url_components.url!)
        components.httpMethod = Type
        components.addValue("application/json", forHTTPHeaderField: "content-type")
        if(mockUserHashVal != nil){
            components.setValue("Bearer \(mockUserHashVal)", forHTTPHeaderField: "Authorization")
        }
        if(body != nil){
            components.httpBody = body
        }
      return components
    }
}

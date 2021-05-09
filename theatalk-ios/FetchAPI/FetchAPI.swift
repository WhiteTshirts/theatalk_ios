//
//  FetchAPI.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
import Combine
import SwiftUI
enum APIError: Error{
    case network(description: String)
    case server(description:String)
    case client(description:String)
    case parsing(description: String)
    case encoding(description: String)
    case token(description:String)
    case other(error:Error)
}


class Fetcher{
    @Environment(\.PortEnvironment) private var PORT
    @Environment(\.HostNameEnvironment) private var HNAME
    @Environment(\.SchemeEnvironment) private var SCHEME
    
    let dateFormater = DateFormatter()
    let encoder = JSONEncoder()
    var session: URLSession
    init(session: URLSession = .shared){
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = TimeZone(identifier: "Asia/Tokyo")
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        self.session = session
    }
    
    func makeComponents(Path:String,Type:String,body: Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = SCHEME
      url_components.host = HNAME
        url_components.port = PORT
      url_components.path = "/api/v1"+Path
        var components = URLRequest(url:url_components.url!)
        components.httpMethod = Type
        components.addValue("application/json", forHTTPHeaderField: "content-type")
        if(g_user_token != ""
        
        ){
            components.setValue("Bearer \(g_user_token)", forHTTPHeaderField: "Authorization")
        }
        if(body != nil){
            components.httpBody = body
        }
      return components
    }
    func  fetchData<T>(//401なら一回loginを試みる、それでもダメならログインさせる
        with reqcomponents: URLRequest
    ) -> AnyPublisher<T, APIError> where T: Decodable {
      return session.dataTaskPublisher(for: reqcomponents)
        .tryMap({data, response -> Data in
            guard let httpres = response as? HTTPURLResponse else{
                throw APIError.network(description: "http response not found")
            }
            if(httpres.statusCode == 401){//unauthorized
                UserProfile().token_valid = false

                throw APIError.token(description: "token expires")
            }
            if(500..<600).contains(httpres.statusCode){
                UserProfile().server_status = false
                throw APIError.server(description: "server error")
            }
            if (200..<300).contains(httpres.statusCode) == false {
                throw APIError.client(description: "Bad Http Status Code")
            }
            return data
        })
        .decode(type: T.self,decoder:JSONDecoder())
        .mapError{
            $0 as? APIError ?? APIError.other(error: $0)
        }
        .eraseToAnyPublisher()
    }

}

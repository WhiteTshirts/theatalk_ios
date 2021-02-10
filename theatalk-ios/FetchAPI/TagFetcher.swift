//
//  TagFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//


import Foundation
import Combine
protocol TagFechable {
    func GETTags(
    ) -> AnyPublisher<Tags,APIError>
    func PostTag(
        tag_name: String
    ) -> AnyPublisher<Tag,APIError>
//    func EditTag(
//        forTag tag: Tag
//    ) ->AnyPublisher<Tag,APIError>
//    func DeleteTag(
//        forTag tag:Tag
//    ) -> AnyPublisher<Void,APIError>
    
}
class TagFetcher{
    private var urllink=""
    private var host = "http://localhost:5000"
    let encoder = JSONEncoder()
    var fetcher  = Fetcher()
    private let session: URLSession
    @Published var tagData: [Tag]=[]
    init(url:String,session: URLSession = .shared){
        urllink = url
        self.session = session
    }
    
    private func fetchTag<T>(
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

extension TagFetcher{
    func makeGetTagsComponents(
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1/tags"
        let components = URLRequest(url:url_components.url!)
        
      return components
    }
    
    func makePostTagsComponents(
        name:String, body:Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1/tag"
        var components = URLRequest(url:url_components.url!)
        components.addValue("application/json", forHTTPHeaderField: "content-type")
        components.httpMethod = "POST"
        components.setValue("Bearer \(mockUserHashVal)", forHTTPHeaderField: "Authorization")
        if(body != nil){
            components.httpBody = body
        }
      return components
    }
}

extension TagFetcher:TagFechable{
    func PostTag(tag_name: String) -> AnyPublisher<Tag, APIError> {
        return fetchTag(with: makeGetTagsComponents())
    }
    

    func GETTags(
    ) -> AnyPublisher<Tags,APIError>{
        return fetchTag(with: makeGetTagsComponents())
    }
}

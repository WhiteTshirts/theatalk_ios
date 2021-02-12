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
    func makeTagsComponents(Path:String,Type:String,body: Data!
    ) -> URLRequest {
        var url_components = URLComponents()
      url_components.scheme = "http"
      url_components.host = "localhost"
        url_components.port = 5000
      url_components.path = "/api/v1/"+Path
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

extension TagFetcher:TagFechable{
    func PostTag(tag_name: String) -> AnyPublisher<Tag, APIError> {
        var tag_info = Dictionary<String,Any>()
        tag_info["name"] = tag_name
        var jobj = Dictionary<String,Any>()
        jobj["tag"] = tag_info
        var data:Data!
        do {
            data = try JSONSerialization.data(withJSONObject: jobj, options: [])
            let jsonStr = String(bytes: data, encoding: .utf8)!
            
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)\n")
        }
        return fetchTag(with: makeTagsComponents(Path: "POST", Type: "/tags", body: data))
    }
    func GETTags(
    ) -> AnyPublisher<Tags,APIError>{
        return fetchTag(with: makeTagsComponents(Path: "/tags", Type: "GET", body: nil))
    }
    func GETTagUsers(tagId:Int)->AnyPublisher<Int,APIError>{
        var data:Data!
        return fetchTag(with: makeTagsComponents(Path: "/user_tags/get_num/\(tagId)", Type: "GET", body: data))
    }
    func GETUsersbyTag(tagId:Int) -> AnyPublisher<Users,APIError>{
        var data:Data!
        return fetchTag(with: makeTagsComponents(Path: "/users_tags", Type: "GET", body: data))
    }
    func DeleteUsersTag(tagId:Int)->AnyPublisher<Tags,APIError>{
        var data:Data!
        return fetchTag(with: makeTagsComponents(Path: "/user_tags/\(tagId)", Type: "DELETE", body: data))
    }
    func CreateRoomTag(roomId:Int)->AnyPublisher<Room_json,APIError>{
        var data:Data!
        return fetchTag(with: makeTagsComponents(Path: "/room_tags", Type: "GET", body: data))
    }
    func DeleteRoomTag(roomId:Int)->AnyPublisher<Room_json,APIError>{
        var data:Data!
        return fetchTag(with: makeTagsComponents(Path: "/room_tags/\(roomId)", Type: "DELETE", body: data))
    }
    func GETRoomsbyTag(tagId:Int)->AnyPublisher<Rooms_json,APIError>{
        return fetchTag(with: makeTagsComponents(Path: "/room_tags/\(tagId)", Type: "GET", body: nil))
    }
}

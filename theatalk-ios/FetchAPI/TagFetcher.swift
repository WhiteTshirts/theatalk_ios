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
    ) -> AnyPublisher<Tags_json,APIError>
    func PostTag(
        tag_name: String
    ) -> AnyPublisher<Tag_json,APIError>

}
class TagFetcher:Fetcher{
    @Published var tagData: [Tag]=[]
    init(url:String,session: URLSession = .shared){
        super.init()
    }


}



extension TagFetcher:TagFechable{
    func PostTag(tag_name: String) -> AnyPublisher<Tag_json, APIError> {
        do{
            let data = try encoder.encode(Tag(id_: -1, name_: tag_name))
            return fetchData(with: makeComponents(Path: "/tags", Type: "POST", body: data))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
            
        }
    }
    func GETTags(
    ) -> AnyPublisher<Tags_json,APIError>{
        return fetchData(with: makeComponents(Path: "/tags", Type: "GET", body: nil))
    }
    func GetUserTags(userId:Int)-> AnyPublisher<Tags_json,APIError>{
        return fetchData(with: makeComponents(Path: "/user_tags/\(userId)", Type: "GET", body: nil))
    }
    func GETTagUsers(tagId:Int)->AnyPublisher<Int,APIError>{
        var data:Data!
        return fetchData(with: makeComponents(Path: "/user_tags/get_num/\(tagId)", Type: "GET", body: data))
    }
    func GETUsersbyTag(tagId:Int) -> AnyPublisher<Users_Json,APIError>{
        var data:Data!
        return fetchData(with: makeComponents(Path: "/users_tags", Type: "GET", body: data))
    }
    func CreateUsersTag(tagId:Int)->AnyPublisher<TagUser_Json,APIError>{
        var taguser = TagUser(tag_id: tagId)
        var taguser_j = TagUser_Json(tag_user: taguser)
        do{
            let data = try encoder.encode(taguser_j)
            return fetchData(with: makeComponents(Path: "/user_tags", Type: "POST", body: data))

        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    func DeleteUsersTag(tagId:Int)->AnyPublisher<Tags_json,APIError>{
        return fetchData(with: makeComponents(Path: "/user_tags/\(tagId)", Type: "DELETE", body: nil))
    }
    func CreateRoomTag(roomId:Int)->AnyPublisher<Room_json,APIError>{
        var data:Data!
        return fetchData(with: makeComponents(Path: "/room_tags", Type: "GET", body: data))
    }
    func DeleteRoomTag(roomId:Int)->AnyPublisher<Room_json,APIError>{
        var data:Data!
        return fetchData(with: makeComponents(Path: "/room_tags/\(roomId)", Type: "DELETE", body: data))
    }

    func SearchTagsbyName(tagName:String)->AnyPublisher<Tags_json,APIError>{
        let query = URLQueryItem(name: "search", value: tagName)
        return  fetchData(with: makeComponentsWithq(Path: "/tags/search",Type: "GET", query: query, body: nil))
    }
}

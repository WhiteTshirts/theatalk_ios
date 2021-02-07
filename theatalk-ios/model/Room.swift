//
//  Room.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
final class Thumbnail:ObservableObject{
    @Published var image = UIImage(systemName: "photo")!

    init(from resource:URL){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: resource, completionHandler: { [weak self] data, _, _ in
            guard let imageData = data,
                  let ThumbImage = UIImage(data: imageData) else{
                return
            }
            DispatchQueue.main.async {
                self?.image = ThumbImage
            }
            session.invalidateAndCancel()
        })
        task.resume()
    }
}
protocol CodingTransformerProtocol {
    associatedtype From
    associatedtype To

    func transform(_ from: From) throws -> To
}

struct DateTransformer: CodingTransformerProtocol {
    static let formatter: DateFormatter = {
        let result = DateFormatter()
        result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        return result
    }()

    func transform(_ from: String) throws -> Date? {
        return DateTransformer.formatter.date(from: from)
    }
}

extension KeyedDecodingContainer {
    func decode<Transformer: CodingTransformerProtocol>(with transformer: Transformer, forKey key: Key) throws -> Transformer.To where Transformer.From == String {
        return try transformer.transform(try decode(String.self, forKey: key))
    }

    func decodeIfPresent<Transformer: CodingTransformerProtocol>(with transformer: Transformer, forKey key: Key) throws -> Transformer.To where Transformer.From == String, Transformer.To: ExpressibleByNilLiteral {
        guard let decoded = try decodeIfPresent(String.self, forKey: key) else { return nil }
        return try transformer.transform(decoded)
    }
}
struct Room_: Codable{
    
    var admin_id: Int!
    var id: Int!
    var is_private: Bool!
    var name: String!
    var password: String!
    var created_at: Date!
    var start_time: Date!
    var updated_at: Date!
    var viewer: Int!
    var youtube_id: String!
    var tags: [Int]!
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        admin_id = try container.decodeIfPresent(Int.self, forKey: .admin_id)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        created_at = try container.decodeIfPresent(with: DateTransformer(), forKey: .created_at)
        is_private = try container.decodeIfPresent(Bool.self, forKey: .is_private)
        updated_at = try container.decodeIfPresent(with: DateTransformer(), forKey: .updated_at)
        start_time = try container.decodeIfPresent(with: DateTransformer(), forKey: .start_time)
        viewer = try container.decodeIfPresent(Int.self, forKey: .viewer)
        youtube_id = try container.decodeIfPresent(String.self, forKey: .youtube_id)
        tags = try container.decodeIfPresent([Int].self, forKey: .tags)
    }
}
struct Rooms:Codable{
    var rooms:[Room_]!
    
}
class Room: Identifiable,Hashable,Codable{

    static func == (lhs: Room, rhs: Room) -> Bool {
        if((lhs.id  != nil)&&(rhs.id != nil)){
            if(lhs.id==rhs.id){
                return true
            }
        }
        return false
    }
    func  hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var admin_id: Int!
    var created_at: Date!
    var id: Int!
    var is_private: Bool!
    var name: String!
    var password: String!
    var start_time: Date!
    var updated_at: Date!
    var viewer: Int!
    var youtube_id: String!
    var tags: [Int]!
    init(admin_id_:Int,name_:String,id_:Int,is_private_:Bool,start_time_:Date?,viewer_:Int,youtube_id_:String){
        admin_id = admin_id_
        id = id_
        is_private = is_private_
        name = name_
        start_time = start_time_
        viewer = viewer_
        youtube_id = youtube_id_
       
    }
}


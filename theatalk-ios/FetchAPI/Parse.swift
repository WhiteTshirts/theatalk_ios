//
//  Parse.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//
//
//import Foundation
//import Combine
//
//func decode<T: Decodable>(_ data: Data) ->AnyPublisher<T,RoomError>{
//    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .secondsSince1970
//    return Just(data)
//        .decode(type: T.self, decoder: decoder)
//        .mapError{error in
//            .parsing(description: error.localizedDescription)
//        }
//        .eraseToAnyPublisher()
//}

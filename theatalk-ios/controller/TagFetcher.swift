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
    ) -> AnyPublisher<[Tag],APIError>
    func PostTag(
        forTag tag: Tag
    ) -> AnyPublisher<Tag,APIError>
    func EditTag(
        forTag tag: Tag
    ) ->AnyPublisher<Tag,APIError>
    func DeleteTag(
        forTag tag:Tag
    ) -> AnyPublisher<Void,APIError>
    
}
class TagsFetcher{
}

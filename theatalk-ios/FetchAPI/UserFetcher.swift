//
//  UserFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/07.
//

import Foundation
import Combine
protocol UserFechable {
    func GETUsers(
    ) -> AnyPublisher<[User],APIError>
    func GETFollowers(
        forUser user: User
    ) -> AnyPublisher<[User],APIError>
    func POSTFollow(
        forUser user: User
    ) ->AnyPublisher<User,APIError>
    func DELETEFollow(
        forUser user: User
    ) -> AnyPublisher<Void,APIError>
    
}

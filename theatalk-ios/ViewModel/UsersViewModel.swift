//
//  UsersViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/14.
//

import Foundation
import Combine
protocol UsersRelationShip {
    func Follow(userId:Int)
    func UnFollow(userId:Int)
}

final class UsersViewModel: ObservableObject{
    private var disposables:Set<AnyCancellable>
    @Published var isLoading:Bool
    @Published var followers: [User]
    @Published var followings: [User]
    private var imagefetcher = ImageFetcher()
    private var userfetcher = UserFetcher()
    @Published var userId:Int
    init(userId:Int){
        self.disposables = Set<AnyCancellable>()
        self.isLoading = false
        self.followers = []
        self.followings = []
        self.userId = userId
        GetFollowers(userId: userId)
        GetFollowings(userId: userId)
    }
    
    func load(){
        

    }
    func GetFollowers(userId:Int){
        
    }
    func GetFollowings(userId:Int){
        
    }
    func Follow(userId:Int){
        self.userfetcher.POSTFollow(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] user in
            guard let self = self else { return }
        })
        .store(in: &disposables)
    }
    func UnFollow(userId:Int){
        self.userfetcher.DELETEFollow(forUser: userId)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] user in
            guard let self = self else { return }
        })
        .store(in: &disposables)
    }
    
    
}

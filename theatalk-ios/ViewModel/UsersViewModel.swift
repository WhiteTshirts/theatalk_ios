//
//  UsersViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/14.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject{
    private var disposables = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var followers: [User] = []
    @Published var followings: [User] = []
    private var userfetcher = UserFetcher()
    @Published var userId:Int
    init(userId:Int){
        self.userId = userId
        GetFollowers(userId: self.userId)
        GetFollowings(userId: self.userId)
    }
    
    func load(){
        

    }
    func GetFollowers(userId:Int){
        
    }
    func GetFollowings(userId:Int){
        
    }
    func Follow(userId:Int){
        
    }
    func UnFollow(userId:Int){
        
    }
    
    
}

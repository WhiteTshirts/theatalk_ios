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
    @Published var users: [User] = []
    
    private var userfetcher = UserFetcher()
    init(){
    }
    func load(){
        

    }
    func GetFollowers(userId:Int){
        
    }
    func Follow(userId:Int){
        
    }
    func UnFollow(userId:Int){
        
    }
    
    
}

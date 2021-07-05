//
//  AvaterViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/07/05.
//


import Foundation
import Combine
import SwiftUI

final class AvaterViewModel: ObservableObject,ViewModelErrorHandle{
    func ErrorHandle(e: APIError) -> String {
        return ErrorHandling(e: e)
    }
    
    
    private var disposables = Set<AnyCancellable>()
    @Published var user:User
    private var userfetcher = UserFetcher()
    @Published var isFailed:Bool = false
    @Published var ErrorMessage = ""
    init(user:User){
        self.user = user
        self.UsersVM = UsersViewModel(userId: user.id)
        //GetUserInfo()
    }
    func refresh(){
        GetUserInfo()
    }
    func Follow(userId:Int){
        
        self.UsersVM.Follow(userId: userId)
    }
    func UnFollow(userId:Int){
        self.UsersVM.UnFollow(userId: userId)
    }
    func GetUserInfo(){
        userfetcher.GetUser(userId: user.id)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure(let error):
                self.ErrorMessage = self.ErrorHandle(e:error)
                self.isFailed = true
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] user_json in
            guard let self = self else { return }
            
            if(user_json.user != nil){
                
                self.user = user_json.user
                print(self.user.avater_id)
            }
        })
        .store(in: &disposables)
    }
    func setProfileImage(avaterId:Int){
        userfetcher.SetProfile(avaterId: avaterId)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure(let error):
                self.ErrorMessage = self.ErrorHandle(e:error)
                self.isFailed = true
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] avater_json in
            guard let self = self else { return }
        })
        .store(in: &disposables)
    }
    
}

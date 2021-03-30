//
//  ProfileViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/30.
//

import Foundation
import Combine
final class ProfileViewModel: ObservableObject{
    
    private var disposables = Set<AnyCancellable>()
    @Published var user:User
    private var userfetcher = UserFetcher()

    init(user:User){
        self.user = user
        GetUserInfo()
    }
    func GetUserInfo(){
        userfetcher.GetUser(userId: user.id)
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
          receiveValue: { [weak self] user_json in
            guard let self = self else { return }
            
            if(user_json.user != nil){
                self.user = user_json.user
            }
        })
        .store(in: &disposables)
    }
    
    
}

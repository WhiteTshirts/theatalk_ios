//
//  RoomSearchViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/04/14.
//


import Foundation
import Combine
import SwiftUI

final class RoomSearchViewModel: ObservableObject{
    @Published var text: String = ""
    private var disposables = Set<AnyCancellable>()
    @ObservedObject var TagsVM:TagsViewModel
    
    init(){
        self.TagsVM = TagsViewModel(UserId: UserProfile().user_Id)
    }

    func getTags(){
        
    }
}
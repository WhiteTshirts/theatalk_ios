//
//  RoomSearchViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/04/14.
//


import Foundation
import Combine
import SwiftUI

final class RoomSearchViewModel: ObservableObject,ViewModelErrorHandle{
    func ErrorHandle(e: APIError) -> String {
        return ErrorHandling(e: e)
    }
    
    @Published var text: String = ""
    private var disposables = Set<AnyCancellable>()
    @Published var isSuccessed:Bool = true
    @Published var ErrorMessage = ""
    @ObservedObject var TagsVM:TagsViewModel
    
    init(){
        self.TagsVM = TagsViewModel(Id: UserProfile().user_Id)
    }

    func getTags(){
        
    }
}

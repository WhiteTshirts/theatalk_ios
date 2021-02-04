//
//  TagsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//


import Foundation
import Combine


var mockTagsData:[Tag] = [Tag(id_: 0, name_: "モルカー"),Tag(id_: 1, name_: "test2"),Tag(id_: 2, name_: "test3")]

final class TagsViewModel: ObservableObject{
    @Published var followtags: [Tag] = []

    func load(){
        followtags = mockTagsData
    }
    
    
}


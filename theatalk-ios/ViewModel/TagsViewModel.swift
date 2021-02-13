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
    private var disposables = Set<AnyCancellable>()
    @Published var tags: [Tag] = []
    private var tagFetcher = TagFetcher(url: "http://localhost:5000/api/v1/tags")
    init(){
        self.tags = mockTagsData
//        tagFetcher.GETTags()
//            .sink(
//          receiveCompletion: { [weak self] value in
//            guard let self = self else { return }
//            switch value {
//            case .failure:
//              break
//            case .finished:
//              break
//            }
//          },
//          receiveValue: { [weak self] tags in
//            guard let self = self else { return }
//            self.tags = tags.tags
//        })
//        .store(in: &disposables)
    }
    func load(){
        self.tags = mockTagsData

//        tagFetcher.GETTags()
//            .sink(
//          receiveCompletion: { [weak self] value in
//            guard let self = self else { return }
//            switch value {
//            case .failure:
//              break
//            case .finished:
//              break
//            }
//          },
//          receiveValue: { [weak self] tags in
//            guard let self = self else { return }
//            self.tags = tags.tags
//        })
//        .store(in: &disposables)
        
    }
//    func login() -> AnyPublisher<User, Error> {
//
//    }
    
}


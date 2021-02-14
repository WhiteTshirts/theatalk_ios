//
//  TagsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//


import Foundation
import Combine


var mockTagsData:[Tag] = [Tag(id_: 0, name_: "モルカー"),Tag(id_: 1, name_: "test2"),Tag(id_: 2, name_: "test3"),Tag(id_: 3, name_: "test4"),Tag(id_: 5, name_: "test5"),Tag(id_: 6, name_: "test6"),Tag(id_: 7, name_: "test7"),Tag(id_: 8, name_: "test8"),Tag(id_: 9, name_: "test9"),Tag(id_: 10, name_: "test10"),Tag(id_: 11, name_: "test11"),Tag(id_: 12, name_: "test12"),Tag(id_: 13, name_: "test13")]

final class TagsViewModel: ObservableObject{
    private var disposables = Set<AnyCancellable>()
    @Published var tags: [Tag] = []
    private var tagFetcher = TagFetcher(url: "http://localhost:5000/api/v1/tags")
    init(){
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


        
    }
    func getTags(){
            tagFetcher.GETTags()
                .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.tags = []
                  break
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] tags in
                guard let self = self else { return }
                self.tags = tags.tags
            })
            .store(in: &disposables)
    }
    func searchTags(tagName:String){
        tagFetcher.SearchTagsbyName(tagName: tagName).sink(receiveCompletion: {[weak self] value in
            guard let self = self else {return}
            switch value {
            case .failure:
                self.tags = []
                break
                
            case .finished:
                break
            }
        }, receiveValue: {[weak self] tags_json in
            guard let self = self else {return}
            self.tags = tags_json.tags
            
        }).store(in: &disposables)
    }
//    func login() -> AnyPublisher<User, Error> {
//
//    }
    
}


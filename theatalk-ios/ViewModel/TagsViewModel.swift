//
//  TagsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//


import Foundation
import Combine


var mockTagsData:[Tag] = [Tag(id_: 0, name_: "モルカー"),Tag(id_: 1, name_: "test2"),Tag(id_: 2, name_: "test3"),Tag(id_: 3, name_: "test4"),Tag(id_: 5, name_: "test5"),Tag(id_: 6, name_: "test6"),Tag(id_: 7, name_: "test7"),Tag(id_: 8, name_: "test8"),Tag(id_: 9, name_: "test9"),Tag(id_: 10, name_: "test10"),Tag(id_: 11, name_: "test11"),Tag(id_: 12, name_: "test12"),Tag(id_: 13, name_: "test13")]

class TagsViewModel: ObservableObject,ViewModelErrorHandle{
    func ErrorHandle(e: APIError) -> String {
        return ErrorHandling(e: e)
    }
    
    private var disposables = Set<AnyCancellable>()
    @Published var tags: [Tag] = []
    @Published var UserTags:[Tag] = []
    var UserId:Int?
    var index:Int = 0
    @Published var isSuccessed:Bool = true
    @Published var ErrorMessage = ""
    @Published var SearchText:String = ""{
        didSet{
            self.searchTags(tagName: SearchText)
        }
    }
    private var tagFetcher = TagFetcher()
    init(UserId:Int?){
        self.UserId = UserId
        load()

    }
    func SearchTag()-> Tag?{
        if(UserTags.count>0){
            
            return UserTags[self.index]
        }else{
            return nil
        }
    }
    
    func NextTag()->Tag?{
        if(index+1 >= UserTags.count){
            return nil
        }else{
            self.index += 1
            return UserTags[index]
        }
    }
    func BeforeTag()->Tag?{
        if(index-1 >= 0){
            self.index -= 1
            return UserTags[self.index]
            
        }else{
            return nil
        }
    }
    func load(){
        if(UserId != nil){
            
           getTags()
           getUserTags()
            return
        }
        getTags()

    }
    func AddTagToUser(tagId:Int){
        tagFetcher.CreateUsersTag(tagId: tagId)
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
          receiveValue: { [weak self] tags in
            guard let self = self else { return }
        })
        .store(in: &disposables)
    }
    func DeleteTagFromUser(tagId:Int){
        tagFetcher.DeleteUsersTag(tagId: tagId)
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
          receiveValue: { [weak self] tags in
            guard let self = self else { return }
        })
        .store(in: &disposables)
    }
    func getUserTags(){
        
        tagFetcher.GetUserTags(userId: self.UserId!)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.UserTags = []
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] tags in
            guard let self = self else { return }
            if(tags.tags != nil){
                self.UserTags = tags.tags

            }
        })
        .store(in: &disposables)
    }
    func getTags(){
            tagFetcher.GETTags()
                .receive(on: DispatchQueue.main)
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
                if(tags.tags != nil){
                    self.tags = tags.tags
                }
              })
            .store(in: &disposables)
    }
    func postTag(tagName:String){
        tagFetcher.PostTag(tag_name: tagName)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            print(value)
            switch value {
            case .failure:
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] tag in
            guard let self = self else { return }
            if(tag.tag != nil){
                self.tags.append(tag.tag)
            }
            
          })
        .store(in: &disposables)
    }
    func searchTags(tagName:String){
        tagFetcher.SearchTagsbyName(tagName: tagName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
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
    
}
class SearchTagsViewModel: TagsViewModel{
    override init(UserId:Int?){
        super.init(UserId: UserId)
        getTags();
    }
}

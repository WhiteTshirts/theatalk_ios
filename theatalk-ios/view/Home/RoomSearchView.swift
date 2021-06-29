//
//  RoomSearchView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/02.
//

import SwiftUI
import Combine
enum SelectedType{
    case tag
    case keyword
    case user
    
}
protocol IncrementSearchInterface {
    func IncrementSearch()
}
struct SearchFieldView: View{
    @State var selected = SelectedType.tag
    @State var text = ""
    var body: some View{
        VStack{
            RoomSearchByTagView()

            
        }

    }
}

struct RoomSearchByTagView: View,IncrementSearchInterface{
    func IncrementSearch() {
        
    }
    
    @State var TagId = -1

    var body: some View {

            ScrollView{
                RoomList(RoomsVM: RoomsViewModelTag())
            }
            
    
    }
}
struct KeywordSearchView:View,IncrementSearchInterface{
    func IncrementSearch() {
    }
    
    @ObservedObject var TagVM = SearchTagsViewModel(Id: UserProfile().user_Id)
    
    var body: some View {
        TextField("検索",text:$TagVM.SearchText)
    
        VStack{
        }
    }
}


struct TagSearchView:View,IncrementSearchInterface{
    func IncrementSearch() {
    }
    
    @ObservedObject var TagVM = SearchTagsViewModel(Id: UserProfile().user_Id)
    var body: some View {
        TextField("検索",text:$TagVM.SearchText)
        
        VStack{
            List{
                if(TagVM.tags.count>0){
                    ForEach(TagVM.tags){tag in
                        NavigationLink(destination: RoomList(RoomsVM: RoomsViewModelTag(tagId: tag.id))) {
                            Text(tag.name)
                        }
                    }
                }else if(TagVM.tags.count == 0 && TagVM.SearchText != ""){
                    HStack{
                        Text(TagVM.SearchText)
                        Button(action: {
                            TagVM.postTag(tagName: TagVM.SearchText)
                        }, label: {
                            Text("追加")
                        })
                    }
                }
            }
        }
    }
}
struct RoomSearchView: View {
    @ObservedObject var RoomSearchVM = RoomSearchViewModel()

    @State var SelectedRooms = false
    @State var IsSearch = false
    var body: some View {

        ZStack{
            VStack{
                TextField("検索",text:$RoomSearchVM.text).onTapGesture {
                    self.IsSearch = true
                }
                NavigationLink(destination:TagSearchView(),isActive:$IsSearch){
                    RoomSearchByTagView()

                }
                
            }
            

        }



    }
}
//
//struct RoomSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomSearchView()
//    }
//}

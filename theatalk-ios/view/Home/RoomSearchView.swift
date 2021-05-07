//
//  RoomSearchView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/02.
//

import SwiftUI
enum SelectedType{
    case tag
    case keyword
    case user
    
}
struct SearchFieldView: View{
    @State var selected = SelectedType.tag
    @State var text = ""
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    selected = .keyword
                }, label: {
                    Text("キーワード").foregroundColor(selected == .keyword ? .blue : .red)
                    
                })
                Button(action: {
                    selected = .tag
                }, label: {
                    Text("タグ").foregroundColor(selected == .tag ? .blue : .red)

                })
            }
            TextField("検索",text:$text)
            if(selected == .tag){
                
                TagSearchView(SearchText: self.$text)
            }else{
                RoomSearchByTagView()

            }
            
            
        }

    }
}

struct RoomSearchByTagView: View{
    @State var TagId = -1

    var body: some View {
        VStack{
            ScrollView{
                RoomList(RoomsVM: RoomsViewModelTag(), tagId:self.$TagId)
            }
            
        }
    }
}

struct TagSearchView:View{
    @ObservedObject var TagVM = TagsViewModel(UserId: UserProfile().user_Id)
    @Binding var SearchText:String
    var body: some View {
        VStack{
            List{
                ForEach(TagVM.tags){tag in
                    Text(tag.name)
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
                NavigationLink(destination:SearchFieldView(),isActive:$IsSearch){
                    RoomSearchByTagView()

                }
                
            }
            

        }



    }
}
//
struct RoomSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RoomSearchView()
    }
}

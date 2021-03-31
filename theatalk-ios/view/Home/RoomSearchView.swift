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
}
struct SearchRoomView: View{
    @State var selected = SelectedType.keyword
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    selected = .keyword
                }, label: {
                    if(selected == .keyword){
                        Text("キーワード")
                    }else{
                        Text("キーワード")

                    }
                })
                Button(action: {
                    selected = .tag
                }, label: {
                    if(selected == .tag){
                        Text("タグ")
                    }else{
                        Text("タグ")

                    }
                    
                })
            }
        }

    }
}

struct RoomSearchView: View {
    @State var SelectedRooms = false
    @State var TagId = -1
    var body: some View {
        ZStack{
            //Color.black.ignoresSafeArea()
            VStack(alignment: .center){
                SearchRoomView()
                //                ChangeSearchTagView(TagsVM: TagsViewModel(UserId: profile.user_Id), SelectedTagName: self.$textEntered, SearchTagId: self.$SearchTagId)
    //                    .frame(width: UIScreen.screenWidth, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModelTag(), tagId:self.$TagId)
                    }
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

//
//  RoomSearchView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/02.
//

import SwiftUI

struct RoomSearchView: View {
    @Binding var TagId:Int
    @State var SelectedRooms = false

    var body: some View {
        ZStack{
            Color.red.ignoresSafeArea()
            VStack(alignment: .center){
    //                ChangeSearchTagView(TagsVM: TagsViewModel(UserId: profile.user_Id), SelectedTagName: self.$textEntered, SearchTagId: self.$SearchTagId)
    //                    .frame(width: UIScreen.screenWidth, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModel(), tagId:self.$TagId)
                    }
                }
            }
        }

    }
}

//struct RoomSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomSearchView()
//    }
//}

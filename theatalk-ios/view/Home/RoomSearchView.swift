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
    
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    selected = .keyword
                }, label: {
                    if(selected == .keyword){
                        Text("キーワード").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }else{
                        Text("キーワード").foregroundColor(.red)

                    }
                })
                Button(action: {
                    selected = .tag
                }, label: {
                    if(selected == .tag){
                        Text("タグ").foregroundColor(.blue)
                    }else{
                        Text("タグ").foregroundColor(.red)

                    }

                })
            }
        }

    }
}

struct RoomSearchByTagView: View{
    @State var TagId = -1

    var body: some View {
        VStack{
            //tag
            //roomlist
            ScrollView{
                RoomList(RoomsVM: RoomsViewModelTag(), tagId:self.$TagId)
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
            NavigationView{
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
}
//
struct RoomSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RoomSearchView()
    }
}

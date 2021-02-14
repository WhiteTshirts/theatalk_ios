//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI


struct Sidemenu: View{
    
    @Binding var info: Bool
    var body: some View{
        VStack(alignment: .center){
            Button(action: {
                info = !info
            }){
                Image(systemName: "list.dash").resizable()
                .frame(width: ProfileSize.width,height: ProfileSize.height)
            }
            HStack {
                Image(systemName: "person")
                Text("Profile")
            }
            HStack {
                Spacer()
                Image(systemName: "text.bubble")
                Text("Tags")
            }
            Spacer()
        }
        
    }
}
struct NavItem: View{
    @Binding var info: Bool
    @Binding var textEntered: String
    @State var TextInputting = true
    @ObservedObject var TagsVM = TagsViewModel()
    var body: some View{
        VStack{
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Button(action: {
                        info = !info
                    }){
                        Image(systemName: "list.dash").resizable()
                        .frame(width: ProfileSize.width,height: ProfileSize.height)
                    }
                    HStack{
                    TextField("tagで検索",text:$textEntered,
                              onEditingChanged: { begin in
                                   if begin {
                                    self.TextInputting = true
                                   } else {
                                    self.TextInputting = false
                                   }
                                TagsVM.searchTags(tagName: textEntered)
                               })
                        
                    }
                    NavigationLink("+",destination:CreateRoom())
                }
            }
            ScrollView(.horizontal){
                HStack{
                    ForEach(TagsVM.tags){tag in
                        Text("\(tag.name)")
                            .font(.caption2)
                    }
                }

            }.frame(width: RoomSize_Column1.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            


            
        }

        
    }


}
//protocol EnterRoomDele {
//    func enterroom(room_num:Int)
//}
struct Home: View {
    @EnvironmentObject var session: Session

    @State var loading = true
    @State var textEntered = ""
    @State var info = false
    @State var authfetcher = AuthFetcher()
    @State var SearchTagId = -1
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment:.leading){
                NavigationView {
                    VStack(alignment: .center){
                        HStack{
                            ScrollView{
                                RoomList(RoomsVM: RoomsViewModel(tagId: SearchTagId))
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                                NavItem(info: self.$info, textEntered: self.$textEntered)
                            
                        }
                    }

                }
                if info {
                    Sidemenu(info: self.$info)
                        .frame(width:UIScreen.screenWidth/2,height: UIScreen.screenHeight,alignment: .leading)
                        .background(Color.white)
                        .animation(.default)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }
            }.gesture(DragGesture(minimumDistance: 5)
                        .onChanged{_ in
                            
                        }
                        .onEnded{ _ in
                            
                        })
        }

    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
                    Home().environmentObject(Session(login: true, user: mockUserData))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
    
}

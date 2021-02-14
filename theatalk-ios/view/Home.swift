//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI


struct Sidemenu: View{
    @State private var showingAlert = false
    @Binding var info: Bool
    var logoutdel: logoutDel
    var body: some View{
        VStack(alignment: .center){
            Button(action: {
                info = !info
            }){
                Image(systemName: "list.dash").resizable()
                .frame(width: ProfileSize.width,height: ProfileSize.height)
            }
            HStack {
                Button(action: {
                }){
                    Image(systemName: "person")
                    Text("Profile")
                    
                }

            }
            HStack {
                Button(action: {
                }){
                    Image(systemName: "text.bubble")
                    Text("Tags")
                    
                }.alert(isPresented: $showingAlert){
                    Alert(title: Text("ログアウトしますか")
                          ,primaryButton: .default(Text("はい"),
                                                   action:{
                                                    logoutdel.logout()
                                                   }), secondaryButton: .default(Text("いいえ")))
                }
            }
            HStack{
                Button(action: {
                    self.showingAlert = true

                }){
                    Text("logout")
                    
                }
            }
            Spacer()
        }
        
    }
}
struct NavItem: View{
    @Binding var info: Bool
    @Binding var textEntered: String
    @Binding var TagId:Int
    @State var TextInputting = true
    @State var TextChanged = false
    @ObservedObject var TagsVM = TagsViewModel()
    func UpdateSearchTag(tag:Tag){
        DispatchQueue.main.async {
            self.TagId = tag.id
            self.textEntered = tag.name
            TextChanged = true
            print(self.TagId)
        }
    }
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
                                
//                                if(textEntered == ""){
//                                    DispatchQueue.main.async {
//                                        TagId = -1
//                                    }
//                                }
                                
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
                        Button(action:{
                            UpdateSearchTag(tag: tag)
                        }){
                            Text("\(tag.name)")
                                .font(.caption2)
                        }

                    }
                }

            }.frame(width: RoomSize_Column1.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }

    }


}
//protocol EnterRoomDele {
//    func enterroom(room_num:Int)
//}
protocol logoutDel {
    func logout()
}
struct Home: View,logoutDel {
    func logout() {
        session.user = nil
        profile.token = ""
        profile.password = ""
        profile.username = ""
        profile.user_Id = -1
    }
    
    @EnvironmentObject var session: Session
    @ObservedObject var profile = UserProfile()
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
                                RoomList(RoomsVM: RoomsViewModel(),tagId:self.$SearchTagId)
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            NavItem(info: self.$info, textEntered: self.$textEntered,TagId: self.$SearchTagId)
                            
                        }
                    }

                }
                if info {
                    Sidemenu(info: self.$info,logoutdel: self)
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

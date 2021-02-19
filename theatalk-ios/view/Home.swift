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
    @Binding var pushed: Bool
    @Binding var SelectedMenu: String
    var sideDel: SideMenuDel
    var MenuNames = ["Profile","Tags","Following","Follower","Help"]
    var SystemImageNames = ["person","text.bubble","person.circle","person.circle.fill","questionmark"]
    func logoutView()-> some View{
        return
            Button(action: {
            self.showingAlert = true
        }){
            Image(systemName: "figure.wave.circle")
            Text("logout")
            
        }.alert(isPresented: $showingAlert){
            Alert(title: Text("ログアウトしますか")
                  ,primaryButton: .default(Text("はい"),
                        action:{
                            sideDel.logout()
                                           }), secondaryButton: .default(Text("いいえ")))
        }
    
    }
    var body: some View{
        
        VStack(alignment: .trailing){
            
            Spacer().frame(height:100)
            Button(action: {
                info = !info
            }){
                Image(systemName: "xmark.circle").resizable()
                    .frame(width: ProfileSize.width,height: ProfileSize.height)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            HStack{
                Spacer()
                    .frame(width: 15)
                VStack(alignment: .leading) {
                    ForEach(0..<5){num in
                        Button(action: {
                            self.SelectedMenu = MenuNames[num]
                            sideDel.toggle(sidemenu: MenuNames[num])
                        }){
                            Image(systemName: SystemImageNames[num])
                            Text(MenuNames[num])
                        }
                    }
                    logoutView()

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
    @ObservedObject var TagsVM: TagsViewModel
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
                    NavigationLink("ルーム追加",destination:CreateRoom())
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
protocol SideMenuDel {
    func logout()
    func toggle(sidemenu:String)
}
struct Home: View,SideMenuDel {

    
    @EnvironmentObject var session: Session
    @ObservedObject var profile = UserProfile()
    @State var loading = true
    @State var textEntered = ""
    @State var info = false
    @State var authfetcher = AuthFetcher()
    @State var SearchTagId = -1
    @State var SelectedRooms = false
    @State var PushedPages = false
    @State var SelectedMenu = "Profile"
    
    func toggle(sidemenu:String) {
        DispatchQueue.main.async {
            self.PushedPages = true
        }


    }
    func logout() {
        session.user = nil
        profile.token = ""
        profile.password = ""
        profile.username = ""
        profile.user_Id = -1
    }


    var body: some View {

        GeometryReader{ geometry in
            ZStack(alignment:.topLeading){

                NavigationRooms()
                if info {
                    Sidemenu(info: self.$info, pushed: self.$PushedPages, SelectedMenu: self.$SelectedMenu, sideDel: self)
                        .frame(width:UIScreen.screenWidth/2,height: UIScreen.screenHeight,alignment: .leading)
                        .background(Color.white)
                        .animation(.default)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        .edgesIgnoringSafeArea(.all)
                }
            }

        }.gesture(DragGesture(minimumDistance: 5)
                    .onChanged{_ in
                        
                    }
                    .onEnded{ _ in
                        
                    })
        .sheet(isPresented: self.$PushedPages, content: {
                SelectedView
        })

        


    }
    func NavigationRooms()-> some View{
        return NavigationView {

            VStack(alignment: .center){
                HStack{
                    ScrollView{
                        RoomList(tagId:self.$SearchTagId, IsSelected: self.$SelectedRooms)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .principal){
                    NavItem(info: self.$info, textEntered: self.$textEntered,TagId: self.$SearchTagId, TagsVM: TagsViewModel(UserId: profile.user_Id))
                    
                }
            }

        }
    }

}
extension Home{

    var SelectedView: some View {
        switch self.SelectedMenu{
                case "Profile":
                    return AnyView(UserProfileView(user:session.user!,TagsVM: TagsViewModel(UserId: profile.user_Id)))
                case "Tags":
                    return AnyView(TagList(TagsVM: TagsViewModel(UserId: profile.user_Id)))
                case "Following":
                    return AnyView(UsersList(UsersView: UsersViewModel(userId: self.session.user?.id ?? -1), isFollowList: true))
                case "Follower":
                    return AnyView(UsersList(UsersView: UsersViewModel(userId: self.session.user?.id ?? -1), isFollowList: false))
                default:
                    return AnyView(UserProfileView(user:session.user!,TagsVM: TagsViewModel(UserId: profile.user_Id)))
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

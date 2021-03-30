//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI

enum Tab{
    case Home
    case Search
    case History
    case DM
    case Profile
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
//struct ChangeSearchTagView: View{
//
//    @ObservedObject var TagsVM: TagsViewModel
//    @Binding var SelectedTagName:String
//    @Binding var SearchTagId:Int
//    func SetSearchTag(tag:Tag?){
//        if(tag == nil){
//            DispatchQueue.main.async {
//                self.SelectedTagName = ""
//                self.SearchTagId = -1
//            }
//        }else{
//            DispatchQueue.main.async {
//                self.SelectedTagName = tag!.name
//                self.SearchTagId = tag!.id
//            }
//        }
//    }
//    var body: some View{
//        HStack{
//            VStack(alignment: .leading){
//                Button(action: {
//                    SetSearchTag(tag:self.TagsVM.BeforeTag())
//                }, label: {
//                    Image(systemName: "arrow.left.circle")
//                        .resizable()
//                        .frame(width:40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)                })
//            }
//            Spacer()
//            Text("\(SelectedTagName)")
//            Spacer()
//            VStack(alignment: .trailing){
//
//                Button(action: {
//                    SetSearchTag(tag:self.TagsVM.NextTag())
//                }, label: {
//                    Image(systemName: "arrow.right.circle")
//                        .resizable()
//                        .frame(width:40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)                })
//            }
//        }
//
//    }
//}
protocol logoutDel {
    func logout()
}
struct ToolBarView:View{
    @Binding var SelectedTab:Tab
    @Binding var TagId:Int
    var body:some View{
        switch SelectedTab {
            case .Home:
                    Text("Home")
                
            case .Search:
                Text("Search")
            case .History:
                
                Text("History")
                Button(action: {
                }){
                    Image(systemName: "plus.app")

                }
            case .Profile:
                Text("Profile")
                Button(action: {
                }){
                    Image(systemName: "person")

                }
            case .DM:
                HStack{
                    Text("DM")
                    Spacer()
                    Button(action: {
                        
                    }){
                        Image(systemName: "plus.message")

                    }

                }
                
            
            
        }
    }
}
struct HomeLayoutView:View{
    
    @EnvironmentObject var session: Session
    @ObservedObject var profile = UserProfile()
    @ObservedObject var TagsVM :TagsViewModel
    @State var info = false
    @State var PushedPages = false
    @State var SelectedMenu = "Profile"
    @State var SelectedTagName = ""
    @State var SelectedTab:Tab = .Home
    @State var TagId = -1


    var body:some View{
        ZStack(alignment:.topLeading){
            NavigationView{

                SelectTabView(selected: self.$SelectedTab, TagId: self.$TagId)
                    .toolbar(content: {
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            ToolBarView(SelectedTab: self.$SelectedTab,TagId: self.$TagId)

                            
                        }
                        
                    })
            }
            

        }.background(Color.red)

    }
}
struct SelectTabView:View, logoutDel{

    @State private var selection: Tab = .Home
    @State private var message = "ボタンをタップしてください"
    @Binding var selected:Tab
    @Binding var TagId:Int
    @ObservedObject var profile = UserProfile()
    @EnvironmentObject var session: Session
    func logout() {
        session.user = nil
        profile.token = ""
        profile.password = ""
        profile.username = ""
        profile.user_Id = -1
    }
    
    var body:some View{
        TabView(selection: $selection){
            TimelineView()
                .tabItem{
                    Label("Home",systemImage:"house")
                }
                .tag(Tab.Home)
                .onAppear{
                    self.selected = .Home
                }
            RoomSearchView(TagId: self.$TagId)
                .background(Color.red)
                .tabItem{
                    Label("Search",systemImage:"magnifyingglass")
                }
                .tag(Tab.Search)
                .onAppear{
                    self.selected = .Search
                }
            RoomHistoryView()
                .tabItem{
                    Label("History",systemImage:"clock")
                }
                .tag(Tab.History)
                .onAppear{
                    self.selected = .History
                }
            DMView()
                .tabItem{
                    Label("DM",systemImage:"message")
                }
                .tag(Tab.DM)
                .onAppear{
                    self.selected = .DM
                }
            UserProfileView(logout: self, user:session.user ?? User(name_:"",user_id:-1), TagsVM: TagsViewModel(UserId: profile.user_Id), ProfileVM: ProfileViewModel(user: session.user ?? User(name_:"",user_id:-1)))
                .tabItem{
                    Label("Profile",systemImage:"person")
                }
                .tag(Tab.Profile)
                .onAppear{
                    self.selected = .Profile
                }

            
        }.onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        .accentColor(.red)
        .background(Color.red)


        
    }
}

extension SelectTabView{
    
}
struct HomeLayout_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeLayoutView( TagsVM: TagsViewModel(UserId: 8))
        
    }
    
}

//protocol EnterRoomDele {
//    func enterroom(room_num:Int)
//}


struct Home: View{

    
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
    @State var SelectedTagName = ""
    @ObservedObject var TagsVM :TagsViewModel

    var body: some View {
        GeometryReader{ geometry in
//            ZStack(alignment:.topLeading){
//                NavigationRooms()
//                if info {
//                    SidemenuView(info: self.$info, pushed: self.$PushedPages, SelectedMenu: self.$SelectedMenu, sideDel: self)
//                        .frame(width:UIScreen.screenWidth/2,height: UIScreen.screenHeight,alignment: .leading)
//                        .background(Color.white)
//                        .animation(.default)
//                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
//                        .edgesIgnoringSafeArea(.all)
//                }
//            }

        }.gesture(DragGesture(minimumDistance: 5)
                    .onChanged{_ in
                        print("changed")
                    }
                    .onEnded{ _ in
                        
        })
       
    }
    func NavigationRooms()-> some View{
        return NavigationView {

            VStack(alignment: .center){
//                ChangeSearchTagView(TagsVM: TagsViewModel(UserId: profile.user_Id), SelectedTagName: self.$textEntered, SearchTagId: self.$SearchTagId)
//                    .frame(width: UIScreen.screenWidth, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModel(), tagId:self.$SearchTagId)
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


struct Home_Previews: PreviewProvider {
    static var previews: some View {
                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
                    Home(TagsVM: TagsViewModel(UserId: 3)).environmentObject(Session(login: true, user: mockUserData))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
    
}

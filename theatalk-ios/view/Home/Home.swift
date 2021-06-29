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
                                   if begin {
                                    self.TextInputting = true
                                   } else {
                                    self.TextInputting = false

                                   }
                                TagsVM.searchTags(tagName: textEntered)
                               })
                        
                    }
                    NavigationLink("ルーム追加",destination:EmptyView())
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
protocol logoutDel {
    func logout()
}
struct ToolBarView:View{
    @Binding var SelectedTab:Tab
    @Binding var TagId:Int
    @State var createdRoom:Room!
    var body:some View{
        switch SelectedTab {
            case .Home:
                HStack{
                    Text("Home")
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        
                    
                    NavigationLink(
                        
                        destination: CreateRoom(),
                        label: {
                            Text("部屋追加")
                            Image(systemName: "plus")
                        })

                }.onDisappear(){
                    createdRoom = nil
                }
                    
                
            case .Search:
                Text("Search")
                    .fontWeight(.heavy)

            case .History:
                
                Text("History")
                    .fontWeight(.heavy)

            case .Profile:
                Text("Profile")
                    .fontWeight(.heavy)

                Button(action: {
                }){
                    Image(systemName: "person")

                }
            case .DM:
                HStack{
                    Text("DM")
                        .fontWeight(.heavy)

                    Spacer()
                    NavigationLink(
                        destination: EmptyView(),
                        label: {
                            Text("DM追加")
                            Image(systemName: "plus.message")
                        })

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
    @State var a:Bool = false
    @Binding var TagId:Int
    @ObservedObject var profile = UserProfile()
    @EnvironmentObject var session: Session
    func logout() {
        
        session.user = nil
        profile.token = ""
        profile.password = ""
        profile.username = ""
        profile.user_Id = -1
        profile.token_invalid = true
    }
    
    var body:some View{
        TabView(selection: $selection){
            TimelineView()
                .tabItem{
                    if(profile.token_invalid){
                        
                        Label("invalid",systemImage:"house")
                    }else{
                        
                        Label("valid",systemImage:"house")
                    }
                }
                .tag(Tab.Home)
                .onAppear{
                    self.selected = .Home
                }
            RoomSearchView()
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
            UserProfileView(logoutdel: self,user:session.user)
                .tabItem{
                    Label("Profile",systemImage:"person")
                }
                .tag(Tab.Profile)
                .onAppear{
                    self.selected = .Profile
                }
            
        }.alert(isPresented:
                    $profile.token_invalid, content: {
            Alert(title: Text("認証期限切れ"),                message: Text("ログインしますか?"),
                  primaryButton: .default(Text("閉じる"))
                  ,secondaryButton: .default(Text("ログインする"),action: {
                    session.user = nil
                  })
            )
        })
        .onAppear() {
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
        
        HomeLayoutView( TagsVM: TagsViewModel(Id: 8))
        
    }
    
}


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
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModel())
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .principal){
                    NavItem(info: self.$info, textEntered: self.$textEntered,TagId: self.$SearchTagId, TagsVM: TagsViewModel(Id: profile.user_Id))
                    
                }
            }

        }
    }

}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
                    Home(TagsVM: TagsViewModel(Id: 3)).environmentObject(Session(login: true, user: mockUserData))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
    
}

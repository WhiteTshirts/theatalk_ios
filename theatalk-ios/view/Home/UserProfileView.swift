//
//  UserProfileView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/16.
//

import SwiftUI

struct ProfileView: View, UsersRelationShip{
    var user:User
    @ObservedObject var ProfileVM: ProfileViewModel
    init(user:User!){
        self.user = user  ?? User(name_: "", user_id: user.id)
        ProfileVM = ProfileViewModel(user:self.user)
    }
    func Follow(userId: Int) {
        self.ProfileVM.Follow(userId: userId)

    }
    
    func UnFollow(userId: Int) {
        self.ProfileVM.UnFollow(userId: userId)
    }

    var body: some View {
        NavigationView{
            VStack{
                ProfileVM.user.image
                .resizable()
                .frame(width:100,height: 100)
                Text("名前:\(ProfileVM.user.name)")
                HStack{
                    Text("登録タグ一覧")
                    if(ProfileVM.user.tags != nil){
                        GetTags(tags: user.tags!, isUserTag: true, color: Color.red)
                    }
                    if(ProfileVM.user.followings != nil && ProfileVM.user.followers != nil){
                        HStack{
                            NavigationLink(
                                destination: UsersList(users:ProfileVM.user.followings, userRelation: self),
                                label: {
                                    Text("フォロー数:\(ProfileVM.user.followings.count)")
                                })
                            NavigationLink(
                                destination: UsersList(users:ProfileVM.user.followers, userRelation: self),
                                label: {
                                    Text("フォロワー数:\(ProfileVM.user.followers.count)")
                                })
                        }
                    }
                }
            }
        }
    }
}
struct UserProfileView: View,UsersRelationShip {
    func Follow(userId: Int) {
        
        self.ProfileVM.Follow(userId: userId)
    }
    
    func UnFollow(userId: Int) {
        self.ProfileVM.UnFollow(userId: userId)
    }
    
    var logout:logoutDel
    var user:User
    
    @State var isEditing = false
    @ObservedObject var TagsVM: TagsViewModel
    @EnvironmentObject var session: Session
    @ObservedObject var ProfileVM: ProfileViewModel
    init(logoutdel:logoutDel,user:User!){
        self.logout = logoutdel
        self.user = user  ?? User(name_: "", user_id: -1)
        TagsVM = TagsViewModel(Id: self.user.id)
        ProfileVM = ProfileViewModel(user:self.user)
    }
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        user.image
                            .resizable()
                            .frame(width:100,height: 100)
                    })

                Text("名前:\(user.name)")
                HStack{
                Text("登録タグ一覧")
                Image(systemName: "tag")
                        NavigationLink(
                            destination:TagList(TagsVM: TagsVM),label:{
                            Image(systemName: "plus")
                    })
                }
                if(ProfileVM.user.tags != nil){
                    GetTags(tags: ProfileVM.user.tags!, isUserTag: true, color: Color.red)
                }
                if(ProfileVM.user.followings != nil && ProfileVM.user.followers != nil){
                    HStack{
                        NavigationLink(
                            destination: UsersList(users:ProfileVM.user.followings, userRelation: self),
                            label: {
                                Text("フォロー数:\(ProfileVM.user.followings.count)")
                            })
                        NavigationLink(
                            destination: UsersList(users:ProfileVM.user.followers, userRelation: self),
                            label: {
                                Text("フォロワー数:\(ProfileVM.user.followers.count)")
                            })
                    }
                    
                }
                Button(action:{
                    logout.logout()
                }){
                    Text("logout")
                        .fontWeight(.medium)
                         .frame(minWidth: 160)
                         .foregroundColor(.white)
                         .padding(12)
                         .background(Color.accentColor)
                         .cornerRadius(8)
                }
            }.onAppear(){
                self.ProfileVM.refresh()
            }
        }.alert(isPresented: self.$ProfileVM.isFailed) {
            Alert(title: Text(self.ProfileVM.ErrorMessage))
        }

    }
    func TagItem(for text:String,color:Color) -> some View{
        Text(text)
            .padding(.all,5)
            .font(.footnote)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(3)

    }

}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnyView(UserProfileView(user:mockUserData, logout: SideMenuDel(),TagsVM: TagsViewModel(UserId: 0)))
//    }
//}

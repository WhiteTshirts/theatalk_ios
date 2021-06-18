//
//  UserProfileView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/16.
//

import SwiftUI
struct OtherProfileView: View{
    var user:User
    @ObservedObject var ProfileVM: ProfileViewModel
    var body: some View{
        VStack{
            
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
        TagsVM = TagsViewModel(UserId: self.user.id)
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
    private func GetTags(tags:[Tag],isUserTag:Bool,color:Color) ->some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags){ tag in
                TagItem(for: tag.name, color: color)
                    .padding(.all,8)
                    .alignmentGuide(.leading, computeValue: { d in
                      if abs(width - d.width) > 300 {
                        width = 0
                        height -= d.height
                      }
                      let result = width
                        if tag == tags.last {
                        width = 0
                      } else {
                        width -= d.width
                      }
                      return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                      let result = height
                        if tag == tags.last {
                        height = 0
                      }
                      return result
                    })
                
            }
        }
      }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnyView(UserProfileView(user:mockUserData, logout: SideMenuDel(),TagsVM: TagsViewModel(UserId: 0)))
//    }
//}

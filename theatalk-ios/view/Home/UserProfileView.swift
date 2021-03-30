//
//  UserProfileView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/16.
//

import SwiftUI
struct ProfileView: View{
    var user:User

    var body: some View{
        VStack{
            
        }
    }
}
struct UserProfileView: View {
    var logout:logoutDel
    var user:User
    

    @ObservedObject var TagsVM: TagsViewModel
    @EnvironmentObject var session: Session
    @ObservedObject var ProfileVM: ProfileViewModel
    var body: some View {
        VStack{
            Text("名前:\(user.name)")
            Text("登録タグ一覧")
            if(ProfileVM.user.tags != nil){
                GetTags(tags: ProfileVM.user.tags!, isUserTag: true, color: Color.red)
            }
            Button(action:{
                logout.logout()
            }){
                Text("logout")
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

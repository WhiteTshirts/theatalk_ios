//
//  UsersList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/14.
//

import SwiftUI
protocol UserRelationshipdel {
    func follow(userId:Int)
    func unfollow(userId:Int)
}
struct UserCell: View{
    @State var user:User
    var Followdel:UserRelationshipdel
    var body: some View {
        VStack(alignment: .center){
  
            
        }
        
    }
}

struct UsersList: View,UserRelationshipdel {
    func follow(userId: Int) {
    }
    
    func unfollow(userId: Int) {
        

    }
    var users:[User]
    
    func UserCellView(user:User) -> some View{
        VStack{
            HStack{
                Button(action:{
                    
                }){
                    Text("\(user.name)")
                }
                Button(action: {
                    if(user.isFollwing){
                        user.isFollwing = false
                        unfollow(userId: user.id)
                    }else{
                        user.isFollwing = true

                        follow(userId: user.id)
                    }
                }){
                    if(user.isFollwing){
                        Image(systemName: "person.badge.plus")
                    }else{
                        Image(systemName: "person.badge.minus")
                    }
                }
            }
            HStack{
                if(user.isFollower){
                    Text("フォローされています")
                }else{
                    Text("フォローされていません")
                }
            }.font(.caption2)
        }
    }

   
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ForEach(users){ user in
                        UserCellView(user: user)
                        Spacer()

                    }

                }

            }
        }



    }
}

//struct UsersList_Previews: PreviewProvider {
//    static var previews: some View {
//        UsersList(users,isFollowList: false)
//    }
//}

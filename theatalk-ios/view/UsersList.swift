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
    var isFollowList:Bool
    var Followdel:UserRelationshipdel
    var body: some View {
        HStack{
            Button(action: {
                print(user)
                //move to user profile
            }){
                Text("\(user.name)")
            }
            HStack{
                Button(action:{
                    if(user.isFollwing){
                        user.isFollwing = false
                        Followdel.unfollow(userId: user.id)
                    }else{
                        user.isFollwing = true
                        Followdel.follow(userId: user.id)
                    }
                }){
                    if(user.isFollwing){
                        Text("フォロー中")
                    }else{
                        Text("フォローする")
                    }
                }
                if(user.isFollowed){
                    Text("フォローされています")
                }else{
                    Text("フォローされていません")
                }
            }.font(.caption2)


            
        }
        
    }
}

struct UsersList: View,UserRelationshipdel {
    func follow(userId: Int) {
        
    }
    
    func unfollow(userId: Int) {
        
    }
    
    @State var users:[User]
    var isFollowList:Bool
   
    var body: some View {
        ScrollView{
            VStack{
                ForEach(users){ user in

                    UserCell(user:user,isFollowList: isFollowList,Followdel:self)
                    Spacer()

                }
            }

        }

    }
}

struct UsersList_Previews: PreviewProvider {
    static var previews: some View {
        UsersList(users: mockUsersData,isFollowList: false)
    }
}

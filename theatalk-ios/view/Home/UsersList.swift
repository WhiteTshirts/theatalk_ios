//
//  UsersList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/14.
//

import SwiftUI

struct UsersList: View {
    
    @State var users:[User]
    var userRelation:UsersRelationShip!
    func Follow(index:Int){
        let _user = users[index]
        _user.isFollwing = true
        users[index] = _user
        userRelation.Follow(userId: users[index].id)
        
    }
    func UnFollow(index:Int){
        let _user = users[index]
        _user.isFollwing = false
        users[index] = _user
        userRelation.UnFollow(userId: users[index].id)
        
    }
    
    func UserCellView(user:User,index:Int) -> some View{
        VStack{
            HStack{
                Button(action:{
                    
                }){
                    user.image.resizable().frame(width: 15, height: 15, alignment: .center)
                    Text("\(user.name)")
                }
                Button(action: {
                    if(user.isFollwing){
                        self.UnFollow(index: index)
                    }else{
                        self.Follow(index: index)

                    }
                }){
                    if(user.isFollwing){
                        Image(systemName: "person.badge.minus").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }else{
                        Image(systemName: "person.badge.plus").foregroundColor(.red)
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
                    ForEach(users.indices){ index in
                        UserCellView(user: users[index],index: index)
                        Spacer()

                    }

                }

            }
        }



    }
}
//
struct UsersList_Previews: PreviewProvider {
    static var previews: some View {
        UsersList(users: mockUsersData, userRelation:nil )
    }
}

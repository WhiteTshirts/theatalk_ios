//
//  ChatRoom.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/27.
//

import SwiftUI
import UIKit
import WebKit
import YoutubePlayer_in_WKWebView
struct MoveToChatRoom: View{
    @ObservedObject var room:Room
    @State private var playerSize: CGSize = .zero
    @State var action:PlayerAction = .play
    @State var time_offset:Int = 0
    func Caltime_offset(){
        if let stime = room.start_time{
            time_offset = Int(Date().timeIntervalSince(room.start_time))

        }
    }
    func addSelf(){
        room.users.append(User(name_: UserProfile().username, user_id: UserProfile().user_Id))
    }
    var body: some View{
        
        PlayerView(action:$action, videoId: self.$room.youtube_id, time_offset: $time_offset).frame(width: playerSize.width, height: playerSize.height).onDisappear(){
            self.action = .stop
        }.onAppear(){
            Caltime_offset()
            addSelf()
        }
        ChatArea(room: room)
            .onAppear(){
                let frame = UIApplication.shared.windows.first?.frame ?? .zero
                playerSize = CGSize(
                    width: frame.width, height: frame.width/16*9
                )
            }

    }
}

struct ChatCell: View{

    init(chat:Chat){
        self.chat = chat
        self.userVM.GetUser(userId: chat.user_id)
    }
    var chat:Chat
    @ObservedObject var userVM = UserViewModle()
    var body: some View{
        ZStack{
                HStack{
                    if(self.userVM.user.name==""){
                            ProgressView("Now Loading...")
                    }else{
                        VStack{
                            self.userVM.user.image.resizable().frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text(self.userVM.user.name)
                        }
                    }
 
                    Text(chat.text)
                }
        }
    }
}
struct ChatArea: View,UsersRelationShip {
    func Follow(userId: Int) {
        self.ChatsVm.Follow(userId: userId)
    }
    
    func UnFollow(userId: Int) {
        self.ChatsVm.UnFollow(userId: userId)
    }

    @ObservedObject var room: Room
    @ObservedObject var ChatsVm: ChatsViewModel = ChatsViewModel()
    @State var IsSuccess = false
    @State var text = ""

    var ChatView: some View{
        ForEach(ChatsVm.chats.indices, id: \.self){ index in
            HStack{
                ChatCell(chat: ChatsVm.chats[index])
                
            }.id(index)
        }
    }
    var body: some View {
        VStack{
            if((self.room.users) != nil){
                NavigationLink(
                    
                    destination: UsersList(users:self.room.users, userRelation: self),
                    label: {
                        Text("ルーム内:\(self.room.users.count)人")
                    })

            }
            ScrollViewReader { value in
            List {
                ChatView
                }
                VStack{
                    TextField("コメントを入力してください", text: $text,
                              onCommit: {
                                self.ChatsVm.SendMsg(msg: self.text,roomId: room.id)
                                self.text = ""
                                value.scrollTo(0, anchor: .top)
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
            }.padding()

            

        }.onAppear(perform: {

        
        })
        .onDisappear(perform: {
            self.ChatsVm.exit()
            
        })
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatArea( room:mockRoomsData[0])
    }
}

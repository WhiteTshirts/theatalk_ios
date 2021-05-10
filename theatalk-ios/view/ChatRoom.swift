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
    var body: some View{
        ChatRoom(room: room)

    }
}
struct ChatRoom: View,UsersRelationShip {
    func Follow(userId: Int) {
        self.ChatsVm.Follow(userId: userId)
    }
    
    func UnFollow(userId: Int) {
        self.ChatsVm.UnFollow(userId: userId)
    }
    @State private var playerSize: CGSize = .zero
    @State var action:PlayerAction = .play
    @ObservedObject var room: Room
    @ObservedObject var ChatsVm: ChatsViewModel = ChatsViewModel()
    @State var IsSuccess = false
    @State var text = ""

    var ChatView: some View{
        ForEach(ChatsVm.chats.indices, id: \.self){ index in
            HStack{
                if let user_name = ChatsVm.chats[index].user_name{
                    Text("\(user_name)さん:\(ChatsVm.chats[index].text)")
                        .font(.caption)
                }else{
                    Text("名前読み込み中:\(ChatsVm.chats[index].text)")
                        .font(.caption)
                }
            }.id(index)
        }
    }
    var body: some View {
        VStack{

            PlayerView(action:$action, videoId: self.$room.youtube_id).frame(width: playerSize.width, height: playerSize.height).onDisappear(){
                self.action = .stop
            }
            NavigationLink(
                destination: UsersList(users:self.room.users, userRelation: self),
                label: {
                    Text("ルーム内:\(self.room.users.count)人")
                })
            ScrollViewReader { value in
            List {
                    
                ForEach(ChatsVm.chats.indices, id: \.self){ index in
                    HStack{
                        if let user_name = ChatsVm.chats[index].user_name{
                            Text("\(user_name)さん:\(ChatsVm.chats[index].text)")
                                .font(.caption)
                        }else{
                            Text("名前読み込み中:\(ChatsVm.chats[index].text)")
                                .font(.caption)
                        }
                    }.id(index)
                }.onAppear{
                }
                    
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
            let frame = UIApplication.shared.windows.first?.frame ?? .zero
            playerSize = CGSize(
                width: frame.width, height: frame.width/16*9
            )
        
        })
        .onDisappear(perform: {
            self.ChatsVm.exit()
            
        })
    }
}

//struct ChatRoom_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRoom( room:mockRoomsData[0])
//    }
//}

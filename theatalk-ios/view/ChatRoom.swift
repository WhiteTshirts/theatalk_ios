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
    var room:Room
    var body: some View{
        Text("\(room.users.count)")
        ChatRoom(room: room)

    }
}
struct ChatRoom: View {
    var room: Room
    var Youtubeplayer:YoutubePlayer
    @ObservedObject var ChatsVm: ChatsViewModel
    @State var IsSuccess = false
    @State var text = ""
    init(room:Room){
        self.room = room
        self.ChatsVm = ChatsViewModel()
        self.Youtubeplayer = YoutubePlayer(videoID: room.youtube_id,start_time: 100)
    }
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
            Youtubeplayer.frame(height:200)
            NavigationLink(
                destination: UsersList(users:self.room.users),
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
            
        
        })
        .onDisappear(perform: {
            self.ChatsVm.exit()
            
        })
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom( room:mockRoomsData[0])
    }
}

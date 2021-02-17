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
struct ChatRoom: View {
    var room: Room
    var player = WKYTPlayerView()
    @ObservedObject var ChatsVm = ChatsViewModel(room_Id: 0)
    @State var text = ""
    init(room:Room){
        self.room = room
    }
    var body: some View {
        VStack{
            YoutubePlayer(videoID: room.youtube_id).frame(height:200)
            Text("\(room.viewer)人が視聴中").onAppear{
                
                ChatsVm.load(room_Id: room.id)
            }
            ScrollViewReader { value in
                List {
                        ChatViewList()

                    
                }
            TextField("コメントを入力してください", text: $text,
                      onCommit: {
                        ChatsVm.SendMsg(msg: self.text,roomId: room.id)
                        self.text = ""
                        value.scrollTo(0, anchor: .top)
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
            

        }.onAppear(perform: {
            ChatsVm.enter()
        
        })
        .onDisappear(perform: {
            ChatsVm.exit()
            
        })
    }
    func ChatViewList()-> some View{
        let chats = ChatsVm.chats
        return ForEach(chats.indices, id: \.self){ index in
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
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom( room:mockRoomsData[0])
    }
}

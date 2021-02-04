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
    @ObservedObject var ChatsVm: ChatsViewModel
    @State var comment = ""
    var body: some View {
        VStack{
            YoutubePlayer(videoID: room.youtube_id).frame(height:200)
            Text("\(room.viewer)人が視聴中")
            List {
                ForEach(ChatsVm.chats){
                    chat in
                    if let user_name = chat.user_name{
                        Text("\(user_name)さん:\(chat.comment)")
                            .font(.caption)
                    }else{
                        Text("名前読み込み中:\(chat.comment)")
                            .font(.caption)
                    }
                }
            }
            TextField("コメントを入力してください", text: $comment,
                      onCommit: {
                        ChatsVm.SendMsg(msg: self.comment)
                        
                        
                        
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            

        }

        

    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(room:mockRoomsData[0],ChatsVm: ChatsViewModel())
    }
}

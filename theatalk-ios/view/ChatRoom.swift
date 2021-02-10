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
    @State var text = ""
    var body: some View {
        VStack{
            YoutubePlayer(videoID: room.youtube_id).frame(height:200)
            Text("\(room.viewer)人が視聴中").onAppear{
                ChatsVm.load(room_Id: room.id)
            }
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
       
                            
                    }
                    
                }
            
            TextField("コメントを入力してください", text: $text,
                      onCommit: {
                        //print("\(text)")
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

        

    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(room:mockRoomsData[0],ChatsVm: ChatsViewModel(room_Id: 0))
    }
}

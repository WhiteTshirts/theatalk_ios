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

    var body: some View {
        VStack{
            YoutubePlayer(videoID: room.youtube_id).frame(height:200)
            List {
                ForEach(0..<30) {(row: Int) in
                    Text("comment \(row)")
                        
                }
            }
        }

        

    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(room:mockRoomsData[0])
    }
}

//
//  ChatRoom.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/27.
//

import SwiftUI

struct ChatRoom: View {
    var room: Room
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(room: Room(name: "test", id: 1, youtube_url: "test", author: "ttest", tags: [0,1], image_url: "test"))    }
}

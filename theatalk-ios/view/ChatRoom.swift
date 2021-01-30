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
        Text(room.name)
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(room:mockRoomsData[0])
    }
}

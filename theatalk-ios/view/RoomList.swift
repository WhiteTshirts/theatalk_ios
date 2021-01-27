//
//  RoomList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import SwiftUI

struct RoomList: View {
    @EnvironmentObject var roomData: ModelData

    var body: some View {

        List{
            ForEach(roomData.rooms){room in
                NavigationLink(
                    destination: ChatRoom(room:room)){
                    Text(room.name)
                    //RoomCell(room: room)
                }
            }
        }
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
            .environmentObject(ModelData())
            .previewLayout(.fixed(width: 300, height: 300))
    }
}

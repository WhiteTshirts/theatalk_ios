//
//  RoomList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import SwiftUI
import UIKit

struct RoomList: View {

    var rooms: [Room]
    var delegate: EnterRoomDele
    var body: some View{
        ForEach(rooms){room in
            HStack{
                NavigationLink(
                    destination: ChatRoom(room:room,ChatsVm: ChatsViewModel(room_Id: room.id)).onAppear{
                        
                        delegate.enterroom(room_num: room.id)
                    }){
                    RoomCell(room: room)
                }
            }
        }
    }

}

//
//struct RoomList_Previews: PreviewProvider {
//    static var previews: some View {
//                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
//            RoomList(rooms: mockRoomsData)
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
//    }
//}
//


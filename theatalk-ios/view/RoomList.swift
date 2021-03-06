//
//  RoomList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import SwiftUI
import UIKit

struct RoomList: View {
    @ObservedObject var RoomsVM: RoomsViewModel

    var body: some View{
        if(RoomsVM.rooms.isEmpty){
            Image(systemName: "hourglass").resizable()
        }else{
            ForEach(RoomsVM.rooms){room in
                HStack{
                    NavigationLink(
                        destination: ChatRoom(room:room,ChatsVm: ChatsViewModel(room_Id: room.id)).onAppear{
                            
                            enterroom(room_num: room.id)
                        }){
                        RoomCell(room: room)
                    }
                }
            }.onAppear(){
            }
        }

    }
    func enterroom(room_num:Int){
        RoomsVM.EnterRoom(roomID_:room_num)
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


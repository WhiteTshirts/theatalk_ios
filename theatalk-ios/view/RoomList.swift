//
//  RoomList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import SwiftUI
import UIKit
struct RoomList: View {
    @ObservedObject var RoomsVM:RoomsViewModel
    @Binding var tagId:Int
    @Binding var IsSelected:Bool
    var body: some View{
        if(RoomsVM.rooms.isEmpty && RoomsVM.isLoading){
            Image(systemName: "hourglass").resizable()
                .scaledToFit()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }else{
            ForEach(RoomsVM.rooms){room in
                HStack{
                    NavigationLink(
                        destination: MoveToChatRoom(room:room, RoomsVM: RoomsVM)
                        ){
                        RoomCell(room: room)
                    }
                }
            }.onAppear(){
            }.onChange(of: self.tagId, perform: { value in
                print("value")
                print(value)
                if(value > 0){
                    RoomsVM.SetTagId(tagId: value)
                    RoomsVM.GetRoomsByTagId(tagId: value)
                    print("tag")
                }else{
                    print("all")
                    RoomsVM.SetTagId(tagId: 0)
                    RoomsVM.GetallRooms()
                }

            })
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


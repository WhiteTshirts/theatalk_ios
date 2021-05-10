//
//  RoomList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import SwiftUI
import UIKit
struct RoomList: View {
    
    @ObservedObject var RoomsVM:RoomsViewModelBase
    @Binding var tagId:Int
    @State var toChatView = false
    var body: some View{
        if(RoomsVM.isLoading){
            Image(systemName: "hourglass").resizable()
                .scaledToFit()
                .frame(width: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }else{
            ForEach(RoomsVM.rooms.indices, id:\.self){index in
                HStack{
                    Button(action:{
                        RoomsVM.EnterRoom(roomID_: RoomsVM.rooms[index].id)
                        toChatView=true
                    },label:{
                        RoomCell(room:RoomsVM.rooms[index])
                    })
                    NavigationLink(destination:MoveToChatRoom(room:self.$RoomsVM.rooms[index]),isActive:$toChatView){
                        EmptyView()
                    }

                }
                Spacer()
            }
        }

    }

}


//struct RoomList_Previews: PreviewProvider {
//
//    static var previews: some View {
//                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
//                    RoomList(RoomsVM: RoomsViewModel(), tagId:i, IsSelected:j)
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
//    }
//}
//
//

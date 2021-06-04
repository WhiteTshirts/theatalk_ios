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
    @State var toChatView = -1
    var body: some View{
        VStack{
            if(RoomsVM.isLoading){
                Image(systemName: "hourglass").resizable()
                    .scaledToFit()
                    .frame(width: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }else{
                ForEach(RoomsVM.rooms.indices, id:\.self){index in
                    HStack{
         
                        NavigationLink(destination:MoveToChatRoom(room:self.RoomsVM.rooms[index])){
                            RoomCell(room:self.RoomsVM.rooms[index])
                        }.simultaneousGesture(TapGesture().onEnded{
                            RoomsVM.EnterRoom(roomID_: self.RoomsVM.rooms[index].id)

                        })

                    }
                    Spacer()
                }
            }
        }.onAppear(){
            RoomsVM.refresh()
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

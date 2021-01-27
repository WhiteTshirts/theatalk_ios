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
        NavigationView{
            List{
                ForEach(roomData.rooms){
                    room in
                    NavigationLink(
                        destination: ChatRoom()){
                        RoomCell()
                        Text("1")
                    }
                }
            }
        }
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
    }
}

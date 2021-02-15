//
//  CreateRoom.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/06.
//

import SwiftUI

struct CreateRoom: View {
    @State var RoomName:String=""
    @State var Youtubelink:String=""
    @State var StartDate = Date()
    @ObservedObject var CrateRoomVM = CreateRoomViewModel()

    func PostRoom(){
        var youtube_id = ParseYoutubeurl(url: Youtubelink)
        if let youtube_id = ParseYoutubeurl(url: Youtubelink){
            var room  = Room(name: RoomName, start_time: StartDate, youtube_id: youtube_id)
            CrateRoomVM.CreateRoom(room: room)
        }else{
            
        }
    }
    var body: some View {
        VStack{
            HStack{
                Text("Room名")
                TextField("hogehoge", text: self.$RoomName)

            }
            HStack{
                Text("Youtubeリンク")
                TextField("https://www.youtube.com/watch?v=jNQXAC9IVRw&ab_channel=jawed", text: self.$Youtubelink)

            }
            
            DatePicker("開始時刻",selection:$StartDate)
            Button("登録", action: {
                PostRoom()
            })

            

        }
        .padding(.horizontal, 30.0)
        
    }
}

struct CreateRoom_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoom()
    }
}

//
//  CreateRoom.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/06.
//

import SwiftUI
import Kingfisher

struct RoomTagManageView: View{
    @State var room:Room
    var body: some View {
        Text("")
    }
}
struct CreateRoom: View,RoomFormat {
    func ConfirmRoom() {
        var youtube_id = ParseYoutubeurl(url: Youtubelink)
        if let youtube_id = ParseYoutubeurl(url: Youtubelink){
            self.YoutubeId = youtube_id
            var room  = Room(name: RoomName, start_time: StartDate, youtube_id: youtube_id)
            CrateRoomVM.CreateRoom(room: room)
            
        }else{
            
        }
    }
    
    func isSucceeded() -> Bool {
        return true
    }
    
    @State var RoomName:String=""
    @State var Youtubelink:String=""
    @State var StartDate = Date()
    @State var YoutubeId:String=""
    @ObservedObject var CrateRoomVM = CreateRoomViewModel()

    var body: some View {
        RoomForm(RoomName: self.$RoomName, Youtubelink: self.$Youtubelink, StartDate: self.$StartDate, YoutubeId: self.$YoutubeId, roomFormat: self, CrateRoomVM: self.CrateRoomVM)
        
    }
}

struct CreateRoom_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoom(RoomName:"", Youtubelink: "", YoutubeId: "")
    }
}

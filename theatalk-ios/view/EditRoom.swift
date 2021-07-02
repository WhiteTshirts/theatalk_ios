//
//  EditRoom.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/07/01.
//

import SwiftUI

struct EditRoom: View,RoomFormat {
    @Binding var RoomName:String
    @Binding var Youtubelink:String
    @Binding var StartDate:Date
    @Binding var YoutubeId:String
    @Binding var roomTags:[Tag]
    @ObservedObject var EditRoomVM = EditRoomViewModel()
    
    func ConfirmRoom() {
        var youtube_id = ParseYoutubeurl(url: Youtubelink)
        if let youtube_id = ParseYoutubeurl(url: Youtubelink){
            self.YoutubeId = youtube_id
            var room  = Room(name: RoomName, start_time: StartDate, youtube_id: youtube_id)
            room.tags = self.roomTags
            EditRoomVM.CreateRoom(room: room)
            
        }else{
            
        }
    }
    
    func isSucceeded() -> Bool {
        return true
    }
    var body: some View {
        
        RoomForm(RoomName: self.$RoomName, Youtubelink: self.$Youtubelink, StartDate: self.$StartDate, YoutubeId: self.$YoutubeId, roomTags: self.$roomTags, roomTagVM: RoomTagsViewModel(Id: 0), roomFormat: self, RoomVM: EditRoomVM)
        
    }
}


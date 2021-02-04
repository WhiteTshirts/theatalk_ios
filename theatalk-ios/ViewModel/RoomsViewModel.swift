//
//  RoomsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
import Combine

var a=[1]

var mockRoomsData:[Room] = [Room(admin_id_:0,name_:"test1",id_:0,is_private_: false,start_time_: Date(), viewer_: 3,youtube_id_:"kgeG9kXFb0A"),Room(admin_id_:0,name_:"test2",id_:1,is_private_: false,start_time_: Date(), viewer_: 3,youtube_id_:"ofk4W8vDVMg"),Room(admin_id_:0,name_:"test3",id_:3,is_private_: false,start_time_: Date(), viewer_: 3,youtube_id_:"MrgRPzaD5nQ"),Room(admin_id_:0,name_:"test4",id_:4,is_private_: false,start_time_: Date(), viewer_: 3,youtube_id_:"kgeG9kXFb0A")]

final class RoomsViewModel: ObservableObject{
    @Published var rooms: [Room] = []
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")

    func load(){
        roomfetcher.fetchRoomData{
            returnData in
            print(returnData)
            self.rooms = returnData
        }
    }
    
    
}

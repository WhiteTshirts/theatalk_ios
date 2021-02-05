//
//  RoomsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
import Combine

final class RoomsViewModel: ObservableObject{
    @Published var rooms: [Room] = []
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")

    func load(){
        self.rooms = mockRoomsData
//        roomfetcher.fetchRoomData{
//            returnData in
//            print(returnData)
//            self.rooms = returnData
//        }
    }
    
    
}

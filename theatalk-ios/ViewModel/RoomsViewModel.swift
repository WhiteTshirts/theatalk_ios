//
//  RoomsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
import Combine

final class RoomsViewModel: ObservableObject{
    private var disposables = Set<AnyCancellable>()

    @Published var rooms: [Room] = []
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")
    init(){
        roomfetcher.GETRooms()
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] rooms in
            guard let self = self else { return }
            self.rooms = rooms.rooms
        })
        .store(in: &disposables)
    }
    func load(){
        //self.rooms = mockRoomsData
//        roomfetcher.fetchRoomData{
//            returnData in
//            self.rooms = returnData
//        }
    }
    func EnterRoom(roomID_:Int){
        roomfetcher.EnterRoom(roomId: roomID_)
    }
    
    
}

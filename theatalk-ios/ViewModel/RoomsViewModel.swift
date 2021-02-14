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
    @Published var isLoading = false
    @Published var rooms: [Room] = []
    private var tagId:Int?
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")
    init(tagId:Int){
        if(tagId>0){
            self.tagId = tagId
        }
        self.isLoading = true
        roomfetcher.GETRooms()
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.isLoading = false
                self.rooms = []
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] rooms_json in
            guard let self = self else { return }
            self.rooms = rooms_json.rooms
            self.isLoading = false
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

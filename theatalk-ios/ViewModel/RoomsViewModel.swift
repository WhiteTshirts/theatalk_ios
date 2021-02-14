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
    var tagId:Int?
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")
    init(){
        GetallRooms()
    }
    
    func SetTagId(tagId:Int){
        self.tagId = tagId
    }
    func GetallRooms(){
        self.rooms = mockRoomsData
//        self.isLoading = true
//        roomfetcher.GETRooms()
//            .receive(on: DispatchQueue.main)
//            .sink(
//          receiveCompletion: { [weak self] value in
//            guard let self = self else { return }
//            switch value {
//            case .failure:
//                self.isLoading = false
//                self.rooms = []
//              break
//            case .finished:
//              break
//            }
//          },
//          receiveValue: { [weak self] rooms_json in
//            guard let self = self else { return }
//            self.rooms = rooms_json.rooms
//            self.isLoading = false
//            print(self.rooms)
//          })
//        .store(in: &disposables)
    }
    func GetRoomsByTagId(tagId:Int){
        self.isLoading = true
        roomfetcher.GETRoomsbyTag(tagId: tagId)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            print(value)
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
    func EnterRoom(roomID_:Int){
        roomfetcher.EnterRoom(roomId: roomID_)
    }
    
    
}

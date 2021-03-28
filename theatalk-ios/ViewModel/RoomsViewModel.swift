//
//  RoomsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
import Combine
final class CreateRoomViewModel: ObservableObject{
    @Published var isLoading = false
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")
    private var disposables = Set<AnyCancellable>()
    init(){
        
    }
    func CreateRoom(room:Room){
        roomfetcher.CreateRoom(room: room)
            .sink(receiveCompletion: { completion in
            print("receiveCompletion:", completion)
        }, receiveValue: { [self] room_json in
            var room = room_json.room//成功したら作成したルームに入る
        }).store(in: &disposables)
    }
}

final class RoomsViewModel: ObservableObject{
    private var disposables = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var isSuccessed = false
    @Published var rooms: [Room] = []
    var tagId:Int?
    private var roomfetcher = RoomFetcher(url: "http://localhost:5000/api/v1/rooms")
    init(){
        GetallRooms()
    }
    
    func SetTagId(tagId:Int){
        self.tagId = tagId
    }
    func refresh(){
        
    }
    func GetallRooms(){
        self.isLoading = true
        roomfetcher.GETRooms()
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                print(value)
                self.isLoading = false
                self.rooms = []
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] rooms_json in
            guard let self = self else { return }
            if(rooms_json.rooms != nil){
                self.rooms = rooms_json.rooms
            }
            self.isLoading = false
          })
        .store(in: &disposables)
    }
    func GetRoomsByTagId(tagId:Int){
        self.isLoading = true
        roomfetcher.GETRoomsbyTag(tagId: tagId)
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
            if(rooms_json.rooms != nil){

                self.rooms = rooms_json.rooms
            }
            self.isLoading = false
          })
        .store(in: &disposables)
    }
    func EnterRoom(roomID_:Int){//非同期処理の関数に変更する
        roomfetcher.EnterRoom(roomId: roomID_)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.isLoading = false
              break
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] users_json in
            guard let self = self else { return }
          })
        .store(in: &disposables)
    }
    
    
    
}

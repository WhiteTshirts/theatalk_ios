//
//  RoomsViewModel.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/04.
//

import Foundation
import Combine


class RoomsViewModelBase: ObservableObject{
    var disposables = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var rooms: [Room] = []
    @Published var isFailed:Bool = false
    @Published var ErrorMessage = ""
    var roomfetcher = RoomFetcher()
    init(tagId:Int=0){
    }
    func refresh(){
        GetallRooms()
    }
    func ErrorHandle(e:APIError)->String{
        switch e{
            case .token(description: let description):
                return(description)
            case .client(description: let description):
                return(description)
            case .server(description: let description):
                return(description)
                ErrorMessage = description
            case .network(description: let description):
                return(description)
            case .parsing(description: let description):
                return(description)
            case .encoding(description: let description):
                return (description)
            case .other(error: let _):
                return "server unreachable or other error happened"
        }
    }
    func GetallRooms(){
        self.isFailed = false
        roomfetcher.GETRooms()
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure(let error):
                self.ErrorMessage = self.ErrorHandle(e: error)
                self.isFailed = true
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
        self.isFailed = false
        roomfetcher.EnterRoom(roomId: roomID_)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }

            switch value {
            case .failure(let error):
                self.ErrorMessage = self.ErrorHandle(e: error)
                self.isFailed = true
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
final class CreateRoomViewModel: RoomsViewModelBase{
    @Published var createdRoom:Room!
    init(){
        super.init()
        self.createdRoom = nil
    }
    
    func CreateRoom(room:Room){
        roomfetcher.CreateRoom(room: room)
            .sink(receiveCompletion: { completion in
            print("receiveCompletion:", completion)
        }, receiveValue: { [self] room_json in
            self.createdRoom = room_json.room//成功したら作成したルームに入る
            EnterRoom(roomID_: createdRoom!.id)
        }).store(in: &disposables)
    }
}
final class RoomsViewModel: RoomsViewModelBase{
    override init(tagId:Int=0){
        super.init()
        GetallRooms()
    }
    override func GetallRooms() {
        super.GetallRooms()

    }
    override func refresh() {
        self.GetallRooms()
    }
    
}

final class RoomsViewModelHistory: RoomsViewModelBase{
    override init(tagId:Int=0){
        super.init()
        GetallRooms()
    }
    override func refresh() {
        GetallRooms()
    }
    override func GetallRooms() {
        GetRoomsByHistory()
    }
    func GetRoomsByHistory(){
        self.isLoading = true
        roomfetcher.GetRoomsHistory()
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure(let error):
                self.ErrorHandle(e: error)
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
}

final class RoomsViewModelTag: RoomsViewModelBase{
    var tagId:Int?
    
    func SetTagId(tagId:Int){
        self.tagId = tagId
    }
    override func refresh(){
        self.GetallRooms()
    }
    override init(tagId:Int=0){
        super.init()
        self.tagId = tagId
        self.GetallRooms()
    }
    override func GetallRooms() {
        if tagId != nil{
            if(tagId! > 0){
                GetRoomsByTagId(tagId: self.tagId!)
            }else{
                super.GetallRooms()

            }
        }else{
            super.GetallRooms()
        }
    }
    func GetRoomsByTagId(tagId:Int){
        self.isLoading = true
        roomfetcher.GETRoomsbyTag(tagId: tagId)
            .receive(on: DispatchQueue.main)
            .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure(let error):
                self.ErrorHandle(e: error)
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
    
}

